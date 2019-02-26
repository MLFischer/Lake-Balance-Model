################
# Catchment Analysis 
# M.L.Fischer 03/2018
# takes an endorheic catchment and extracts 
# catchment hypsometry, theoretical lake Bathymetry 
# Ref: Trauth, M.H. (2015) MATLAB Recipes for Earth Sciences – Fourth Edition. Springer, 427 p., 
# Supplementary Electronic Material, Hardcover, ISBN: 978-3-662-46244-7. (MRES)
################

# Sec 1 Preparation
remove(list=ls()) 
library(tiff) 
library(raster)
library(rgdal)
library(rgeos)
library(sp)

# Sec 2 Load data and Prepare
setwd("C:/Users/marku/Desktop/Msc_02_thesis/02_model_project/01_catchment/data")
catch.shp <- readOGR(".",layer = "CHB_polygon_30m") #shapefile (masc)
catch.dem <- raster('SRTM_1arc_utm_ClipCHB.tif') #dem data of catchment
plot(catch.dem);plot(catch.shp,add=T)

# mask the DEM with the shapefile 
catch.dem<-crop(catch.dem,catch.shp)
catch.dem<-mask(catch.dem,catch.shp)
plot(catch.dem);plot(catch.shp,add=T)

# Sec 3 Calculation: hypsometry, volume and lake-area-ratio

# created a dataframe of the frequency of each height (rounded to 1m)
freq<-as.data.frame(freq(catch.dem,digit=1, merge=F))

# cleaning dataset of Chew Bahir
freq <- freq[order(freq[,1]),] 
freq[42,2] <- sum(freq[1:42,2])
freq<-freq[-(1:41),]

# create a sum array of all frequency heights
# all summed pixels below a height means the area below a certain height
for (i in 1:(length(freq[,1])-1))
{freq[i,3]<-sum(freq[1:i,2])}  

# calcute the area by the resolution of the pixels, km²
freq<-freq[-2917,] #delete the last control row
freq[,4]<-freq[,3]*(res(catch.dem)[1]^2)/(1000^2) 

# create a sum array of all frequency area-counts
# the volume means that every pixel below a certain value has 1m³ for each column
for (i in 1:(length(freq[,1]))) 
{freq[i,5]<-sum(freq[1:i,3])}   

freq[,6]<-freq[,5]*(res(catch.dem)[1]^2)/(1000^3) #volume by height
freq[,7]<-freq[2]*(res(catch.dem)[1]^2)/(1000^2)#area per height 
# lake area ratio is the area below height divided throug the catchment size
freq[,8]<- 100*freq[,3]/2173415800 
colnames(freq)<-c("height","pix_by_height","pix_below_height","km²_below_height","pix_vol_below","km³_below","area_by_height","lake area ration")

# Sec 4 Visualization
pdf(file= "08_comb_meta.pdf",width=7 ,height=3,bg="transparent",family="Helvetica")#,paper="a4")
par(mfrow = c(1,3))#,
#    oma = c(4,4,0,0) + 0.1,
#    mar = c(1,1,1,1) + 0.1)

plot(freq[1:2957,1]~freq[1:2957,4],type="l",ylab="Height in m",xlab= "Area in km²")
#polygon( fillOddEven=, border=NA, c(498,freq[1:2957,1]) ~ c(20649.74,freq[1:2957,4]) ,col=rgb(152, 191, 68,alpha=40,max=255))

###
abline(h=543.3,col="darkgrey")
grid(nx = NULL, ny = NULL, col = "lightgray", lty = "dotted",
     lwd = par("lwd"), equilogs = TRUE)
plot(freq[1:50,1]~freq[1:50,6],type="l",ylab="",xlab= "Volume in km³")
abline(h=543.3,col="darkgrey")
grid(nx = NULL, ny = NULL, col = "lightgray", lty = "dotted",
     lwd = par("lwd"), equilogs = TRUE)
plot(freq[1:50,1]~freq[1:50,8],xlim= c(0,0.12),type="l",ylab="",xlab="Lake Area Ratio in %") #lake area ratio zu catchment size
axis (3, at=(c(0.02,0.04,0.06,0.08,0.1,0.12)) ,paste (c(0.98,0.96,0.94,0.92,"0.90",0.88)) )

abline(h=543.3,col="darkgrey")
grid(nx = NULL, ny = NULL, col = "lightgray", lty = "dotted",
     lwd = par("lwd"), equilogs = TRUE)
dev.off()
# save results:

#
dev.copy(png,filename="final.svg");dev.off()
write.csv(freq,"lake_altitude.csv")


