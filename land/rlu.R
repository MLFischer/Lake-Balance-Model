f_rlu_out <- function(t){
  
  #global emis_ld    % Surface emissivity
  #global sigma      % Stefan Boltzmann constant
  
  rlu_out=emis_ld*sigma*(t^4);
  
  return(rlu_out)
}