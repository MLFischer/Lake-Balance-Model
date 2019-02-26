f_rld_out <-function(t){

#global sigma      % Stefan Boltzmann constant
#global rh         % Relative humidity
#global cc         % Cloud cover
#global a_2        % Long wave cloud parameters
#global b_2        % Long wave cloud parameters

rld_out=1.24*f_nroot_out(((rh*f_es_out(t))/(100.0*t)),7.0)* sigma*(1+a_2*(cc^b_2))*(t^4.0)


return(rld_out)
}

