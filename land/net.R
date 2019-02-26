f_net_out <-function(t){

#global t_a_ld     % Air Temperature in [K] modern conditions mean
#global emis_ld    % Surface emissivity
#global l          % Latent heat of vaporization

net_out=(f_rsw_out()-f_rlu_out(t)+emis_ld*f_rld_out(t_a_ld)-f_heat_out(t)-l*f_eva_out(t));

return(net_out)
}