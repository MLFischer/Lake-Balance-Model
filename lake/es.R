f_es_out<- function(t){
  
  # A few constants
  
  a0 = 6984.505294;
  a1 = -188.903931;
  a2 = 2.133357675;
  a3 = -1.288580973E-2;
  a4 = (4.393587233E-5);
  a5 = (-(8.023923082E-8));
  a6 = (6.136820929E-11);
  
  # The equation
  
  es_out=(100.0*(a0+t*(a1+t*(a2+t*(a3+t*(a4+t*(a5+t*a6)))))));
  
  return(es_out)
}