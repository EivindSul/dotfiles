function condor --wraps='ssh -J dat351@eple.hvl.no student15@condormaster.dat351' --description 'alias condor ssh -J dat351@eple.hvl.no student15@condormaster.dat351'
  ssh -J dat351@eple.hvl.no student15@condormaster.dat351 $argv
        
end
