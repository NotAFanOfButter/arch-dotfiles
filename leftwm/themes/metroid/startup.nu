with-env {
SHELL: /usr/bin/nu,
FONT: (wezterm ls-fonts | split row "\n" | get 4 | split chars | drop 2 | skip 3 | str join ""),
LEFTWM_THEME: (uu-realpath ~/.config/leftwm/themes/current/ | path parse | get stem | split chars | str join)
} {neofetch}
