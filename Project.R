suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(lubridate))
suppressPackageStartupMessages(library(Quandl))
suppressPackageStartupMessages(library(Rmisc))
suppressPackageStartupMessages(library(scales))
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(rvest))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(plotly))
##############################################
wage <- read.csv("ECPI-WAGE_AD.csv", header = TRUE) %>% tbl_df
#https://www.quandl.com/data/ECPI/WAGE_AD-Real-value-of-the-minimum-wage-1960-2011
wage$Year <- as.Date(wage$Year)

wage <- wage[order(wage$Year),] 

#possible : https://www.quandl.com/data/FRED/FEDMINNFRWG-Federal-Minimum-Hourly-Wage-for-Nonfarm-Workers-for-the-United-States  
#https://www.quandl.com/data/FRBC/USINFL-U-S-Inflation

# cpi <- read.csv("CPI.csv", header = TRUE) %>% tbl_df 
# 
# #OECD (2016), Inflation (CPI) (indicator). doi: 10.1787/eee82e6e-en (Accessed on 30 April 2016)
# #https://data.oecd.org/price/inflation-cpi.htm
# #http://www.epi.org/publication/bp177/
# #2010 base year
# 
# cpi <- filter(cpi, LOCATION == "USA")
# cpi <- rename(cpi, c("TIME"="Year", "Value"="CPI"))

cpi_annual <- read.csv("CPI2.csv", header = TRUE) %>% tbl_df 
cpi_percent <- read.csv("CPI%.csv", header = TRUE) %>% tbl_df
cpi_percent <- rename(cpi_percent, c("Annual"="Change"))
cpi <- left_join(cpi_percent,cpi_annual, by = "Year")
#http://data.bls.gov/pdq/SurveyOutputServlet


webpage <- "https://www.dol.gov/featured/minimum-wage/chart1"
#real in 2012 dollars

nwage <- webpage %>%
  read_html() %>% 
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table()

nwage <- rename(nwage, c("Nominal Min Wage"="nomwage", "Minimum Wage in 2012 Dollars"="realwage"))  
nwage <- filter(nwage, nwage$Year >= 1938)
nmage <- na.omit(nwage)
#renaming, filtering and omitting NA
wage_cpi <- left_join(nwage, cpi, by = "Year") %>% 
  select(Year, Change, Annual, nomwage, realwage) %>% 
  mutate(nomwage=
    gsub('\\$', '', c(nomwage)),
  realwage=
    gsub('\\$', '', c(realwage)))
#removing dollar sign

wage_cpi$nomwage <- as.numeric(wage_cpi$nomwage)
wage_cpi$realwage <- as.numeric(wage_cpi$realwage)
#changing to numerical

wage_cpi <- wage_cpi %>% 
  mutate(keeping_up = NA)


wage_cpi <- wage_cpi %>% 
  mutate(indexed1938 = NA)
n <- 1
repeat {
  if (is.na(wage_cpi$indexed1938[1])){
    wage_cpi$indexed1938[1] <- wage_cpi$nomwage[1]
  } else if(is.na(wage_cpi$indexed1938[n+1])){
    wage_cpi$indexed1938[n+1] <- (wage_cpi$indexed1938[n]*(1+wage_cpi$Change[n]/100))
    n<-n+1}
  if (n == max(wage_cpi$Year)-min(wage_cpi$Year) + 1){
    break
  }
}

wage_cpi <- wage_cpi %>% 
  mutate(indexed1950 = NA)
n <- 13
repeat {
  if (is.na(wage_cpi$indexed1950[13])){
    wage_cpi$indexed1950[13] <- wage_cpi$nomwage[13]
  } else if(is.na(wage_cpi$indexed1950[n+1])){
    wage_cpi$indexed1950[n+1] <- (wage_cpi$indexed1950[n]*(1+wage_cpi$Change[n]/100))
    n<-n+1}
  if (n == max(wage_cpi$Year)-min(wage_cpi$Year)+1){
    break
  }
}

wage_cpi <- wage_cpi %>% 
  mutate(indexed1968 = NA)
n <- 31
repeat {
  if (is.na(wage_cpi$indexed1968[31])){
    wage_cpi$indexed1968[31] <- wage_cpi$nomwage[31]
  } else if(is.na(wage_cpi$indexed1968[n+1])){
    wage_cpi$indexed1968[n+1] <- (wage_cpi$indexed1968[n]*(1+wage_cpi$Change[n]/100))
    n<-n+1}
  if (n == max(wage_cpi$Year)-min(wage_cpi$Year)+1){
    break
  }
}














