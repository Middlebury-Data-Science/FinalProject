# Project Details

* Name: Delaney Moran 
* Project title: Differential Distributions of Starbucks and Dunkin' Donuts in Eastern MA
* Abstract: 
The present analysis explores the comparative distributions of Dunkin’ Donuts and Starbucks in eastern Massachusetts. These two franchises are both highly successful coffeehouse chains despite a competitive market with low profit margins. Massachusetts was selected as the location of interested because it is my home state, and I know from experience there are strong loyalties by different groups of people to both Dunkin’ Donuts and Starbucks. Mapping both franchises revealed that there are many more Dunkin’ Donuts than Starbucks locations in eastern Massachusetts, and their densities differ by city vs. suburbs as well as by county. Additionally, the franchise density of Starbucks and Dunkin’ Donuts in a census tract are moderately associated with income. Overall, the present investigation reveals that Dunkin’ Donuts and Starbucks distributions differ both geographically, but also economically.


```
## Warning: package 'ggplot2' was built under R version 3.2.4
```

```
## Warning: package 'RCurl' was built under R version 3.2.4
```

```
## Warning: package 'spatialEco' was built under R version 3.2.4
```

```
## Warning: package 'plotly' was built under R version 3.2.4
```

```
## OGR data source with driver: ESRI Shapefile 
## Source: "./data/tl_2015_25_tract/", layer: "tl_2015_25_tract"
## with 1478 features
## It has 12 fields
```

```
## Warning in inner_join_impl(x, y, by$x, by$y): joining factors with
## different levels, coercing to character vector
```

```
## Deleting rows:  5 6 8 13 199 200
```

```
## Deleting rows:  3 6 10 15 20 23 24 34 36 65 562 564 565 570 572 574 575 663 666 669 670 673 674 677 678 681 682 683 684 686 687 689 693 694 695 697 698 699 701 702 765 766 768 769 770 781 782 783 785
```

```
## Warning in left_join_impl(x, y, by$x, by$y): joining factors with different
## levels, coercing to character vector
```

```
## Warning in left_join_impl(x, y, by$x, by$y): joining factors with different
## levels, coercing to character vector
```

```
## Warning in left_join_impl(x, y, by$x, by$y): joining character vector and
## factor, coercing into character vector
```

![](README_files/figure-html/unnamed-chunk-1-1.png)

#Data
Income and demographic data for this region was obtained from [Social Explorer](http://old.socialexplorer.com/pub/reportdata/HtmlResults.aspx?reportid=R11178485), and the MA shapefile was loaded [here](https://catalog.data.gov/dataset/tiger-line-shapefile-2015-state-massachusetts-current-census-tract-state-based-shapefile). 
