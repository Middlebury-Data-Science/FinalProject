library(rvest)
library(dplyr)
library(ggplot2)
webpage <- "https://www.dol.gov/featured/minimum-wage/chart1"
wp_data <- webpage %>%
  read_html() %>% 
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table()
View(wp_data)
