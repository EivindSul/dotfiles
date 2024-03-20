# dotfiles
Run "stow FOLDER" to symlink the configs, where FOLDER is the specific one you want to link. 

This requires a usable GNU-stow install.
Otherwise, you can use ln.
```bash
# From within repository:
git clone git@github.com:EivindSul/dotfiles.git
cd dotfiles

ln hyprland/.config/hyprland ~/.config/hyprland
ln alacritty/.config/alacritty.toml ~/.config/alacritty.toml
# etc...
```

## Prerequesites
These programs should be installed for config files to work properly. They may be aliases or other programs that are used within.

### Hyprland
This config uses hyprpaper and waybar, as well as hyprland's dependencies.
It also uses keybinds to launch rofi and alacritty.
```bash 
# Programs used:
hyprpaper waybar rofi alacritty grim slurp mako

# Dependencies:
# TODO
```

### Terminal and shell
I use fish. I use starship and oh my fish to get prettier and more usable defaults.
I have aliased ls to eza, cd to zoxide, and cat to bat. 
Some scripts also use fzf, so this could be nice to have.
```bash 
# Programs:
eza zoxide bat fzf

# Install oh-my-fish:
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# Install starship:
curl -sS https://starship.rs/install.sh | sh
```

### Zellij
Zellij has become a big part of my workflow, as it does everything that Tmux does but with a more comfortable configuration experience. 
It also integrates runners in a cool way, which lets me easily run multiple commands associated with my project with few keystrokes.

All plugins should be contained within the dotfiles, but may need to be updated manually.
```bash 
# Programs:
zellij

# Update plugins:
# TODO
```

### Neovim
Neovim is my editor of choice.
My plan currently is to add some debugging and testing capabilties and integrate it better with zellij,
to make my terminal the smoothest IDE experience I can make it.

TODO: Move neovim from its own repository to here.
```bash 
# Programs:
neovim fzf ripgrep 

# Requirements:
# Terminal emulator with truecolor enabled

# Dependencies for LSPs:
npm
```
