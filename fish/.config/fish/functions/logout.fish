function logout --wraps='hyprctl dispatch exit' --description 'alias logout hyprctl dispatch exit'
  hyprctl dispatch exit $argv
        
end
