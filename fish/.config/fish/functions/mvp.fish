function mvp --wraps='ls ~/Pictures/ | fzf --multi | xargs -I {} mv ~/Pictures/{} .' --description 'alias mvp ls ~/Pictures/ | fzf --multi | xargs -I {} mv ~/Pictures/{} .'
  ls ~/Pictures/ | fzf --multi | xargs -I {} mv ~/Pictures/{} . $argv
        
end
