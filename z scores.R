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

## data sets: regatta.master.times, split.eval
## z-scores

## run reg of final z-score on 3 binaries of fastest splits 
## (compared to first split being fastest) 
##controlling for sex and penalties

split.eval.14 <- split.eval %>% 
  filter(event_id=="14") %>% 
  select(club, penalty, sex, 
         total.sec, s1.total.sec, 
         s2.total.sec, s3.total.sec, s4.total.sec) %>% 
  mutate(total.z = (total.sec - mean(total.sec))/sd(total.sec),
         s1.z = (s1.total.sec - mean(s1.total.sec))/sd(s1.total.sec),
         s2.z = (s2.total.sec - mean(s2.total.sec))/sd(s2.total.sec),
         s3.z = (s3.total.sec - mean(s3.total.sec))/sd(s3.total.sec),
         s4.z = (s4.total.sec - mean(s4.total.sec))/sd(s4.total.sec),
         female = ifelse(sex == "w", 1, 0),
         pen.y.n = ifelse(penalty == "", 0,
                          ifelse(is.na(penalty), 0, 1))
         )

split.eval.15 <- split.eval %>% 
  filter(event_id=="15") %>% 
  select(club, penalty, sex, 
         total.sec, s1.total.sec, 
         s2.total.sec, s3.total.sec, s4.total.sec) %>% 
  mutate(total.z = (total.sec - mean(total.sec))/sd(total.sec),
         s1.z = (s1.total.sec - mean(s1.total.sec))/sd(s1.total.sec),
         s2.z = (s2.total.sec - mean(s2.total.sec))/sd(s2.total.sec),
         s3.z = (s3.total.sec - mean(s3.total.sec))/sd(s3.total.sec),
         s4.z = (s4.total.sec - mean(s4.total.sec))/sd(s4.total.sec),
         female = ifelse(sex == "w", 1, 0),
         pen.y.n = ifelse(penalty == "", 0,
                          ifelse(is.na(penalty), 0, 1))
  )

split.eval.26 <- split.eval %>% 
  filter(event_id=="26") %>% 
  select(club, penalty, sex, 
         total.sec, s1.total.sec, 
         s2.total.sec, s3.total.sec, s4.total.sec) %>% 
  mutate(total.z = (total.sec - mean(total.sec))/sd(total.sec),
         s1.z = (s1.total.sec - mean(s1.total.sec))/sd(s1.total.sec),
         s2.z = (s2.total.sec - mean(s2.total.sec))/sd(s2.total.sec),
         s3.z = (s3.total.sec - mean(s3.total.sec))/sd(s3.total.sec),
         s4.z = (s4.total.sec - mean(s4.total.sec))/sd(s4.total.sec),
         female = ifelse(sex == "w", 1, 0),
         pen.y.n = ifelse(penalty == "", 0,
                          ifelse(is.na(penalty), 0, 1))
  )

split.eval.27 <- split.eval %>% 
  filter(event_id=="27") %>% 
  select(club, penalty, sex, 
         total.sec, s1.total.sec, 
         s2.total.sec, s3.total.sec, s4.total.sec) %>% 
  mutate(total.z = (total.sec - mean(total.sec))/sd(total.sec),
         s1.z = (s1.total.sec - mean(s1.total.sec))/sd(s1.total.sec),
         s2.z = (s2.total.sec - mean(s2.total.sec))/sd(s2.total.sec),
         s3.z = (s3.total.sec - mean(s3.total.sec))/sd(s3.total.sec),
         s4.z = (s4.total.sec - mean(s4.total.sec))/sd(s4.total.sec),
         female = ifelse(sex == "w", 1, 0),
         pen.y.n = ifelse(penalty == "", 0,
                          ifelse(is.na(penalty), 0, 1))
  )

split.eval.46 <- split.eval %>% 
  filter(event_id=="46") %>% 
  select(club, penalty, sex, 
         total.sec, s1.total.sec, 
         s2.total.sec, s3.total.sec, s4.total.sec) %>% 
  mutate(total.z = (total.sec - mean(total.sec))/sd(total.sec),
         s1.z = (s1.total.sec - mean(s1.total.sec))/sd(s1.total.sec),
         s2.z = (s2.total.sec - mean(s2.total.sec))/sd(s2.total.sec),
         s3.z = (s3.total.sec - mean(s3.total.sec))/sd(s3.total.sec),
         s4.z = (s4.total.sec - mean(s4.total.sec))/sd(s4.total.sec),
         female = ifelse(sex == "w", 1, 0),
         pen.y.n = ifelse(penalty == "", 0,
                          ifelse(is.na(penalty), 0, 1))
  )

