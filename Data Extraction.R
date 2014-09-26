####################################################
#                                                  #
#                  COPADS                          #
#              Data Extraction                     #
#                                                  #
####################################################

##Necesarry Libraries##
library(sp)
library(maptools)
library(mapdata)
library(mapproj)
library(PBSmapping)
library(raster)

##Call in necessary data and set up##
all<-readShapePoly("All_union.shp") #All Scatter-hoarders shprodent<-raster("rodent.grd")
rodents<-readShapePoly("Rodent_union.shp") #Rodent Scatter-hoarders shp
birds<-readShapePoly("Bird_union.shp") # Bird Scatter-hoarders shp
data<-read.csv("Master_file.csv")
coords<-data[,2:3]
coordinates(coords)<-c("long","lat")
	
## Overlays points and polygons ##
require(sp)
alldata<-over(SpatialPoints(coords), all)
rodentdata<-over(SpatialPoints(coords), rodents)
birddata<-over(SpatialPoints(coords), birds)


####NO LONGER NECESSARY, MASTER FILE IS COMPLETE####
## Update CSV with Scatter-hoarder data ##
data$allSH<-alldata$Join_Cou_2
data$rodentSH<-rodentdata$Join_Count
data$birdSH<-birddata$Join_Count
write.csv(data, file="Master_file.csv", na="0")
