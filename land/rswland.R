f_rsw_out<-function (){

#global r_swc      % Cloud-free r_sw
#global albedo_ld  % Albedo over land
#global cc         % Cloud cover
#global a          % Short wave cloud parameters
#global b          % Short wave cloud parameters

r_sw_out = (r_swc * (1 - albedo_ld) * (1 - (a+b*cc)*cc));

return(r_sw_out)

}
