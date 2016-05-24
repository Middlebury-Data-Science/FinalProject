#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plyr)
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
library(knitr)
## Data

events <- read.csv(file = "data/events_hocr.csv", header = TRUE)
races <- read.csv(file = "data/races_hocr.csv", header = TRUE)

race.details <- left_join(events, races, by = "event_id")

## results by race

## Men
m.alum.8 <- read.csv(file = "data/m.alum.8.csv", header = TRUE)
m.chmp.4 <- read.csv(file = "data/m.chmp.4.csv", header = TRUE)
m.chmp.8 <- read.csv(file = "data/m.chmp.8.csv", header = TRUE)
m.club.4 <- read.csv(file = "data/m.chmp.4.csv", header = TRUE)
m.club.8 <- read.csv(file = "data/m.chmp.8.csv", header = TRUE)
m.coll.4 <- read.csv(file = "data/m.college.4.csv", header = TRUE)
m.coll.8 <- read.csv(file = "data/m.college.8.csv", header = TRUE)
m.lght.4 <- read.csv(file = "data/m.light.4.csv", header = TRUE)
m.lght.8 <- read.csv(file = "data/m.light.8.csv", header = TRUE)

## Women

w.alum.8 <- read.csv(file = "data/w.alum.8.csv", header = TRUE)
w.chmp.4 <- read.csv(file = "data/w.chmp.4.csv", header = TRUE)
w.chmp.8 <- read.csv(file = "data/w.chmp.8.csv", header = TRUE)
w.club.4 <- read.csv(file = "data/w.chmp.4.csv", header = TRUE)
w.club.8 <- read.csv(file = "data/w.chmp.8.csv", header = TRUE)
w.coll.4 <- read.csv(file = "data/w.college.4.csv", header = TRUE)
w.coll.8 <- read.csv(file = "data/w.college.8.csv", header = TRUE)
w.lght.4 <- read.csv(file = "data/w.light.4.csv", header = TRUE)
w.lght.8 <- read.csv(file = "data/w.light.8.csv", header = TRUE)

## Master results sheet

## First we must delete the extra columns and standardize the column names
names(m.alum.8)
m.alum.8 <- m.alum.8 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, split4, cum4)

names(w.alum.8)
w.alum.8 <- w.alum.8 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         X.18, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)

w.alum.8 <- w.alum.8 %>% 
  rename(split1 = X.18, split4 = splitF)

names(m.chmp.4)
m.chmp.4 <- m.chmp.4 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
m.chmp.4 <- m.chmp.4 %>% 
  rename(split4 = splitF)

names(w.chmp.4)
w.chmp.4 <- w.chmp.4 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
w.chmp.4 <- w.chmp.4 %>% 
  rename(split4 = splitF)

names(m.chmp.8)
m.chmp.8 <- m.chmp.8 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
m.chmp.8 <- m.chmp.8 %>% 
  rename(split4 = splitF)

names(w.chmp.8)
w.chmp.8 <- w.chmp.8 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
w.chmp.8 <- w.chmp.8 %>% 
  rename(split4 = splitF)

names(m.club.4)
m.club.4 <- m.club.4 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
m.club.4 <- m.club.4 %>% 
  rename(split4 = splitF)

names(w.club.4)
w.club.4 <- w.club.4 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
w.club.4 <- w.club.4 %>% 
  rename(split4 = splitF)

names(m.club.8)
m.club.8 <- m.club.8 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
m.club.8 <- m.club.8 %>% 
  rename(split4 = splitF)

names(w.club.8)
w.club.8 <- w.club.8 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
w.club.8 <- w.club.8 %>% 
  rename(split4 = splitF)

names(m.coll.4)
m.coll.4 <- m.coll.4 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
m.coll.4 <- m.coll.4 %>% 
  rename(split4 = splitF)

names(w.coll.4)
w.coll.4 <- w.coll.4 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
w.coll.4 <- w.coll.4 %>% 
  rename(split4 = splitF)

m.coll.8 <- m.coll.8 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
m.coll.8 <- m.coll.8 %>% 
  rename(split4 = splitF)

w.coll.8 <- w.coll.8 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
w.coll.8 <- w.coll.8 %>% 
  rename(split4 = splitF)

m.lght.4 <- m.lght.4 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
m.lght.4 <- m.lght.4 %>% 
  rename(split4 = splitF)

w.lght.4 <- w.lght.4 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
w.lght.4 <- w.lght.4 %>% 
  rename(split4 = splitF)

m.lght.8 <- m.lght.8 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
m.lght.8 <- m.lght.8 %>% 
  rename(split4 = splitF)

w.lght.8 <- w.lght.8 %>% 
  select(event_id, place, status, 
         lane_bow, club, crew, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, splitF, cum4)
w.lght.8 <- w.lght.8 %>% 
  rename(split4 = splitF)

## let's make the master results sheet

