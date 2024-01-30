if ("./bar_info.fifo" | path exists) {
	rm ./bar_info.fifo
}

mkfifo ./bar_info.fifo

# clear all running tasks
pueue kill -g bar
pueue clean

(pueue add -g bar -e -- nu -c '(
	leftwm state -w 0 -t ../template.liquid |
	each {|out| $out | split row "\n" |
		each {|line| (if ($line | str trim | $in != "") {"W:" + $line | save -f ./bar_info.fifo | null})}
	}
)')
(pueue add -g bar -- 'nu ./bar_stats.nu')
(pueue add -g bar -- 'nu ./read.nu | ./lemonbar -p -f "monofur nerd font:weight=bold:size=18" -F "#91db6d" -B "#30504b"')
