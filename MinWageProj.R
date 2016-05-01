---
  title: "MATH 216 Homework 3"
author: "WRITE YOUR NAME HERE"
output: html_document
---
  
  ```{r, echo=FALSE, message=FALSE, warning=FALSE}
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(lubridate))
suppressPackageStartupMessages(library(Quandl))
```


## Admistrative:

Please indicate

* Who you collaborated with:
  * Roughly how much time you spent on this HW:
  * What gave you the most trouble:
  * Any comments you have: 
  
  
  ## Data
  
  * You must first copy the file `profiles.csv` from `HW-2` to the `data` folder
in the `HW-3` directory
* We also consider all 222,540 songs played in the Reed College pool hall
jukebox from Nov 30, 2003 to Jan 22, 2009 (included in `HW-3` folder). 

```{r, echo=FALSE, cache=TRUE}
# DO NOT EDIT THIS SECTION!
profiles <- read.csv("data/profiles.csv", header=TRUE) %>% 
  tbl_df()
jukebox <- read.csv("data/jukebox.csv", header=TRUE) %>% 
  tbl_df()
```





## Question 1:

For this question we will be picking up from where we left off in HW-2,
specifically the OkCupid dataset.


### a)

Using your exploratory data analysis from HW-2, fit a logistic regression to
predict individual's gender and interpret your results.

```{r, echo=FALSE, fig.width=12, fig.height=6}

```


### b)

Plot a histogram of the fitted probabilities $\widehat{p}_i$ for all users $i=1,
\ldots, n=59946$ in your dataset.

```{r, echo=FALSE, fig.width=12, fig.height=6}

```


### c)

Use a *decision threshold* of $p^*=0.5$ to make an explicit prediction for each
user $i$'s sex and save this in a variable `predicted_sex`. In other words, for user $i$
  
  * If $\widehat{p}_i > p^*$, set `predicted_sex = 1` i.e. they are female
* If $\widehat{p}_i < p^*$, set `predicted_sex = 0` i.e. they are male

Display a 2 x 2 contigency table of `sex` and `predicted_sex` i.e. compare the 
predicted sex to the actual sex of all users. The sum of all the elements in
your table should be $n=59946$. Comment on how well our predictions fared.

```{r, echo=FALSE, fig.width=12, fig.height=6}

```


### d)

Say we wanted to have a **false positive rate** of about 20%, i.e. of the people
we predicted to be female, we want to be wrong no more than 20% of the time. What
decision threshold $p^*$ should we use?

```{r, echo=FALSE, fig.width=12, fig.height=6}

```





## Question 2:

Using the jukebox data, plot a time series of the number of songs played each
week over the entire time period. i.e.

* On the x-axis present actual dates (not something like Week 93, which doesn't 
                                      mean anything to most people).
                                      * On the y-axis present the total number of songs.
                                      
                                      What seasonal (i.e. cyclical) patterns do you observe?
                                      
                                      ```{r, echo=FALSE, fig.width=12, fig.height=6}
                                      
                                      ```
                                      
                                      
                                      
                                      
                                      
                                      ## Question 3:
                                      
                                      Using the jukebox data, what are the top 10 artists played during the "graveyard
                                      shift" during the academic year? Define
                                      
                                      * the "graveyard shift" as midnight to 8am
                                      * the academic year as September through May (inclusive)
                                      
                                      ```{r, echo=FALSE, fig.width=12, fig.height=6}
                                      
                                      ```
                                      
                                      
                                      
                                      
                                      
                                      ## Question 4:
                                      
                                      We want to compare the volatility of 
                                      
                                      * bitcoin prices
                                      * gold prices
                                      
                                      Let our measure of volatility be the relative change from day-to-day in price. 
                                      Let the reference currency be US dollars. Analyze these results and provide
                                      insight to a foreign currency exchanger.
                                      
                                      ```{r, echo=FALSE, fig.width=12, fig.height=6}
                                      
                                      ```
                                      
                                      
                                      
                                      
                                      
                                      ## Question 5:
                                      
                                      Using the data loaded from Quandl below, plot a time series using `geom_line()`
                                      comparing cheese and milk production in the US from 1930 to today. Comment on this.
                                      
                                      * Cheese [page](https://www.quandl.com/data/USDANASS/NASS_CHEESEPRODUCTIONMEASUREDINLB-Cheese-Production-Measured-In-Lb)
                                      * Milk [page](https://www.quandl.com/data/USDANASS/NASS_MILKPRODUCTIONMEASUREDINLB-Milk-Production-Measured-In-Lb)
                                      
                                      ```{r, echo=FALSE, fig.width=12, fig.height=6}
                                      cheese <- Quandl("USDANASS/NASS_CHEESEPRODUCTIONMEASUREDINLB") %>% 
                                      tbl_df()
                                      milk <-  Quandl("USDANASS/NASS_MILKPRODUCTIONMEASUREDINLB") %>% 
                                      tbl_df()
                                      ```
                                      