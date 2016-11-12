# Project Details

* Name: Delaney Moran 
* Project title: Differential Distributions of Starbucks and Dunkin' Donuts in Eastern MA
* Abstract: 
The present analysis explores the comparative distributions of Dunkin’ Donuts and Starbucks in eastern Massachusetts. These two franchises are both highly successful coffeehouse chains despite a competitive market with low profit margins. 

Massachusetts was selected as the location of interested because it is my home state, and I know from experience there are strong loyalties by different groups of people to both Dunkin’ Donuts and Starbucks. Mapping both franchises revealed that there are many more Dunkin’ Donuts than Starbucks locations in eastern Massachusetts, and their densities differ by city vs. suburbs as well as by county. Additionally, the franchise density of Starbucks and Dunkin’ Donuts in a census tract are moderately associated with income. Overall, the present investigation reveals that Dunkin’ Donuts and Starbucks distributions differ both geographically, but also economically.

```{r, echo=FALSE, warning=FALSE}
# Load all the packages
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(ggmap))
suppressPackageStartupMessages(library(magrittr))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(rgdal))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(jsonlite))
suppressPackageStartupMessages(library(RCurl))
suppressPackageStartupMessages(library(maptools))
suppressPackageStartupMessages(library(rgeos))
suppressPackageStartupMessages(library(leaflet))
suppressPackageStartupMessages(library(rvest))
suppressPackageStartupMessages(library(spatialEco))
suppressPackageStartupMessages(library(plotly))
suppressPackageStartupMessages(library(knitr))
```


#Data
Income and demographic data for this region was obtained from [Social Explorer](http://old.socialexplorer.com/pub/reportdata/HtmlResults.aspx?reportid=R11178485), and the MA shapefile was loaded [here](https://catalog.data.gov/dataset/tiger-line-shapefile-2015-state-massachusetts-current-census-tract-state-based-shapefile). 
