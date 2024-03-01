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
	let datetime = date now | format date '[%d] %R'
	$" ($datetime)"
}

def stat_format [stats: record<disk: list<string>, cpu: list<string>, ram: list<string>, bat: list<string>>] {
	let red_open = "%{F#eb544d}"
	let pink_open = "%{F#ffb4fe}"
	let close = "%{F-}"
	$stats | each {|l| $red_open + $l.0 + ":" + $pink_open + $l.1 + $close} | reduce --fold "" {|val, acc| $acc + $val + " "}
}

while true {
	let stats_list = sys | [["SSD", ($in | disk)], ["CPU", ($in | cpu)], ["RAM", ($in | ram)], ["BATT", (bat)]]
	stat_format $stats_list | $in + (clock) | "S:" + $in | save -f ./bar_info.fifo
	sleep 1sec
}
