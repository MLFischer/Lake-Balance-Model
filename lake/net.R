f_net_out <-function(t){

#global t_a_lk     % Air Temperature in [K] modern conditions mean
#global emis_lk    % Surface emissivity
#global l          % Latent heat of vaporization

net_out=(f_rsw_out()-f_rlu_out(t)+emis_lk*f_rld_out(t_a_lk)-f_heat_out(t)-l*f_eva_out(t));

return(net_out)
}