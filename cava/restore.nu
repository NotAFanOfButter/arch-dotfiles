[(cat ~/.config/cava/trunk), (cat ~/.config/cava/default_colours)] | str join "\n" | save -f ~/.config/cava/restored
ln -sf "/home/huginn/.config/cava/restored" "/home/huginn/.config/cava/config"
