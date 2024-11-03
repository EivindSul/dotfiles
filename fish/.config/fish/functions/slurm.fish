function slurm --wraps='ssh -J dat351@eple.hvl.no student15@slurmmaster.dat351' --description 'alias slurm ssh -J dat351@eple.hvl.no student15@slurmmaster.dat351'
  ssh -J dat351@eple.hvl.no student15@slurmmaster.dat351 $argv
        
end
