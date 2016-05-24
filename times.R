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

## show the data in comparable groups

## state assumptions, weather

## The Data ##

## **NOTE IN PAPER: CSVs were ALTERED b/c HOCR did not use constant format

## General sets
split.polygons <- read.csv("data/split.polygons.csv", header = TRUE, stringsAsFactors = FALSE)
athletes <- read.csv(file = "data/athletes_hocr.csv", header = TRUE)
clubs <- read.csv(file = "data/clubs_hocr.csv", header = TRUE)
events <- read.csv(file = "data/events_hocr.csv", header = TRUE)
races <- read.csv(file = "data/races_hocr.csv", header = TRUE)
results <- read.csv(file = "data/results.entry.csv", header = TRUE, stringsAsFactors = FALSE)

race.details <- left_join(events, races, by = "event_id")

markers <- read.csv("data/markers.csv", header = TRUE, stringsAsFactors = FALSE)

penalty.markers <- read.csv("data/penalty.markers.csv", header = TRUE, stringsAsFactors = FALSE)

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
         split3, cum3, split4, cum4)

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

## Penalties for 4s and 8s

penalties <- regatta.full %>% 
  group_by(penalty) %>% 
  tally()


penalties.desc <- regatta.full %>% 
  group_by(penalty_desc) %>% 
  tally()
penalties.desc

penalty.by.loc <- regatta.full %>% 
  filter(penalty!="")

penalty.by.loc <- penalty.by.loc %>% 
  separate(penalty_desc,into = c("p.1", "p.2", "p.3"), sep = ",", remove = FALSE, extra = "merge")

penalty.by.loc <- penalty.by.loc %>% 
  select(event_id, club, p.1,p.2,p.3)

penalty.by.loc <- penalty.by.loc %>% 
  mutate(p.ext = ifelse(p.1 == "8-BG(2)", "8-BG", NA))

penalty.by.loc <- penalty.by.loc %>% 
  gather(key = p.num, value = penalty, p.1:p.ext)

penalty.by.loc <- penalty.by.loc %>% 
  filter(!is.na(penalty))

penalty.loc <- penalty.by.loc %>% 
  separate(penalty, into = c("p.loc","p.type"), sep = "-", remove = FALSE, extra = "merge")

penalty.loc <- penalty.loc %>% 
  mutate(loc = as.numeric(ifelse(p.loc=="7A",7,p.loc)))

penalty.loc <- penalty.loc %>% 
  group_by(loc) %>% 
  tally()
penalty.loc

##
penalty.by.race <- results %>% 
  mutate(penalty.y.n = ifelse(Penalty > 0, 1, 0)) 

penalty.by.race <- penalty.by.race %>% 
  group_by(Event.Id, Event.Description) %>% 
  summarise(num.pen = sum(penalty.y.n)) 

races <- races %>% 
  mutate(event_id = as.character(event_id))

penalty.by.race <- left_join(penalty.by.race, races, by  = c("Event.Id" = "event_id")) 

penalty.by.race <- penalty.by.race %>% 
  select(Event.Id, Event.Description, num.pen, entries, cox)

penalty.by.race <- penalty.by.race %>% 
  mutate(perc.pen = as.numeric(round(num.pen/entries, 2)))

penalty.by.race <- penalty.by.race %>%
  arrange(desc(perc.pen))

pen.by.race.plot <- ggplot(data = penalty.by.race, aes(x=factor(Event.Id, levels=unique(Event.Id)), y = perc.pen))+
  geom_bar(stat = "identity", aes(fill = cox))+
  ggtitle("Penalties by Race")+
  xlab("Event Number")+
  ylab("Percentage of Boats Receiving a Penalty")
pen.by.race.plot

## All penalties

penalties.all <- results %>% 
  group_by(Penalty) %>% 
  tally()
penalties.all


## Penalty Marker Map


start.finish.map <- leaflet() %>% 
  addTiles() %>% 
  addPopups(-71.10782, 42.35294, "Start, BU Boathouse") %>% 
  addPopups(-71.13654, 42.36736, "Finish")
start.finish.map

markers.map <- leaflet(data = markers) %>% 
  addTiles() %>%
  addMarkers(~long, ~lat, popup = ~name)
markers.map

## split map
split.polygons <- read.csv("data/split.polygons.csv", header = TRUE, stringsAsFactors = FALSE)

split.map <- ggplot(split.polygons, aes(x=long, y=lat, group=group)) +
  labs(x="longitude", y="latitude", title="Splits") +
  coord_map() +
  geom_polygon() +
  geom_path()
split.map
ggplotly(split.map)

##

ggplot(penalty.markers, aes(x=long, y=lat, group=group)) +
  labs(x="longitude", y="latitude", title="HOCR") +
  geom_path() +
  coord_map()


