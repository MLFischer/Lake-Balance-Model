f_rlu_out <- function(t){
  
  #global emis_lk    % Surface emissivity
  #global sigma      % Stefan Boltzmann constant
  
  rlu_out=emis_lk*sigma*(t^4);
  
  return(rlu_out)
}