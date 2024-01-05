mut leftwm = ""
mut stats = ""
while true {
	let input = (cat ./bar_info.fifo | parse "{id}:{info}")
	if ($input.id | length) != 0 {
		match $input.id.0 {
			"W" => {$leftwm = ($input.info.0 | split chars | drop 1 | reduce {|it, acc| $acc + $it})},
			"S" => {$stats = $input.info.0}
		}
		$leftwm + "%{r}" + $stats + "  " | print
	}
}