split.eval.47 <- split.eval %>% 
  filter(event_id=="47") %>% 
  select(club, penalty, sex, 
         total.sec, s1.total.sec, 
         s2.total.sec, s3.total.sec, s4.total.sec) %>% 
  mutate(total.z = (total.sec - mean(total.sec))/sd(total.sec),
         s1.z = (s1.total.sec - mean(s1.total.sec))/sd(s1.total.sec),
         s2.z = (s2.total.sec - mean(s2.total.sec))/sd(s2.total.sec),
         s3.z = (s3.total.sec - mean(s3.total.sec))/sd(s3.total.sec),
         s4.z = (s4.total.sec - mean(s4.total.sec))/sd(s4.total.sec),
         female = ifelse(sex == "w", 1, 0),
         pen.y.n = ifelse(penalty == "", 0,
                          ifelse(is.na(penalty), 0, 1))
  )

split.eval.48 <- split.eval %>% 
  filter(event_id=="48") %>% 
  select(club, penalty, sex, 
         total.sec, s1.total.sec, 
         s2.total.sec, s3.total.sec, s4.total.sec) %>% 
  mutate(total.z = (total.sec - mean(total.sec))/sd(total.sec),
         s1.z = (s1.total.sec - mean(s1.total.sec))/sd(s1.total.sec),
         s2.z = (s2.total.sec - mean(s2.total.sec))/sd(s2.total.sec),
         s3.z = (s3.total.sec - mean(s3.total.sec))/sd(s3.total.sec),
         s4.z = (s4.total.sec - mean(s4.total.sec))/sd(s4.total.sec),
         female = ifelse(sex == "w", 1, 0),
         pen.y.n = ifelse(penalty == "", 0,
                          ifelse(is.na(penalty), 0, 1))
  )

split.eval.49 <- split.eval %>% 
  filter(event_id=="49") %>% 
  select(club, penalty, sex, 
         total.sec, s1.total.sec, 
         s2.total.sec, s3.total.sec, s4.total.sec) %>% 
  mutate(total.z = (total.sec - mean(total.sec))/sd(total.sec),
         s1.z = (s1.total.sec - mean(s1.total.sec))/sd(s1.total.sec),
         s2.z = (s2.total.sec - mean(s2.total.sec))/sd(s2.total.sec),
         s3.z = (s3.total.sec - mean(s3.total.sec))/sd(s3.total.sec),
         s4.z = (s4.total.sec - mean(s4.total.sec))/sd(s4.total.sec),
         female = ifelse(sex == "w", 1, 0),
         pen.y.n = ifelse(penalty == "", 0,
                          ifelse(is.na(penalty), 0, 1))
  )

split.eval.50 <- split.eval %>% 
  filter(event_id=="50") %>% 
  select(club, penalty, sex, 
         total.sec, s1.total.sec, 
         s2.total.sec, s3.total.sec, s4.total.sec) %>% 
  mutate(total.z = (total.sec - mean(total.sec))/sd(total.sec),
         s1.z = (s1.total.sec - mean(s1.total.sec))/sd(s1.total.sec),
         s2.z = (s2.total.sec - mean(s2.total.sec))/sd(s2.total.sec),
         s3.z = (s3.total.sec - mean(s3.total.sec))/sd(s3.total.sec),
         s4.z = (s4.total.sec - mean(s4.total.sec))/sd(s4.total.sec),
         female = ifelse(sex == "w", 1, 0),
         pen.y.n = ifelse(penalty == "", 0,
                          ifelse(is.na(penalty), 0, 1))
  )

split.eval.51<- split.eval %>% 
  filter(event_id=="51") %>% 
  select(club, penalty, sex, 
         total.sec, s1.total.sec, 
         s2.total.sec, s3.total.sec, s4.total.sec) %>% 
  mutate(total.z = (total.sec - mean(total.sec))/sd(total.sec),
         s1.z = (s1.total.sec - mean(s1.total.sec))/sd(s1.total.sec),
         s2.z = (s2.total.sec - mean(s2.total.sec))/sd(s2.total.sec),
         s3.z = (s3.total.sec - mean(s3.total.sec))/sd(s3.total.sec),
         s4.z = (s4.total.sec - mean(s4.total.sec))/sd(s4.total.sec),
         female = ifelse(sex == "w", 1, 0),
         pen.y.n = ifelse(penalty == "", 0,
                          ifelse(is.na(penalty), 0, 1))
  )

split.eval.52 <- split.eval %>% 
  filter(event_id=="52") %>% 
  select(club, penalty, sex, 
         total.sec, s1.total.sec, 
         s2.total.sec, s3.total.sec, s4.total.sec) %>% 
  mutate(total.z = (total.sec - mean(total.sec))/sd(total.sec),
         s1.z = (s1.total.sec - mean(s1.total.sec))/sd(s1.total.sec),
         s2.z = (s2.total.sec - mean(s2.total.sec))/sd(s2.total.sec),
         s3.z = (s3.total.sec - mean(s3.total.sec))/sd(s3.total.sec),
         s4.z = (s4.total.sec - mean(s4.total.sec))/sd(s4.total.sec),
         female = ifelse(sex == "w", 1, 0),
         pen.y.n = ifelse(penalty == "", 0,
                          ifelse(is.na(penalty), 0, 1))
  )

