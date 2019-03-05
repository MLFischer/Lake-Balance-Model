
#global t_s_lk     % Surface Temperature
#global e_lk
#global r_sw       % Net short wave radiation down  
#global mmyr       % Converts evaporation rate from [kg m-^2 s^-1] to
#				  % [mm yr^-1]

#% Best value for t_s

#r_sw=rswlake;

t_s_lk = as.numeric(uniroot(f_net_out,c(270,330))[1])

#% Best value for e_ld

e_lk = mmyr * f_eva_out(t_s_lk)
