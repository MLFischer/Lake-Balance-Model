f_heat_out<- function(t){

#global t_a_lk     % Air Temperature in [K] modern conditions mean
#global ws         % Wind speed 
#global cds        % Surface drag coefficient
#global cp         % Specific heat of dry air 
#global p          % Air pressure 
#global r          % Gas constant for dry air 

heat_out=(((p*cds*ws*cp)*(t-t_a_lk))/(r*t_a_lk));

return(heat_out)
}