split.eval.53 <- split.eval %>% 
  filter(event_id=="53") %>% 
  select(club, penalty, sex, 
         total.sec, s1.total.sec, 
         s2.total.sec, s3.total.sec, s4.total.sec) %>% 
  mutate(total.z = (total.sec - mean(total.sec))/sd(total.sec),
         s1.z = (s1.total.sec - mean(s1.total.sec))/sd(s1.total.sec),
         s2.z = (s2.total.sec - mean(s2.total.sec))/sd(s2.total.sec),
         s3.z = (s3.total.sec - mean(s3.total.sec))/sd(s3.total.sec),
         s4.z = (s4.total.sec - mean(s4.total.sec))/sd(s4.total.sec),
         female = ifelse(sex == "w", 1, 0),
         pen.y.n = ifelse(penalty == "", 0,
                          ifelse(is.na(penalty), 0, 1))
  )

split.eval.54 <- split.eval %>% 
  filter(event_id=="54") %>% 
  select(club, penalty, sex, 
         total.sec, s1.total.sec, 
         s2.total.sec, s3.total.sec, s4.total.sec) %>% 
  mutate(total.z = (total.sec - mean(total.sec))/sd(total.sec),
         s1.z = (s1.total.sec - mean(s1.total.sec))/sd(s1.total.sec),
         s2.z = (s2.total.sec - mean(s2.total.sec))/sd(s2.total.sec),
         s3.z = (s3.total.sec - mean(s3.total.sec))/sd(s3.total.sec),
         s4.z = (s4.total.sec - mean(s4.total.sec))/sd(s4.total.sec),
         female = ifelse(sex == "w", 1, 0),
         pen.y.n = ifelse(penalty == "", 0,
                          ifelse(is.na(penalty), 0, 1))
  )

split.eval.55 <- split.eval %>% 
  filter(event_id=="55") %>% 
  select(club, penalty, sex, 
         total.sec, s1.total.sec, 
         s2.total.sec, s3.total.sec, s4.total.sec) %>% 
  mutate(total.z = (total.sec - mean(total.sec))/sd(total.sec),
         s1.z = (s1.total.sec - mean(s1.total.sec))/sd(s1.total.sec),
         s2.z = (s2.total.sec - mean(s2.total.sec))/sd(s2.total.sec),
         s3.z = (s3.total.sec - mean(s3.total.sec))/sd(s3.total.sec),
         s4.z = (s4.total.sec - mean(s4.total.sec))/sd(s4.total.sec),
         female = ifelse(sex == "w", 1, 0),
         pen.y.n = ifelse(penalty == "", 0,
                          ifelse(is.na(penalty), 0, 1))
  )

master.split.z <- bind_rows(list(split.eval.14, split.eval.15,
                                 split.eval.26, split.eval.27,
                                 split.eval.46, split.eval.47,
                                 split.eval.48, split.eval.49,
                                 split.eval.50, split.eval.51,
                                 split.eval.52, split.eval.53,
                                 split.eval.54, split.eval.55))

master.split.z <- master.split.z %>% 
  mutate(s1.fastest = ifelse((s1.z > s2.z) & (s1.z > s3.z) & (s1.z > s4.z), 1, 0),
         s2.fastest = ifelse((s2.z > s1.z) & (s2.z > s3.z) & (s2.z > s4.z), 1, 0),
         s3.fastest = ifelse((s3.z > s1.z) & (s3.z > s2.z) & (s3.z > s4.z), 1, 0),
         s4.fastest = ifelse((s4.z > s1.z) & (s4.z > s2.z) & (s4.z > s3.z), 1, 0)
  )
  
## the model 
## using continous z-scores

reg.1 <- lm(data = master.split.z, total.z ~ 
              s3.z + female + pen.y.n)
summary(reg.1)

reg.2 <- lm(data = master.split.z, total.z ~ 
                 s1.z + s2.z + s3.z + s4.z +
                 female + pen.y.n)
summary(reg.2)

reg.3 <- lm(data = master.split.z, total.z ~ s1.total.sec +
              s2.total.sec + s3.total.sec + s4.total.sec +
              female+ pen.y.n)
summary(reg.3)

reg.4 <- lm(data = master.split.z, total.z ~ s1.total.sec +
              s2.total.sec + s3.total.sec + s4.total.sec +
              s2.fastest + s3.fastest + s4.fastest +
              female+ pen.y.n)
summary(reg.4)

reg.5 <- lm(data = master.split.z, total.z ~ s1.total.sec +
              s2.total.sec + s3.total.sec + s4.total.sec +
              s1.fastest + s2.fastest + s4.fastest +
              female+ pen.y.n)
summary(reg.5)

reg.6 <- lm(data = master.split.z, total.z ~ s1.total.sec +
              s2.total.sec + s3.total.sec + s4.total.sec +
              s1.fastest + s2.fastest + s3.fastest +
              female+ pen.y.n)
summary(reg.6)
sum.split.z <- master.split.z %>% 
  summarise(avg.1.fast = mean(s1.fastest),
            avg.2.fast = mean(s2.fastest),
            avg.3.fast = mean(s3.fastest),
            avg.4.fast = mean(s4.fastest))