### COULDN'T figure out how to do this with dpylr(lag leads etc) after a few hours! 
### Essentially I am trying basically show using the nominal wage should be adjusted each year to CPI,
##although have 

set.seed(100)
plot1<- ggplot(data=wage_cpi) +
  geom_step(aes(Year, nomwage), color="black") +
  geom_line(aes(Year, indexed1938), color="red") +
  geom_line(aes(Year, indexed1950), color="blue") +
  geom_line(aes(Year, indexed1968), color="orange") +
  geom_line(aes(Year, realwage), color="purple") +
  geom_vline(aes(xintercept=1968), linetype=4) +
  theme(axis.text.x  = element_text(angle=90, vjust=.5)) +
  geom_vline(aes(xintercept=1950), linetype=4) +
  geom_vline(aes(xintercept=1938), linetype=4) +
  geom_vline(aes(xintercept=2012), linetype=4) +
  scale_x_continuous(breaks=c(1938,1940,1950,1960,1968,1970,1980,1990,2000,2010,2012)) +
  labs(title="Indexing the Nominal Mininum Wage at Different Years") +
  labs(ylab="Wage")
  
  
ggplotly(plot1)







# wage_cpi <- wage_cpi %>% 
#   mutate(keeping_up = ifelse(CPI==CPI[1], 1, ifelse(CPI==CPI[1], lag(keeping_up)*(1+(lag(CPI)/100)), NA)))
# 
# 
# wage_cpi <- wage_cpi %>% 
#   mutate(keeping_up = ifelse(CPI==CPI[1], 1, NA),
#          keeping_up = ifelse(CPI!=CPI[1], lag(keeping_up)*(1+(lag(CPI)/100)), NA))
# 
# 
# 
# wage_cpi <- wage_cpi %>% 
#   mutate(keeping_up = ifelse(CPI==CPI[1], 1, lag(keeping_up*(1+(lead(CPI)/100)))))





# con <- read.csv("congress-terms.csv", header = TRUE) %>% tbl_df
# #https://github.com/fivethirtyeight/data/tree/master/congress-age
# con <- subset(con, party %in% c('R','D') & chamber == "senate")
# View(con)
# con$termstart <-as.Date(con$termstart)




# con_prop <- con %>% 
#   group_by(congress,party) %>% 
#   tally() %>% 
#   group_by(congress) %>%
#   mutate(prop=)







# ggplot(wage, aes(Year, Minimum.Wage)) + ylim(5,9) +
#   geom_step(data=wage,aes(Year,Minimum.Wage,group=1)) +
#   geom_vline(xintercept=as.numeric(wage$Year[6]), linetype=4)+
#   theme(axis.text.x  = element_text(angle=90, vjust=.5))#line at 2006
#six state vote to raiseArizona, Colorado, Missouri, Montana, Nevada, and Ohio, in 2006







# ggplot(wage, aes(Year, Minimum.Wage)) + ylim(5,9) +
#   geom_area(aes(fill=Minimum.Wage)) + 
#   geom_line(data=wage,aes(Year,Minimum.Wage,group=1)) +
#   geom_smooth() + 
#   geom_vline(xintercept=as.numeric(wage$Year[6]), linetype=4)
# ggplot(wage,aes(x = Year,y = Minimum.Wage)) +
#   geom_area() +
#   geom_area( position = 'stack', fill="darkgreen")
# 
# con_prop <- con %>% 
#   group_by(congress,party) %>% 
#   tally() %>% 
#   group_by(congress) %>%
#   mutate(prop=)
# 
# class(con_prop$congress)
# con_prop$congress<- as.numeric(levels(con_prop$congress))[con_prop$congress]
# prop.table(table(con_prop), 3)
# con_prop$congress <- factor(con_prop$congress, levels = con_prop$congress[order(con_prop$congress)])
# ggplot(con_prop, aes(congress,n, fill = party))+
#   geom_bar(stat="identity") + theme(axis.text.x  = element_text(angle=90, vjust=.5))
# con1<- con %>% 
#   group_by(congress,party, termstart) %>% 
#   tally()
# 
# 
# states$state<- states$state_abbrev
# 
# con<- left_join(con, states, by = "state")
# ggplot(con1, aes(termstart, n, fill = party))+
#   geom_bar(stat="identity") + theme(axis.text.x  = element_text(angle=90, vjust=.5))


 
