def percent_format [] {
	$in * 100 | math round | into string | split chars | if ($in | length) == 1 {$in | prepend "0"} else {$in} | reduce {|i, acc| $acc + $i}
}

def ram [] {
	sys mem | $in.used / $in.total | percent_format
}
def bat [] {
	cat /sys/class/power_supply/BAT0/capacity | into int | $in / 100.0 | percent_format
}
def cpu [] {
	sys cpu | get cpu_usage | reduce {|num, acc| $num + $acc} | $in / 800.0 | percent_format
}
def disk [] {
	sys disks | get 0 | 1.0 - ($in.free / $in.total) | percent_format
}
def clock [] {
	let date = date now
	let day = $date | format date '%d'
	let time = $date | format date '%R'
	let open_yellow = "%{F#fbeb96}%{B#}"
	let closer = "%{F-}%{B-}"
	$"($open_yellow)\u{3014}($closer)" + $day + $"($open_yellow)\u{3015}($closer)" + "%{F#fcf5ad}%{B#51100c}" + $time + $closer
}

def stat_format [stats: record<disk: list<string>, cpu: list<string>, ram: list<string>, bat: list<string>>] {
	let open = {
		orange: "ec8737",
		fg: "ff1300",
		white: "fbf8f1",
		slate: "80b1bf"
	}
	def opener [hex: string] {
		"%{F#" + $hex + "}"
	}
	let closer = "%{F-}"
	def colour_wrap [col: string] {
		let i = $in
		let col = opener $col
		$col + $i.1 + $closer
	}
	let open_slate = opener $open.slate
	let start_stats = (["","\u{300C}"] | colour_wrap $open.white)
	let end_stats = (["","\u{300D}"] | colour_wrap $open.white)
	[
		($stats.disk | colour_wrap $open.fg ),
		($stats.cpu | colour_wrap $open.fg ),
		($stats.ram | colour_wrap $open.fg ),
		($stats.bat | colour_wrap $open.fg ),
	] | {first: $in.0, rest: ($in | skip 1)} | 
	$start_stats + $in.first + (
		$in.rest | reduce --fold "" {|val, acc| $acc + $open_slate + "\u{00B7}" + $closer + $val}
	) + $end_stats
# $stats | each {|l| $open.fg + $l.1 + " " + $open.red + $l.0 + $close} | reduce --fold "| " {|val, acc| $acc + $val + " | "}
}

while true {
	let stats_list = sys | {disk: ["\u{f0726}", (disk)], cpu: ["\u{f04e5}", (cpu)], ram: ["\u{f0780}", (ram)], bat: ["\u{f08d0}", (bat)]}
	stat_format $stats_list | $in + (clock) | "S:" + $in | save -f ./bar_info.fifo
	sleep 1sec
}
