##--------------------------------------------------------------------------
## NEW LAKE BALANCE MODEL BY MARTIN TRAUTH, AUGUST 2007
##--------------------------------------------------------------------------

#--------------------------------------------------------------------------
# VARIABLES AND CONSTANTS (CALC = WILL BE COMPUTED BY THE ALGORITHM)
#--------------------------------------------------------------------------
# CHAMO LAKE
#t_s_lk   = CALC      # Temperature on water surface
t_a_lk    = 295.1;    #chamo # Air Temperature in [K] modern conditions mean (1)
                      # Average 29 deg C from gridded values (1)
#r_sw     = CALC      # Net short wave radiation down  
#r_lup    = CALC      # Net long wave radiation up
#r_ldw    = CALC      # Net long wave radiation down
emis_lk   = 0.98;     # Surface emissivity (2) *OK*
#h        = CALC      # Sensible heat rate
l         = 2.4E6;    #FIX# Latent heat of vaporization in [J kg-1] (4) (FIX)
r_swc     = 415;      # Cloud-free r_sw in [W/m2]  (6,7)
albedo_lk = 0.06;     # Albedo over water in [#] (2) *OK*
sigma     = 5.67E-8;  #FIX# Stefan Boltzmann constant in [kg s-3 K-4] (FIX)
rh        = 0.57      #chamo # Relative humidity in [#/100] (1) *OK*
f_lk      = 1.00;     #FIX# Moisture avail function over water in [#/100] (FIX)
#es       = CALC      # Saturation vapour pressure
cc        = 0.37;     #chamo Cloud cover in [#/100] (2) *OK*
a         = 0.39;     # Short wave cloud parameters
b         = 0.38;     # Short wave cloud parameters
a_2       = 0.22;     # Long wave cloud parameters
b_2       = 2.00;     # Long wave cloud parameters
ws        = 1.71      #chamo # Wind speed in 10 m above ground (3.2+/-0.1 m/s) (1)
cds       = 7.3E-4;   # Surface drag coefficient (9, Bookhg et al., p 120)
cp        = 1005.0;   #FIX# Specific heat capacity of dry air [kJ/kg K] (FIX)
p         = 88695     #Chamo # Air pressure in [Pa] (5)
r         = 287.0;    #FIX# Gas constant for dry air in [J/K kg] (FIX)
mmyr      = 3.1536E7  #FIX# Converts evaporation rate from [kg m-^2 s^-1] to
		      		        # [mm yr^-1] (FIX)

#--------------------------------------------------------------------------
# References
#--------------------------------------------------------------------------

# (1) New, M., Lister, D., Hulme, M., Makin, I., 2002, Climate Research,
#     21, 1-25. Gridded 10 minute climate data.
# (2) Hastenrath, S., Kutzbach, J.E., 1983, Quaternary Research, 19, 141-
#     153. Values for Turkana in comparison with Victoria, Naivasha and
#     Nakuru-Elmenteita
# (3) http://www.engineeringtoolbox.com/air-properties-d_156.html
# (4) As l varies only slightly over normal temperature ranges a single
#     value of 2.45 MJ kg-1 is taken for the simplification. This is the
#     latent heat for an air temperature of about 20 deg C.
#     Equation for calculation see Mathess & Ubell (1983), p 278:
#     l = 2500.84 - 2.38*T(water) where the temperature of water is in
#     degrees Celsius.
# (5) http://wetter.andreae-gymnasium.de/interaktives/Druck
# new2017: https://www.mide.com/pages/air-pressure-at-altitude-calculator
#     /barometrische.htm
#     Altitude Lake m  Temperature C  Air pressure hPa
#     275              29             982.1
#     575              25             949.0
# (6) Brigg, 1990, see Bergner Diplomarbeit page 49+61
# (7) Griffiths, 1972, see Bergner Diplomarbeit page 49+61
# (8) see Table Bergner Diplomarbeit, page 58
#     Moisture availability function over water always 1.0
# (9) Schmugge and Andre, page 9-10



