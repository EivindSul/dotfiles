function mvd --wraps='ls ~/Downloads/ | fzf --multi | xargs -I {} mv ~/Downloads/{} .' --description 'alias mvd ls ~/Downloads/ | fzf --multi | xargs -I {} mv ~/Downloads/{} .'
  ls ~/Downloads/ | fzf --multi | xargs -I {} mv ~/Downloads/{} . $argv
        
end
