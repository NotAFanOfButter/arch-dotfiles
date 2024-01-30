let current = ( uu-realpath ~/.config/leftwm/themes/current | str trim | path parse | get stem )
let list = ( ls ~/.config/leftwm/themes | get name | where ($it | str contains "current" | not $in) | enumerate )
let next_index = ( $list | find $current | $in.index.0 + 1 | $in mod ($list | length) )
uu-rm ~/.config/leftwm/themes/current; uu-ln -s ($list | get $next_index | get item) ~/.config/leftwm/themes/current
~/.config/leftwm/themes/current/up
