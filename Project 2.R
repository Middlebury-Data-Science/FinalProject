suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(lubridate))
suppressPackageStartupMessages(library(Quandl))
suppressPackageStartupMessages(library(Rmisc))
suppressPackageStartupMessages(library(scales))
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(rvest))
suppressPackageStartupMessages(library(stringr))
##############################################
wage <- read.csv("ECPI-WAGE_AD.csv", header = TRUE) %>% tbl_df
#https://www.quandl.com/data/ECPI/WAGE_AD-Real-value-of-the-minimum-wage-1960-2011
wage$Year <- as.Date(wage$Year)
#possible : https://www.quandl.com/data/FRED/FEDMINNFRWG-Federal-Minimum-Hourly-Wage-for-Nonfarm-Workers-for-the-United-States  
#https://www.quandl.com/data/FRBC/USINFL-U-S-Inflation
cpi <- read.csv("CPI.csv", header = TRUE) %>% tbl_df 

#OECD (2016), Inflation (CPI) (indicator). doi: 10.1787/eee82e6e-en (Accessed on 30 April 2016)
#https://data.oecd.org/price/inflation-cpi.htm

cpi <- filter(cpi, LOCATION == "USA")
cpi <- rename(cpi, c("TIME"="Year", "Value"="CPI"))

webpage <- "https://www.dol.gov/featured/minimum-wage/chart1"
nwage <- webpage %>%
  read_html() %>% 
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table()

nwage <- rename(nwage, c("Nominal Min Wage"="nomwage", "Minimum Wage in 2012 Dollars"="realwage"))  
nwage <- filter(nwage, nwage$Year >= 1938)
nmage <- na.omit(nwage)


wage_cpi <- left_join(cpi, nwage, by = "Year") %>% 
  select(Year, CPI, nomwage, realwage) %>% 
  mutate(nomwage=
    gsub('\\$', '', c(nomwage)),
  realwage=
    gsub('\\$', '', c(realwage)))
wage_cpi$Year <- ymd(wage_cpi$Year

wage_cpi$CPI <- as.numeric(wage_cpi$CPI)
wage_cpi$nomwage <- as.numeric(wage_cpi$nomwage)
wage_cpi$realwage <- as.numeric(wage_cpi$realwage)


wage_cpi <- wage_cpi %>% 
  mutate(keeping_up = NA)

n <- 1

if (is.na(wage_cpi$keeping_up[1])){
  wage_cpi$keeping_up[1] <- 1
} else if(is.na(wage_cpi$keeping_up[n+1])){
  wage_cpi$keeping_up[n+1] <- 4
  n<-n+1}


wage_cpi <- wage_cpi %>% 
  mutate(keeping_up = NA)
n <- 1
repeat {
  if (is.na(wage_cpi$keeping_up[1])){
    wage_cpi$keeping_up[1] <- 1
  } else if(is.na(wage_cpi$keeping_up[n+1])){
    wage_cpi$keeping_up[n+1] <- (wage_cpi$keeping_up[n]*(1+wage_cpi$CPI[n]/100))
    n<-n+1}
  if (n == 60){
    break
  }
}
### COULDN'T figure out how to do this with dpylr(lag leads etc) after a few hours! 
### Essentially I am trying basically show using the nominal wage should be adjusted each year to CPI,
##although have 
wage_cpi$year

ggplot(wage_cpi) +
  geom_line(aes(y=realwage, x=Year),color="blue") 
  
ggplot(wage_cpi) +
  geom_line(aes(y=nomwage, x=Year),color="blue") +
  geom_line(aes(y=keeping_up,x=Year),color="red") +
  geom_line(aes(y=realwage, x=Year),color="orange")







wage_cpi <- wage_cpi %>% 
  mutate(keeping_up = ifelse(CPI==CPI[1], 1, ifelse(CPI==CPI[1], lag(keeping_up)*(1+(lag(CPI)/100)), NA)))


wage_cpi <- wage_cpi %>% 
  mutate(keeping_up = ifelse(CPI==CPI[1], 1, NA),
         keeping_up = ifelse(CPI!=CPI[1], lag(keeping_up)*(1+(lag(CPI)/100)), NA))



wage_cpi <- wage_cpi %>% 
  mutate(keeping_up = ifelse(CPI==CPI[1], 1, lag(keeping_up*(1+(lead(CPI)/100)))))


?ifelse()


mutate(wage_cpi$keeping_up = ifelse(wage_cpi$keeping_up == NA, 5))

?ifelse()
       mutate(V5 = ifelse(V1 == 1 & V2 != 4, 1, ifelse(V2 == 4 & V3 != 1, 2, 0)))
       myfile %>% mutate(V5 = (V1 == 1 & V2 != 4) + 2 * (V2 == 4 & V3 != 1))
       
       
       filter(mtcars, row_number() == 1L)
       filter(mtcars, row_number() == n())
       filter(mtcars, between(row_number(), 5, n()))

con <- read.csv("congress-terms.csv", header = TRUE) %>% tbl_df
#https://github.com/fivethirtyeight/data/tree/master/congress-age
con <- subset(con, party %in% c('R','D') & chamber == "senate")
View(con)
con$termstart <-as.Date(con$termstart)




con_prop <- con %>% 
  group_by(congress,party) %>% 
  tally() %>% 
  group_by(congress) %>%
  mutate(prop=)







ggplot(wage, aes(Year, Minimum.Wage)) + ylim(5,9) +
  geom_step(data=wage,aes(Year,Minimum.Wage,group=1)) +
  geom_vline(xintercept=as.numeric(wage$Year[6]), linetype=4)+
  theme(axis.text.x  = element_text(angle=90, vjust=.5))#line at 2006
#six state vote to raiseArizona, Colorado, Missouri, Montana, Nevada, and Ohio, in 2006









ggplot(wage, aes(Year, Minimum.Wage)) + ylim(5,9) +
  geom_area(aes(fill=Minimum.Wage)) + 
  geom_line(data=wage,aes(Year,Minimum.Wage,group=1)) +
  geom_smooth() + 
  geom_vline(xintercept=as.numeric(wage$Year[6]), linetype=4)
ggplot(wage,aes(x = Year,y = Minimum.Wage)) +
  geom_area() +
  geom_area( position = 'stack', fill="darkgreen")

con_prop <- con %>% 
  group_by(congress,party) %>% 
  tally() %>% 
  group_by(congress) %>%
  mutate(prop=)

class(con_prop$congress)
con_prop$congress<- as.numeric(levels(con_prop$congress))[con_prop$congress]
prop.table(table(con_prop), 3)
con_prop$congress <- factor(con_prop$congress, levels = con_prop$congress[order(con_prop$congress)])
ggplot(con_prop, aes(congress,n, fill = party))+
  geom_bar(stat="identity") + theme(axis.text.x  = element_text(angle=90, vjust=.5))
con1<- con %>% 
  group_by(congress,party, termstart) %>% 
  tally()


states$state<- states$state_abbrev

con<- left_join(con, states, by = "state")
ggplot(con1, aes(termstart, n, fill = party))+
  geom_bar(stat="identity") + theme(axis.text.x  = element_text(angle=90, vjust=.5))


 
