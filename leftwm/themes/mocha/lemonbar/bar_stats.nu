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
	let open_dull = "%{F#7B819D}"
	let closer = "%{F-}"
	$"($open_dull) ^_^ ($closer)" + $day + $"($open_dull) :3($closer) " + $time
}

def stat_format [stats: record<disk: list<string>, cpu: list<string>, ram: list<string>, bat: list<string>>] {
	let open = {
		peach: "FAB387", red: "F38BA8",
		sapphire: "74C7EC", teal: "94E2D5",
		overlay_1: "7B819D",
	}
	def opener [hex: string] {
		"%{F#" + $hex + "}"
	}
	let closer = "%{F-}"
	def colour_wrap [col1: string, col2: string] {
		let i = $in
		let col1 = opener $col1
		let col2 = opener $col2
		$col1 + $i.1 + $closer
	}
	let open_dull = opener $open.overlay_1
	[
		($stats.disk | colour_wrap $open.peach $open.peach),
		($stats.cpu | colour_wrap $open.teal $open.teal),
		($stats.ram | colour_wrap $open.sapphire $open.sapphire),
		($stats.bat | colour_wrap $open.red $open.red),
	] | reduce {|val, acc| $acc + $open_dull + "_" + $val + $closer}
	# $stats | each {|l| $open.fg + $l.1 + " " + $open.red + $l.0 + $close} | reduce --fold "| " {|val, acc| $acc + $val + " | "}
}

while true {
	let stats_list = {disk: ["", (disk)], cpu: ["", (cpu)], ram: ["", (ram)], bat: ["", (bat)]}
	stat_format $stats_list | $in + (clock) | "S:" + $in + ";;;" | save -f ./bar_info.fifo
	sleep 1sec
}
