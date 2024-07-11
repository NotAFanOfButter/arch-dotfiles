mut leftwm = ""
mut stats = ""
while true {
	let input = (cat ./bar_info.fifo | str trim | parse "{id}:{info}")
	if ($input.id | length) != 0 {
		match $input.id.0 {
			"W" => {$leftwm = $input.info.0},
			"S" => {$stats = $input.info.0}
		}
		$leftwm + "%{r}" + $stats + "  " | print
	}
}