regatta <- bind_rows(list(m.alum.8, w.alum.8, 
                          m.chmp.4, w.chmp.4, 
                          m.chmp.8, w.chmp.8,
                          m.club.4, w.club.4,
                          m.club.8, w.club.8,
                          m.coll.4, w.coll.4,
                          m.coll.8, w.coll.8,
                          m.lght.4, w.lght.4,
                          m.lght.8, w.lght.8))

regatta <- regatta %>% 
  select(event_id, place, status, 
         lane_bow, club, 
         rower, penalty, penalty_desc, 
         time_official, delta, percent, 
         split1, cum1, split2, cum2, 
         split3, cum3, split4, cum4)

## Excel created some extra rows, lets drop them
regatta <- regatta %>% 
  mutate(event_id = as.character(event_id))
regatta <- regatta %>%  
  filter(!is.na(event_id))

## here is the final sheet
regatta.full <- left_join(regatta, race.details, by = "event_id")

regatta.finishers <- regatta.full %>% 
  filter(status=="Finished")

##manipulate master sheet times

regatta.master.times <- regatta.finishers %>% 
  mutate(time_official = as.character(time_official)) %>% 
  separate(time_official,into = c("O.min", "O.sec"), sep = ":", remove = FALSE, extra = "merge")

regatta.master.times <- regatta.master.times %>%
  mutate(O.min = as.numeric(O.min), O.sec = as.numeric(O.sec))

regatta.master.times <- regatta.master.times %>%
  mutate(total.sec = O.min*60 + O.sec)

split.eval <- regatta.master.times %>% 
  separate(split1, into = c("s1.min", "s1.sec"), sep = ":", remove = FALSE, extra = "merge")

split.eval <- split.eval %>%
  mutate(s1.min = as.numeric(s1.min), s1.sec = as.numeric(s1.sec))

split.eval <- split.eval %>%
  mutate(s1.total.sec = s1.min*60 + s1.sec)

## repeat for the rest of the splits
## Weld, split 2
split.eval <- split.eval %>% 
  separate(split2, into = c("s2.min", "s2.sec"), sep = ":", remove = FALSE, extra = "merge")

split.eval <- split.eval %>%
  mutate(s2.min = as.numeric(s2.min), s2.sec = as.numeric(s2.sec))

split.eval <- split.eval %>%
  mutate(s2.total.sec = s2.min*60 + s2.sec)
## Cambridge, Split 3
split.eval <- split.eval %>% 
  separate(split3, into = c("s3.min", "s3.sec"), sep = ":", remove = FALSE, extra = "merge")

split.eval <- split.eval %>%
  mutate(s3.min = as.numeric(s3.min), s3.sec = as.numeric(s3.sec))

split.eval <- split.eval %>%
  mutate(s3.total.sec = s3.min*60 + s3.sec)
## Finish, split 4
split.eval <- split.eval %>% 
  separate(split4, into = c("s4.min", "s4.sec"), sep = ":", remove = FALSE, extra = "merge")

split.eval <- split.eval %>%
  mutate(s4.min = as.numeric(s4.min), s4.sec = as.numeric(s4.sec))

split.eval <- split.eval %>%
  mutate(s4.total.sec = s4.min*60 + s4.sec)

## hist wrap



# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("HOCR51 Race Split Histograms"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      radioButtons("event", "Event:",
                   c("Men's Alumni Eights" = 14,
                     "Women's Alumni Eights" = 15,
                     "Men's Collegiate Fours" = 26,
                     "Women's Collegiate Fours" = 27,
                     "Men's Championship Fours" = 46,
                     "Women's Championship Fours" = 47,
                     "Men's Championship Eights" = 48,
                     "Women's Championship Eights" = 49,
                     "Men's Collegiate Eights" = 50,
                     "Women's Collegiate Eights " = 51,
                     "Men's Lightweight Fours" = 52,
                     "Women's Lightweight Fours" = 53,
                     "Men's Lightweight Eights" = 54,
                     "Women's Lightweight Eights" = 55))
    ),
    mainPanel(
      plotOutput("hist")
    )
  )
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
  
  output$hist <- renderPlot({
    race <- input$event
    
    hist.split.df <- split.eval %>% 
      filter(event_id == as.character(race)) %>% 
      select(event.x, place, club, s1.total.sec, 
             s2.total.sec, s3.total.sec, s4.total.sec) %>% 
      gather(key = split, value = total.sec, s1.total.sec:s4.total.sec)
    
    hist.split.df <- hist.split.df %>% 
      mutate(split = ifelse(split=="s1.total.sec", "1: Riverside",
                            ifelse(split=="s2.total.sec", "2: Weld",
                                   ifelse(split=="s3.total.sec",
                                          "3: Cambridge",
                                          ifelse(split=="s4.total.sec","4: Finish",0)))))
    
    split.wrap <- 
      ggplot(data = hist.split.df, aes(x=total.sec, fill = place))+
      geom_histogram(aes(text = paste(place,": ", club)))+
      scale_fill_gradient()+
      facet_wrap(~split, scales = "free")
    ggplotly(split.wrap)
  
  })
})

# Run the application 
shinyApp(ui = ui, server = server)



