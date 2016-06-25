## load packages

library(ggplot2)
library(maps)

## plot the USA map with the states

states_map <- map_data("state")

class(states_map)

head(states_map)

ggplot(states_map, aes(x = long, y = lat, group = group)) + 
        geom_polygon(fill = "white", color = "black")

world_map <- map_data("world")

ggplot(world_map, aes(x = long, y = lat, group = group)) + 
        geom_polygon(fill = "white", color = "black")

Lebanon <- map_data("world", region = "Lebanon")

ggplot(Lebanon, aes(x = long, y = lat, group = group)) + 
        geom_polygon(fill = "white", color = "black")

far_east <- map_data("world", region = c("China", "Japan", "North Korea",
                                         "South Korea"))

ggplot(far_east, aes(x = long, y = lat, group = group)) + 
        geom_polygon(fill = "white", color = "black")

countryNames <- unique(world_map$region)

head(sort(countryNames))

## Choropleth Maps

head(USArrests)
?USArrests

crimes <- data.frame(state = tolower(row.names(USArrests)), USArrests)
head(crimes)

states_map <- map_data("state")
head(states_map)

library(plyr)

crime_map <- merge(x = states_map, y = crimes, by.x = "region", by.y = "state")
head(crime_map)

## rearrange by group

crime_map <- arrange(crime_map, group, order)
head(crime_map)

ggplot(crime_map, aes(x = long, y = lat, group = group, fill = Murder)) + 
        geom_polygon(color = "black")

## look at google maps

library(ggmap)

qmap("University of Southern California", zoom = 16)

qmap("University of Southern California", zoom = 17, maptype = "satellite")

qmap("University of Southern California", zoom = 16, maptype = "roadmap")

## utility functions in ggmap

geocode("Los Angeles")

revgeocode(c(-77.03653, 38.89768))


## crime data in houston

qmap("Houston")

## focus on crime data in downtown Houston

gglocator(5) ## can be used in ggplot too!!!!!!!!!!!!!!!!!!!!!!!

head(crime)

dt_crime <- subset(crime, lon >= -95.60 & lon <= -95.17 & 
                           lat >= 29.54 & lat <= 29.95)

## focus on violent crimes

levels(dt_crime$offense)

violent_crimes <- subset(dt_crime, offense %in% c("aggravated assault", 
                                                  "murder", "rape" ,"robbery"))

violent_crimes1 <- subset(dt_crime, offense %in% levels(dt_crime$offense)[c(1,4,5,6)])

head(violent_crimes)
head(violent_crimes1)

Houston_map <- qmap("Houston", zoom = 14)

Houston_map + geom_point(data = violent_crimes, aes(x = lon, y = lat, 
                                                    color = offense))

## binning with alpha blending

Houston_map + stat_bin2d(data = violent_crimes, 
                         aes(x = lon, y = lat, color = offense, 
                             bins = 50, alpha = 0.4)) + facet_wrap(~day)
## the above is known as a spatio-temporal plot

