rm(list=ls())
setwd("H:/R projects/R gallery")
  library(maps)
  library(mapdata)
  library(maptools)
  library(rgdal)
library(ggmap)
library(ggplot2)
library(rgeos)
  library(broom)
  library(tidyverse)
  library(geosphere)
  library(sp)
#library(plyr)

#Load the shapefile
shapefile <- readOGR(dsn="data/Combined_Authorities_December_2019_Boundaries_EN_BFC")
shapefile <- spTransform(shapefile,"+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
#Reshape for ggplot2 using the Broom package
mapdata <- tidy(shapefile, region="cauth19nm", proj="DECIMAL")

shapefile$bng_n
head(mapdata)
mapdata

gg <- ggplot() + geom_polygon(data = mapdata, aes(x = long, y = lat, group = group), color = "#FFFFFF", size = 0.25)
gg <- gg + coord_fixed(1) #This gives the map a nice 1:1 aspect ratio to prevent the map from appearing squashed
print(gg)


data <- read.csv("data/applications_local_authority.csv")
colnames(data)[1] <- "id" #rename the first column to mirror column names in mapdata
mapdata$id <- toupper(mapdata$id) #transform values in the id column to uppercase
#mapdata <- join(mapdata, data, by="id") #merge the two datasets
mapdata <- mapdata %>% left_join(data, by='id')
mapdata$Total <- scale(mapdata$Total) #standardise the values in the Total column to ensure we get an even spread of colours across the map rather than very light or dark colours for outliers

gg <- ggplot() + geom_polygon(data = mapdata, aes(x = long, y = lat, group = group, fill = Total), color = "#FFFFFF", size = 0.25)
gg <- gg + coord_fixed(1)
print(gg)

unique(data$id)

################################### MY TURN

#Load the shapefile
#shapefile <- readOGR(dsn="data/Regions_December_2019_Boundaries_EN_BFC")
shapefile1 <- readOGR(dsn="data/Counties_December_2019_Boundaries_EN_BFC")
shapefile2 <- readOGR(dsn="data/Combined_Authorities_December_2019_Boundaries_EN_BFC")
shapefile2 <- readOGR(dsn="data/Counties_and_Unitary_Authorities_December_2019_Boundaries_UK_BUC")
shapefile2 <- readOGR(dsn="data/Counties_and_Unitary_Authorities_December_2019_Boundaries_UK_BGC")
shapefile3 <- readOGR(dsn="data/Counties_and_Unitary_Authorities_December_2019_Boundaries_UK_BFC")
# shapefile <- readOGR(dsn="data/NUTS_Level_2_January_2018_Full_Extent_Boundaries_in_the_United_Kingdom")
# shapefile <- readOGR(dsn="data/Counties_and_Unitary_Authorities_December_2015_Generalised_Clipped_Boundaries_in_England_and_Wales")
# shapefile <- readOGR(dsn="data/Clinical_Commissioning_Groups_April_2020_Full_Clipped_Boundaries_EN")
# shapefile <- readOGR(dsn="data/Counties_and_Unitary_Authorities_December_2015_Full_Extent_Boundaries_in_England_and_Wales")
#Reshape for ggplot2 using the Broom package
plot(shapefile1, col='blue')
plot(shapefile2, add=TRUE, col='red')
plot(shapefile3, add=TRUE, col='yellow')

GB <- getData('GADM', country="gbr", level=2)
plot(GB, col='red')

plot(tidy(shapefile3, region="ctyua19nmw"), add=TRUE, col='green')

plot(shapefile3, col='yellow')


library(raster)
library(sp)
library(ggplot)

GB <- getData('GADM', country="gbr", level=2)

GB_sub <- subset(GB, NAME_1 != "Northern Ireland")

plot(GB)

subset(shapefile3, ctyua19nm >194)

shapefile3$ctyua19nm[1:194]

shapefile3$ctyua19nm-shapefile3$ctyua19nmw

shapefile$cty19nm[1]
unique(shapefile$rgn19nm)
shapefile
mapdata <- tidy(shapefile, region="cauth19nm")
#mapdata <- tidy(shapefile)
#mapdata <- filter(mapdata, id!='BLAENAU GWENT')
gg <- ggplot() + geom_polygon(data = mapdata, aes(x = long, y = lat, group = group), color = "#FFFFFF", size = 0.25)
gg <- gg + coord_fixed(1) #This gives the map a nice 1:1 aspect ratio to prevent the map from appearing squashed
print(gg)

GB <- getData('GADM', country="gbr", level=2)
GB_sub <- subset(GB, NAME_1 != "Northern Ireland")
GB_sub2 <- subset(GB_sub, NAME_1 != "Wales")
GB_sub3 <- subset(GB_sub2, NAME_1 != "Scotland")
GB_fort <- fortify(GB_sub3, region = "NAME_2")
unique(GB_fort$id)

gg <- ggplot() + 
  geom_polygon(data = GB_fort, aes(x = long, y = lat, group = group), color = "#FFFFFF", size = 0.25)
gg <- gg + coord_fixed(1) #This gives the map a nice 1:1 aspect ratio to prevent the map from appearing squashed
print(gg)

shapefile2$ctyua19nm
shapefile2$ctyua19nm
tidy(shapefile2, region="ctyua19nm") 
fortify(shapefile2, region='ctyua19nm')

unique(GB_fort$id)
GB_fort %>% head()
GB_fort[GB_fort$id == 'Buckinghamshire',] %>% head()

filter(GB_fort, id=='Bolton')

gg <- ggplot() + geom_polygon(data = mapdata, aes(x = long, y = lat, group = group, fill = Total), color = "#FFFFFF", size = 0.25)


GB <- getData('GADM', country="gbr", level=2)
names(GB)
head(GB$NAME_2)
GB_fort <- fortify(GB, region = "NAME_2")
c(unique(GB_fort$id))


data <- read.csv("data/english_champoins.csv")
data <- as.data.frame(data %>% group_by(Region) %>% summarise(Titles=sum(Titles)) %>% ungroup)
colnames(data)[1] <- "id" #rename the first column to mirror column names in mapdata
#mapdata$id <- toupper(mapdata$id) #transform values in the id column to uppercase
#mapdata <- join(mapdata, data, by="id") #merge the two datasets
mapdata <- mapdata %>% left_join(data, by='id')
mapdata$Total <- scale(mapdata$Titles) #standardise the values in the Total column to ensure we get an even spread of colours across the map rather than very light or dark colours for outliers

gg <- ggplot() + geom_polygon(data = mapdata, aes(x = long, y = lat, group = group, fill = Titles), color = "#FFFFFF", size = 0.25)
gg <- gg + coord_fixed(1)
print(gg)

unique(data$id)

GB <- getData('GADM', country="gbr", level=2)
mapdata <- tidy(GB)
shapefile1 <- readOGR(dsn="data/Counties_December_2019_Boundaries_EN_BFC")
mapdata1 <- tidy(shapefile1, region="cty19nm")
gg <- ggplot() + 
  geom_polygon(data = mapdata, aes(x = long, y = lat, group = group), color = "#FFFFFF", size = 0.25) +
  geom_polygon(data = mapdata1, aes(x = long, y = lat, group = group), fill ='yellow', size = 0.25)

gg <- gg + coord_fixed(1) #This gives the map a nice 1:1 aspect ratio to prevent the map from appearing squashed  
print(gg)


tidy(shapefile, proj='longlat', region='cty19nm')
shapefile$long
shapefile$

??tidy()

??ggplot()

GB_sub3$ENGTYPE_2



################################################################################################################
gg <- ggplot() + 
  geom_polygon(data = mapdata, aes(x = long, y = lat, group = group), color = "#FFFFFF", size = 0.25) +
  geom_polygon(data = GB_fort, aes(x = long, y = lat, group = group), color = "#FFFFFF", size = 0.25)
gg <- gg + coord_fixed(1) #This gives the map a nice 1:1 aspect ratio to prevent the map from appearing squashed
print(gg)

plot(shapefile, color='yellow')
plot(GB_sub3, add=TRUE, color='blue')

unique(mapdata$id=='Greater Manchester')

length(mapdata[mapdata$id=='Greater Manchester',]$long)

length(GB_fort[GB_fort$id=='Bolton',]$id)
length(GB_fort[GB_fort$id=='Bury',]$id)
length(GB_fort[GB_fort$id=='Manchester',]$id)


shapefile1 <- readOGR(dsn="data/Counties_December_2019_Boundaries_EN_BFC")
shapefile2 <- readOGR(dsn="data/Combined_Authorities_December_2019_Boundaries_EN_BFC")

mapdata1 <- tidy(shapefile1, region="cty19nm")
mapdata2 <- tidy(shapefile1, region="cty19nm")

gg <- ggplot() + 
  geom_polygon(data = mapdata2, aes(x = long, y = lat, group = group), color = "#FFFFFF", size = 0.25)
gg <- gg + coord_fixed(1) #This gives the map a nice 1:1 aspect ratio to prevent the map from appearing squashed
print(gg)

################################################################################################################
shapefile <- readOGR(dsn="data/Combined_Authorities_December_2019_Boundaries_EN_BFC")
shapefile <- spTransform(shapefile,"+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
#Reshape for ggplot2 using the Broom package
mapdata <- tidy(shapefile, region="cauth19nm")

GB <- getData('GADM', country="gbr", level=2)
GB_sub <- subset(GB, NAME_1 != "Northern Ireland")
GB_sub2 <- subset(GB_sub, NAME_1 != "Wales")
GB_sub3 <- subset(GB_sub2, NAME_1 != "Scotland")
GB_fort <- fortify(GB_sub3, region = "NAME_2")

mapdata
GB_fort


gg <- ggplot() + geom_polygon(data = mapdata, aes(x = long, y = lat, group = group), color = "#FFFFFF", size = 0.25)
gg <- gg + coord_fixed(1) #This gives the map a nice 1:1 aspect ratio to prevent the map from appearing squashed
print(gg)

gg <- ggplot() + geom_polygon(data = GB_fort, aes(x = long, y = lat, group = group), color = "#FFFFFF", size = 0.25)
gg <- gg + coord_fixed(1) #This gives the map a nice 1:1 aspect ratio to prevent the map from appearing squashed
print(gg)

gg <- ggplot() + 
  geom_polygon(data = rbind(mapdata, filter(GB_fort, !id %in% c('Bolton','Bury','Manchester','Oldham','Rochdale','Salford','Stockport','Tameside','Wigan'))), 
               aes(x = long, y = lat, group = group), color = "#FFFFFF", size = 0.25)
gg <- gg + coord_fixed(1) #This gives the map a nice 1:1 aspect ratio to prevent the map from appearing squashed
print(gg)


champions <- read_csv('data/english_champoins.csv')
unique(champions$County)

