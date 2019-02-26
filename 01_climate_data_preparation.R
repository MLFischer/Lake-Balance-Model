## Climate preparation script
## by ML Fischer 2017
## processing of global gridded climate data by New et al. 2011
## converts the data to GeoTiff and clips to area of interest
remove(list=ls()) #clean up

library(tiff) #just load some packages
library(raster)
library(cruts)
library(rgdal)
library(sp)
library(dplyr)

setwd("C:/Users/marku/Desktop/Msc_02_thesis/02_model_project/00_climate_cru/data")

#catch <- readOGR(".",layer = "abaya_lake") #shapefiles u are interested in
#catch <- readOGR(".",layer = "abaya_polygon_30m") #shapefiles u are interested in
#catch <- readOGR(".",layer = "chamo_polygon_30m") 
#catch <- readOGR(".",layer = "chamo_lake_30m") 
catch <- readOGR(".",layer = "catch_chew") 
#catch <- readOGR(".",layer = "chew_bahir_lake")
#catch<- readOGR(".",layer = "africa")
sr <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0 " 
catch<- spTransform(catch,sr)

#load global precipitation data; 0,5° CRU TS 4.00; http://data.ceda.ac.uk/badc/cru/data/cru_ts/cru_ts_4.00/data/
#predat<-cruts2raster("cru_ts4.00.2011.2015.pre.dat.nc",poly=catch,timeRange = c("2011-01-01","2015-01-01"))#precipitation
#plot(predat[[1:12]])

###############################
#start now with New et al. 2002; 10' spat. resolution; global, 
#download data from: https://crudata.uea.ac.uk/cru/data/hrg/tmc/
#preparation script from: https://gist.github.com/adamhsparks/11284393
#################################
#load the data:
#pre <- read.table("grid_10min_pre.dat", header = FALSE, colClasses = "numeric", nrows = 566262)   # precipitation; use header, colClasses and nrows to speed input into R
#rd0 <- read.table("grid_10min_rd0.dat", header = FALSE, colClasses = "numeric", nrows = 566262)   # wet days >0.1mm, use header, colClasses and nrows to speed input into R
#tmp <- read.table("grid_10min_tmp.dat", header = FALSE, colClasses = "numeric", nrows = 566262)   # mean tmp C, use header, colClasses and nrows to speed input into R
#dtr <- read.table("grid_10min_dtr.dat", header = FALSE, colClasses = "numeric", nrows = 566262)   # diurnal mean temp range, use header, colClasses and nrows to speed input into R
#reh <- read.table("grid_10min_reh.dat", header = FALSE, colClasses = "numeric", nrows = 566262)   # relative humidity %, use header, colClasses and nrows to speed input into R
#sunp<- read.table("grid_10min_sunp.dat", header = FALSE, colClasses = "numeric", nrows = 566262)  # % max. possible sunshine, use header, colClasses and nrows to speed input into R
#frs <- read.table("grid_10min_frs.dat", header = FALSE, colClasses = "numeric", nrows = 566262)   # ground frost, days, use header, colClasses and nrows to speed input into R
#wnd <- read.table("grid_10min_wnd.dat", header = FALSE, colClasses = "numeric", nrows = 566262)   # 10m windspeed m/s, use header, colClasses and nrows to speed input into R

#
pre <- read.table("grid_10min_pre.dat", header = FALSE, colClasses = "numeric")#, nrows = 566262)   # precipitation; use header, colClasses and nrows to speed input into R
rd0 <- read.table("grid_10min_rd0.dat", header = FALSE, colClasses = "numeric")#, nrows = 566262)   # wet days >0.1mm, use header, colClasses and nrows to speed input into R
tmp <- read.table("grid_10min_tmp.dat", header = FALSE, colClasses = "numeric")#, nrows = 566262)   # mean tmp C, use header, colClasses and nrows to speed input into R
dtr <- read.table("grid_10min_dtr.dat", header = FALSE, colClasses = "numeric")#, nrows = 566262)   # diurnal mean temp range, use header, colClasses and nrows to speed input into R
reh <- read.table("grid_10min_reh.dat", header = FALSE, colClasses = "numeric")#, nrows = 566262)   # relative humidity %, use header, colClasses and nrows to speed input into R
sunp<- read.table("grid_10min_sunp.dat", header = FALSE, colClasses = "numeric")#, nrows = 566262)  # % max. possible sunshine, use header, colClasses and nrows to speed input into R
frs <- read.table("grid_10min_frs.dat", header = FALSE, colClasses = "numeric")#, nrows = 566262)   # ground frost, days, use header, colClasses and nrows to speed input into R
wnd <- read.table("grid_10min_wnd.dat", header = FALSE, colClasses = "numeric")#, nrows = 566262)   # 10m windspeed m/s, use header, colClasses and nrows to speed input into R
#
wnd <- wnd[order(wnd[,1],-wnd[,2]),] 
which(wnd[,1]==-59.083)
wnd<-wnd[-c(1:272),]
#####
#which(wnd[,1]!=reh[,1])

#

months <- c('jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec')
##### GIS work ####
## set up a raster object to use as the basis for converting CRU data to raster objects at 10 arc minute resolution ####
wrld <- raster(nrows = 900, ncols = 2160, ymn = -60, ymx = 90, xmn = -180, xmx = 180)

