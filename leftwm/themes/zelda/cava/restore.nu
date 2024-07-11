
[(bat ~/.config/cava/trunk), (bat ~/.config/cava/default_colours)] | str join "\n" | save -f ./cava/restored
ln -sf "/home/huginn/.config/leftwm/themes/zelda/cava/restored" "/home/huginn/.config/cava/config"
