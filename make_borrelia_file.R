library(dplyr)
library(tidyr)
library(ggplot2)

## Just meant to mark which ticks have Borrelia and which don't

ticks <- read.csv("ALL_Ticks.csv")
ticks <- ticks %>% gather(OTU, Count, 2:ncol(ticks))

taxonomy <- read.csv("OTU_Taxonomy.txt", sep = "\t") %>% tbl_df() %>% 
  mutate(Genus = gsub('[()0-9 ]', '', Genus)) 

taxonomy <- mutate(taxonomy, OTU = gsub('[A-Z,a-z.]', '', OTU))

ticks <- mutate(ticks, OTU = gsub('[A-Z,a-z.]', '', OTU))

positive_ticks <- inner_join(ticks, taxonomy, by="OTU") %>% 
    group_by(Tick, Genus) %>% summarize(Count = sum(Count)) %>% 
    filter(Genus == "g__Borrelia") %>% 
    select(`Tick`, `Count`)

write.csv( positive_ticks, file ="Tick_borrelia_count.csv")
