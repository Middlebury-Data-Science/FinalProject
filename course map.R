suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(knitr))
# For US county and state maps
suppressPackageStartupMessages(library(maps))
# For loading in shapefiles
suppressPackageStartupMessages(library(rgdal))
suppressPackageStartupMessages(library(maptools))
# For interactive maps
suppressPackageStartupMessages(library(leaflet))
library(plotly)

course.shape <- read.csv(file = "C:/Users/Philip/Documents/Intro to Data Science/HOCR/hocr.map.shape.csv", header = TRUE) %>% 
  tbl_df()
hocr.course <- ggplot(course.shape, aes(x=long, y=lat, group=group)) +
  labs(x="longitude", y="latitude", title="Head of the Charles Race Course") +
  coord_map() +
  geom_path()
hocr.course 