## Create raster objects using cellFromXY and generate a raster stack
## create.stack takes pre, tmp, tmn and tmx and creates a raster object stack of 12 month data
create.stack <- function(wvar, xy, wrld, months){ 
  x <- wrld
  cells <- cellFromXY(x, wvar[,c(2, 1)])
  for(i in 3:14){
    x[cells] <- wvar[, i]
    if(i == 3){y <- x} else y <- stack(y, x)
  }
  names(y) <- months
  return(y)
  rm(x)
}

#create the stacks and remove the raw data
pre.stack <- create.stack(pre, xy, wrld, months);rm(pre)
rd0.stack <- create.stack(rd0, xy, wrld, months);rm(rd0)
tmp.stack <- create.stack(tmp, xy, wrld, months);rm(tmp)
dtr.stack <- create.stack(dtr, xy, wrld, months);rm(dtr)
reh.stack <- create.stack(reh, xy, wrld, months);rm(reh)
sunp.stack <- create.stack(sunp, xy, wrld, months);rm(sunp)
frs.stack <- create.stack(frs, xy, wrld, months);rm(frs)
wnd.stack <- create.stack(wnd, xy, wrld, months);rm(wnd)
##
plot(wnd.stack[[7]])

wnd <- mean (wnd.stack)
tmp<- mean(tmp.stack)


#put them together in one list, so its more easy to access
climate.stacks<-c(pre.stack,rd0.stack,tmp.stack,dtr.stack,reh.stack,sunp.stack,frs.stack,wnd.stack)

######
#look at some beautiful visuaölisiations and enjoy them 
plot(pre.stack$jan)
plot(climate.stacks[[1]]$jan, main="Precipitation in January");plot(catch,add=T)
plot(climate.stacks[[2]]$jan, main="Precipitation in January");plot(catch,add=T)

#####################################################
#just old stuff to check out some raster tools
# masking means deleting but no cutting
#pre_chew<-mask(pre.stack$mar, africa)
#plot(pre_chew)
#cropping means cutting and with masking afterwards u have only the data of your shapefile(catch) u are interested in
pre_chew<-crop(pre.stack$mar, catch)
#pre_chew<-mask(pre_chew, catch)
plot(pre_chew);plot(catch,add=T)#show it! isn't it pretty? :)

pre_chew<-crop(pre.stack$mar, catch,snap="out")#crop it
pre_chew<-disaggregate(pre_chew,fact=60,method="bilinear")#find the same spatial resolution as the DEM, use bilinear smoothing
#could be thought about more sophisticated interpolation
pre_chew<-mask(pre_chew, catch)#masc it
plot(pre_chew);plot(catch,add=T)#enjoy it
############################
# do now all at once!
for (i in 1:8){
  climate.stacks[[i]]<-crop(climate.stacks[[i]], catch, snap = "out")
  climate.stacks[[i]]<-disaggregate(climate.stacks[[i]],fact=60,method="bilinear")
  climate.stacks[[i]]<-mask(climate.stacks[[i]], catch)  
  print(paste("progress:",(100*i/8),"%"))

}

plot(climate.stacks[[8]]$mar)#enjoy the result

setwd("./../");setwd("./2nd_level") #move to outputfolder

#compute annual means, plot them and save them:
dev.off()
climate.pre.anu<-  sum(climate.stacks[[1]]);plot(climate.pre.anu,main="Precipitation per year (mm)")
dev.copy(png,filename="pre_anu.png");dev.off()
climate.rd0.anu<-  sum(climate.stacks[[2]]);plot(climate.rd0.anu,main="All days with >0.1 mm rain per year")
dev.copy(png,filename="rd0_anu.png");dev.off()
climate.tmp.anu<-  mean(climate.stacks[[3]]);plot(climate.tmp.anu,main="Mean temperature per year (°C)")
dev.copy(png,filename="tmp_anu.png");dev.off()
climate.dtr.anu<-  mean(climate.stacks[[4]]);plot(climate.dtr.anu,main="Mean diurnal temperature range per year (°C)")
dev.copy(png,filename="dtr_anu.png");dev.off()
climate.reh.anu<-  mean(climate.stacks[[5]]);plot(climate.reh.anu,main="Mean relative humidity per year (%)")
dev.copy(png,filename="reh_anu.png");dev.off()
climate.sunp.anu<-  mean(climate.stacks[[6]]);plot(climate.sunp.anu,main="Mean sunshine per year (% of daylength")
dev.copy(png,filename="sunp_anu.png");dev.off()
climate.frs.anu<-  sum(climate.stacks[[7]]);plot(climate.frs.anu,main="All days with ground-frost per year")
dev.copy(png,filename="frs_anu.png");dev.off()
climate.wnd.anu<-  mean(climate.stacks[[8]]);plot(climate.wnd.anu,main="Mean windspeed per year (m/s)")
dev.copy(png,filename="wnd_anu.png");dev.off()

#put them all together
climate.anu<-c(climate.pre.anu,climate.rd0.anu,climate.tmp.anu,climate.dtr.anu,climate.reh.anu,climate.sunp.anu,climate.frs.anu,climate.wnd.anu)

#save the computed climate files for later analysis:
save(climate.stacks, file="climate_by_month.RData")
save(climate.anu, file="climate_anu.RData")

#for climate land/ lake files:
sum(cellStats(climate.stacks[[1]], stat='mean', na.rm=TRUE))
mean(cellStats(climate.stacks[[3]], stat='mean', na.rm=TRUE)) + 273.15
mean(cellStats(climate.stacks[[5]], stat='mean', na.rm=TRUE))
mean(cellStats(climate.stacks[[8]], stat='mean', na.rm=TRUE))