penalty.markers <- left_join(penalty.markers, penalty.loc, by = c("group"="loc"))
penalty.markers <- penalty.markers %>% 
  mutate(n = ifelse(is.na(n), 0, n))

penalty.map <- ggplot(penalty.markers, aes(x=long, y=lat, group=group)) +
  labs(x="longitude", y="latitude", title="Penalties by Location for Coxed Boats") +
  coord_map() +
  geom_polygon(aes(fill=n)) +
  geom_path()
penalty.map
ggplotly(penalty.map)
## not working
leaflet(penalty.markers) %>%
  addTiles() %>% 
  addPolygons(lat = ~lat, lng = ~long, group=~group, stroke = ~order, fillcolor=~colorQuantile("Blues", n, 4))

marker.poly.1 <- penalty.markers %>% 
  filter(group==1)
marker.poly.2 <- penalty.markers %>% 
  filter(group==2)
marker.poly.3 <- penalty.markers %>% 
  filter(group==3)
marker.poly.4 <- penalty.markers %>% 
  filter(group==4)
marker.poly.5 <- penalty.markers %>% 
  filter(group==5)
marker.poly.6 <- penalty.markers %>% 
  filter(group==6)
marker.poly.7 <- penalty.markers %>% 
  filter(group==7)
marker.poly.8 <- penalty.markers %>% 
  filter(group==8)
marker.poly.9 <- penalty.markers %>% 
  filter(group==9)
marker.poly.10 <- penalty.markers %>% 
  filter(group==10)
marker.poly.11 <- penalty.markers %>% 
  filter(group==11)
marker.poly.12 <- penalty.markers %>% 
  filter(group==12)
marker.poly.13 <- penalty.markers %>% 
  filter(group==13)
marker.poly.14 <- penalty.markers %>% 
  filter(group==14)
marker.poly.15 <- penalty.markers %>% 
  filter(group==15)

leaflet() %>%
  addTiles() %>% 
  addPolygons(data = marker.poly.1, lat = ~lat, lng = ~long, group=~group, stroke = ~order) %>% 
  addPolygons(data = marker.poly.2, lat = ~lat, lng = ~long, group=~group, stroke = ~order) %>% 
  addPolygons(data = marker.poly.3, lat = ~lat, lng = ~long, group=~group, stroke = ~order) %>% 
  addPolygons(data = marker.poly.4, lat = ~lat, lng = ~long, group=~group, stroke = ~order) %>% 
  addPolygons(data = marker.poly.5, lat = ~lat, lng = ~long, group=~group, stroke = ~order) %>% 
  addPolygons(data = marker.poly.6, lat = ~lat, lng = ~long, group=~group, stroke = ~order) %>% 
  addPolygons(data = marker.poly.7, lat = ~lat, lng = ~long, group=~group, stroke = ~order) %>% 
  addPolygons(data = marker.poly.8, lat = ~lat, lng = ~long, group=~group, stroke = ~order) %>% 
  addPolygons(data = marker.poly.9, lat = ~lat, lng = ~long, group=~group, stroke = ~order) %>% 
  addPolygons(data = marker.poly.10, lat = ~lat, lng = ~long, group=~group, stroke = ~order) %>% 
  addPolygons(data = marker.poly.11, lat = ~lat, lng = ~long, group=~group, stroke = ~order) %>% 
  addPolygons(data = marker.poly.12, lat = ~lat, lng = ~long, group=~group, stroke = ~order) %>% 
  addPolygons(data = marker.poly.13, lat = ~lat, lng = ~long, group=~group, stroke = ~order) %>% 
  addPolygons(data = marker.poly.14, lat = ~lat, lng = ~long, group=~group, stroke = ~order) %>% 
  addPolygons(data = marker.poly.15, lat = ~lat, lng = ~long, group=~group, stroke = ~order) 



## Scratches

scratches <- regatta.full %>% 
  group_by(status) %>% 
  tally()
scratches

## remove scratches from master sheet so that they do not mess up times

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

## Which event was most competative? 

competitiveness <- regatta.master.times %>% 
  group_by(event.y) %>% 
  summarise(perc.50 = median(total.sec), avg = mean(total.sec), stnd.dev = sd(total.sec)) %>% 
  mutate(cv = stnd.dev/avg)

competitiveness <- competitiveness %>% 
  arrange(cv)

## what is the "competative" split? 

competitiveness <- competitiveness %>%
  mutate(m.per.sec = 4800/perc.50)

competitiveness <- competitiveness %>%
  mutate(med.split = 500/m.per.sec)

## repeat for the other split divisions

## repeat for entire regatta, including singles to determine most competative race

results.times <- results %>% 
  separate(Raw.Time, into = c("O.min", "O.sec"), sep = 2, remove = FALSE, extra = "merge")
  
results.times <- results.times %>%
  mutate(O.min = as.numeric(O.min), O.sec = as.numeric(O.sec))

