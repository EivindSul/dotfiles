function torque --wraps='ssh -J dat351@eple.hvl.no student15@torquemaster.dat351' --wraps='ssh -J dat351@eple.hvl.no student15@torquew1.dat351' --description 'alias torque ssh -J dat351@eple.hvl.no student15@torquemaster.dat351'
  ssh -J dat351@eple.hvl.no student15@torquemaster.dat351 $argv
        
end
