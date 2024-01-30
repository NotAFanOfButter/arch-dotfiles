def percent_format [] {
	$in * 100 | math round | into string | split chars | if ($in | length) == 1 {$in | prepend "0"} else {$in} | reduce {|i, acc| $acc + $i}
}

def ram [] {
	$in | get mem | $in.used / $in.total | percent_format
}
def bat [] {
	cat /sys/class/power_supply/BAT0/capacity | into int | $in / 100.0 | percent_format
}
def cpu [] {
	$in | get cpu | get cpu_usage | reduce {|num, acc| $num + $acc} | $in / 800.0 | percent_format
}
def disk [] {
	$in | get disks.0 | 1.0 - ($in.free / $in.total) | percent_format
}
def clock [] {
	let date = date now
	let day = $date | format date '%d'
	let time = $date | format date '%R'
	let open_white = "%{F#a39d5d}"
	let closer = "%{F-}"
	$"($open_white)\(($closer)" + $day + $"($open_white)\)($closer) " + $time
}

def stat_format [stats: record<list<string>>] {
	let open = {
		red: "f46221", fg: "f7f6cb",
		yellow: "fcce5e", blue: "5eb5fc",
		magenta: "b3789f", cyan: "a4e0e4",
		white: "a39d5d", black: "5e8a74",
	}
	def opener [hex: string] {
		"%{F#" + $hex + "}"
	}
	let closer = "%{F-}"
	def colour_wrap [col1: string, col2: string] {
		let i = $in
		let col1 = opener $col1
		let col2 = opener $col2
		$col1 + $i.1 + " " + $col2 + $i.0 + $closer
	}
	let open_white = opener $open.white
	[
		($stats.disk | colour_wrap $open.fg $open.yellow),
		($stats.cpu | colour_wrap $open.fg $open.cyan),
		($stats.ram | colour_wrap $open.fg $open.magenta),
		($stats.bat | colour_wrap $open.fg $open.red),
	] | reduce --fold ($open_white + "| " + $closer) {|val, acc| $acc + $val + $open_white + " | " + $closer}
	# $stats | each {|l| $open.fg + $l.1 + " " + $open.red + $l.0 + $close} | reduce --fold "| " {|val, acc| $acc + $val + " | "}
}

while true {
	let stats_list = sys | {disk: ["\u{f0726}", ($in | disk)], cpu: ["\u{f04e5}", ($in | cpu)], ram: ["\u{f0780}", ($in | ram)], bat: ["\u{f08d0}", (bat)]}
	stat_format $stats_list | $in + (clock) | "S:" + $in | save -f ./bar_info.fifo
	sleep 1sec
}
