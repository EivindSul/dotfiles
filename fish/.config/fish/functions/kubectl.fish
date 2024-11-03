function kubectl --wraps='minikube kubectl --' --description 'alias kubectl minikube kubectl --'
  minikube kubectl -- $argv
        
end
