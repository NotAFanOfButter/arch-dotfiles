#! /usr/bin/nu
let cava_dir = "/home/huginn/.config/leftwm/themes/metroid/cava"
[(cat ~/.config/cava/trunk), (cat $"($cava_dir)/colours")] | str join "\n" | save -f $"($cava_dir)/config"
ln -sf $"($cava_dir)/config" "/home/huginn/.config/cava/config"