results.times <- results.times %>%
  mutate(total.sec = O.min*60 + O.sec)

## let's count the people who scratched

scratches.all <- results %>% 
  group_by(Status) %>% 
  tally()
scratches.all

## let's remove people who scratched

results.times <- results.times %>% 
  filter(Status == "Finished")

competitiveness.all <- results.times %>% 
  group_by(Event.Id, Event.Description) %>% 
  summarise(perc.50 = median(total.sec), avg = mean(total.sec), stnd.dev = sd(total.sec)) %>% 
  mutate(cv = stnd.dev/avg) %>% 
  arrange(cv)

competitiveness.all <- competitiveness.all %>%
  mutate(m.per.sec = 4800/perc.50)

competitiveness.all <- competitiveness.all %>%
  mutate(med.split = 500/m.per.sec)

competitiveness.all <- competitiveness.all %>% 
  mutate(med.500.split = ifelse(med.split<120, paste("1", round(med.split-60,1), sep = ":"), 
                                  ifelse(med.split>=120 & med.split<130, 
                                         paste("2:0", round(med.split-120,1), sep = ""), 
                                         paste("2", round(med.split-120,1), sep = ":"))))
## splits for 4s and 8s
## Riverside, Split 1
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
## Group by race, calculate cv, then take average cv for each split

split.eval.cv <- split.eval %>% 
  group_by(event_id, event.x) %>% 
  summarise(s1.avg = mean(s1.total.sec), s1.stnd.dev = sd(s1.total.sec),
            s2.avg = mean(s2.total.sec), s2.stnd.dev = sd(s2.total.sec),
            s3.avg = mean(s3.total.sec), s3.stnd.dev = sd(s3.total.sec),
            s4.avg = mean(s4.total.sec), s4.stnd.dev = sd(s4.total.sec)) %>% 
  mutate(s1.cv = s1.stnd.dev/s1.avg,
         s2.cv = s2.stnd.dev/s2.avg,
         s3.cv = s3.stnd.dev/s3.avg,
         s4.cv = s4.stnd.dev/s4.avg)
## not condensing into one row
sum.split.eval.cv <- split.eval.cv %>% 
  summarise(s1.med.cv = median(s1.cv), s1.avg.cv = mean(s1.cv),
            s2.med.cv = median(s2.cv), s2.avg.cv = mean(s2.cv),
            s3.med.cv = median(s3.cv), s3.avg.cv = mean(s3.cv),
            s4.med.cv = median(s4.cv), s4.avg.cv = mean(s4.cv))
sum.split.eval.cv.test <- split.eval.cv %>% 
  summarise_each(funs(median, mean), s1.cv, s2.cv, s3.cv, s4.cv)
## try gather then group
sum.split.eval.cv.med <- split.eval.cv %>% 
  select(event_id, s1.cv, s2.cv, s3.cv, s4.cv) %>% 
  gather(key = split, value = cv, s1.cv:s4.cv) %>% 
  group_by(split) %>% 
  summarize(med.cv = median(cv))
sum.split.eval.cv.avg <- split.eval.cv %>% 
  select(event_id, s1.cv, s2.cv, s3.cv, s4.cv) %>% 
  gather(key = split, value = cv, s1.cv:s4.cv) %>% 
  group_by(split) %>% 
  summarize(avg.cv = mean(cv))
sum.split.eval.cv.both <- left_join(sum.split.eval.cv.avg, sum.split.eval.cv.med,
                                    by = "split")
## merge with polygons
sum.split.eval.cv.both <- sum.split.eval.cv.both %>% 
  mutate(group = ifelse(split == "s1.cv", 1, 
                        ifelse(split == "s2.cv",2,
                               ifelse(split == "s3.cv",3,
                                      ifelse(split =="s4.cv", 4,0)))))
split.polygons <- left_join(split.polygons, sum.split.eval.cv.both, by = "group")
## split map (partially above)


split.map.med <- ggplot(split.polygons, aes(x=long, y=lat, group=group)) +
  labs(x="longitude", y="latitude", title="Median CV of splits") +
  coord_map() +
  geom_polygon(aes(fill = med.cv, text = paste(split.x, "<br>",
                                               "Median: ", round(med.cv,4), "<br>",
                                               "Average: ", round(avg.cv, 4))))  +
  geom_path()
ggplotly(split.map.med)

split.map.avg <- ggplot(split.polygons, aes(x=long, y=lat, group=group)) +
  labs(x="longitude", y="latitude", title="Average CV of splits") +
  coord_map() +
  geom_polygon(aes(fill = avg.cv, text = paste(split.x, "<br>",
                                               "Median: ", round(med.cv,4), "<br>",
                                               "Average: ", round(avg.cv, 4)))) +
  geom_path()
ggplotly(split.map.avg)
