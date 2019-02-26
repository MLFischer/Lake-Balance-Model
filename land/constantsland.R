#--------------------------------------------------------------------------
# VARIABLES AND CONSTANTS (CALC = WILL BE COMPUTED BY THE ALGORITHM)
#--------------------------------------------------------------------------
#CHAMO  
#t_s_ld   = CALC      # Temperature on land surface
t_a_ld    = 293.3     #chamo  # Air Temperature in [K] modern conditions mean
                      # Average 24.3 deg C from gridded values (1)
#r_sw     = CALC      # Net short wave radiation down  
#r_lup    = CALC      # Net long wave radiation up
#r_ldw    = CALC      # Net long wave radiation down
emis_ld   = 0.96;     #chamo  # Surface emissivity (2) *OK*
#h        = CALC      # Sensible heat rate
l         = 2.45E6;   #FIX Latent heat of vaporization in [J kg-1] (4) (FIX)
r_swc     = 415;      #  # Cloud-free r_sw in [W/m2] (6,7)
albedo_ld = 0.126;    #chamo  # Albedo over land in [%] aus MODIS mean of SW, VIS, NIR
sigma     = 5.67E-8;  #FIX # Stefan Boltzmann constant in [kg s-3 K-4] (FIX)
rh        = 0.57;     #chamo 0.57 # Relative humidity in [#/100] (1) *OK*
f_ld      = 0.1985526;     # cb/x? schätzwert  # Moisture avail function over land in [#/100] (8)
#es       = CALC      # Saturation vapour pressure
cc        = 0.55;     #chamo  # Cloud cover in [#/100] (2) *OK* http://www.earthenv.org/cloud
a         = 0.39;     # Short wave cloud parameters
b         = 0.38;     # Short wave cloud parameters
a_2       = 0.22;     # Long wave cloud parameters
b_2       = 2.00;     # Long wave cloud parameters
ws        = 1.72;     #chamo  # Wind speed in 10 m above ground (3.2+/-0.1 m/s) (1)
cds       =  0.006593684;  #set  # Surface drag coefficient (9)
cp        = 1005.0;   #FIX # Specific heat capacity of dry air [kJ/kg K] (FIX)
p         = 85128     #chamo  # Air pressure in [Pa] (5) #1159.696m a.s.l.
r         = 287.0;    #FIX # Gas constant for dry air in [J/K kg] (FIX)
mmyr      = 3.1536E7  #FIX # Converts evaporation rate from [kg m-^2 s^-1] to
# [mm yr^-1] (FIX)
  
  #--------------------------------------------------------------------------
    # References
  #--------------------------------------------------------------------------
    
    # (1) New, M., Lister, D., Hulme, M., Makin, I., 2002, Climate Research,
  #	  21, 1-25. Gridded 10 minute climate data.
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
  #     575              25            949.0
  #     2700             20            749.7
  # (6) Brigg, 1990, see Bergner Diplomarbeit, page 49+61
  # (7) Griffiths, 1972, see Bergner Diplomarbeit, page 49+61
  # (8) see Table Bergner Diplomarbeit, page 58
  #     Moisture availability function over land difficult to determine
  #     Typical values:
    #     Grassland with bush, some acacia trees      0.1
  #     Forest                                      0.1
  #     Peat bog                                    0.3
  #     Coffee, vegetable plantation                0.4
  #     Bamboo forest, jungle, conifer forest       0.75
  #     Swamps, pypyrus swamps                      0.83
  #     Open waters                                 1.0
  #     The relatively high value for the Suguta Valley can be explained by
  #     large swampy areas, the braided stream and Lake Logipi at least in 
  #     the months after the rainy seasons.
  # (9) Schmugge and Andre, page 9-10
  
  
  
  
  
  
  
  
  
  
  