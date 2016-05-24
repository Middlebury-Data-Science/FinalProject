library(dplyr)
library(ggplot2)
library(tidyr)
library(lubridate)
library(leaflet)
library(ggmap)
library(maps)
library(maptools)
library(plotly)
library(rgdal)
library(rgeos)
library(scales)
library(rvest)
library(stringr)

athletes <- read.csv(file = "C:/Users/Philip/Documents/Intro to Data Science/HOCR/athletes_hocr.csv", header = TRUE)
clubs <- read.csv(file = "C:/Users/Philip/Documents/Intro to Data Science/HOCR/clubs_hocr.csv", header = TRUE)
events <- read.csv(file = "C:/Users/Philip/Documents/Intro to Data Science/HOCR/events_hocr.csv", header = TRUE)
races <- read.csv(file = "C:/Users/Philip/Documents/Intro to Data Science/HOCR/races_hocr.csv", header = TRUE)
results <- read.csv(file = "C:/Users/Philip/Documents/Intro to Data Science/HOCR/results.entry.csv", header = TRUE)

## US cities from http://simplemaps.com/resources/us-cities-data 
## lat long from http://www.latlong.net/

cities <- read.csv(file = "cities.csv", head=TRUE, stringsAsFactors = FALSE)

## state abbreviations from: http://www.infoplease.com/ipa/A0110468.html

abbrev <- read.csv(file = "state.abbreviations.csv", header = TRUE, stringsAsFactors = FALSE)

clean_text <- function(text){
  text <- gsub("[^[:alnum:]]", "", text)
  text <- gsub(" ", "", text)
  text <- tolower(text)
  return(text)
}

cities <- cities %>% 
  mutate(state.clean = clean_text(state), 
         city.clean = clean_text(city))

cities.tidy <- cities %>% 
  mutate(full.name = paste(city.clean,state.clean, sep = ", "))

cities.tidy <- cities.tidy %>% 
  distinct(full.name)

athletes <- athletes %>% 
  mutate(state.clean = clean_text(state.province), 
         city.clean = clean_text(city))

athletes.us <- athletes %>% 
  filter(country=="US") %>% 
  group_by(state.clean, city.clean, city, state.province) %>% 
  tally()
## drop 75 athletes who did not report their city
athletes.us <- athletes.us %>% 
  filter(city!="")

## state abbreviations

abbrev <- abbrev %>% 
  mutate(state.clean = clean_text(State), 
         code = clean_text(Postal.Code))

athletes.us <- left_join(athletes.us, abbrev, by=c("state.clean"))

## problems similar to bush.v.gore
athletes.cities <- left_join(athletes.us, cities.tidy, 
                             by = c("code" = "state.clean", "city.clean" = "city.clean"))

g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showland = TRUE,
  landcolor = toRGB("gray85"),
  subunitwidth = 1,
  countrywidth = 1,
  subunitcolor = toRGB("white"),
  countrycolor = toRGB("white")
)

map.all <- plot_ly(athletes.cities, lon = lng, lat = lat, text = paste(full.name, "<br>", n),
        marker = list(size = n/10),
        type = 'scattergeo', locationmode = 'USA-states') %>%
  layout(title = '2015 Head of the Charles Rowers', geo = g)
map.all


## Where are the participating clubs from? 

clubs.by.country <- clubs %>% 
  group_by(country) %>% 
  tally() %>% 
  arrange(desc(n))
clubs.by.country

## drop the 75 unaffiliated rowers
clubs.affiliated <- clubs %>% 
  filter(club != "Unaffiliated (usa)")

clubs.by.state <- clubs.affiliated %>% 
  filter(federation=="USA") %>% 
  group_by(state.province) %>% 
  tally() %>% 
  arrange(desc(n))


clubs.by.state <- clubs.by.state %>% 
  rename(clubs = n)

athletes <- athletes %>% 
  mutate(club = as.character(club), 
         city = as.character(city), 
         state.province = as.character(state.province),
         country = as.character(country))

athletes.by.state <- athletes %>% 
  filter(country=="US") %>% 
  group_by(state.province) %>% 
  tally() %>% 
  arrange(desc(n))

athletes.by.state <- athletes.by.state %>% 
  rename(athletes = n)


participation <- left_join(clubs.by.state, athletes.by.state, by = "state.province")

athletes.by.country <- athletes %>% 
  group_by(country) %>% 
  tally() %>% 
  arrange(desc(n))
athletes.by.country

participation <- participation %>% 
  mutate(hover = paste("clubs: ", clubs, "<br>",
                       "athletes: ", athletes))

participation <- participation %>% 
  mutate(state.clean = clean_text(state.province))


## state codes need to be added before grouping the data

participation <- left_join(participation, abbrev, by = c("state.clean"="state.clean"))



map.clubs <- plot_ly(data = participation, z = athletes, text = hover, locations = Postal.Code, type = 'choropleth',
        locationmode = 'USA-states', color = athletes, colors = 'Purples',
        marker = list(line = list(color = toRGB("black"), width = 1)), colorbar = list(title = "Number of Rowers")) %>%
  layout(title = '2015 HOCR Participation by State<br>(Hover for breakdown)', geo = list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  ))
map.clubs

