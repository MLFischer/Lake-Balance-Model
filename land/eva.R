f_eva_out <- function(t){

#global t_a_ld     % Air Temperature in [K] modern conditions mean
#global rh         % Relative humidity
#global f_ld       % Moisture availability function over land
#global ws         % Wind speed 
#global cds        % Surface drag coefficient
#global r          % Gas constant for dry air 

eva_out=(((0.622*cds*ws*f_ld)*(f_es_out(t)-rh*f_es_out(t_a_ld)))/(r*t_a_ld));

return(eva_out)
}