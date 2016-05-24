
#Project Details

**Name:** Andrew Holtz

**Project title:** Investigating Differentialy Expressed Genes in the 
*S.mutans* Transcriptome

**Abstract:**

Streptococcus mutans is the principal causative agent of dental 
caries in humans. A major research objective in the Spatafora Lab at Middlebury
College focuses on identifying genes that are regulated by the S. mutans SloR
metalloregulator and defining their potential involvement in the caries-forming
process. Homologs of the SloR metalloregulator in other pathogenic bacteria are
known to modulate gene expression upon binding DNA in the presence of a metal 
ion co-repressor. The results of microarray and real-time qRT-PCR experiments
revealed SloR as a pleiotropic global regulator in S. mutans. To verify the 
results of the microarray, RNA-Sequencing was performed The goal of this project
was to analyze the data, from  which conclusions on differential gene expression
between the wild-type, UA159, and SloR knockout organism, GMS584, were made.
Discovering genes that are regulated by SloR, such as those involved in 
oxidative stress or acid tolerance, will sharpen and fortify future treatment 
and prevention plans against dental cavities. This will aid the millions of 
people in the world who do not have access to proper dental healthcare or dental
education.

**Note:**

Included in this analysis is a Shiny App that can be used to see differentital
expression of specific genes, specific gene ontologies, and search terms. 
Because this data is private, it was not published onto the Shiny Server- 
Middlebury does not know how to password protect a Shiny App at this point. In
the mean time, there is an easy 5 step solution to run the App.

**5 Steps to Run Shiny App**

*This requires the R programming language software which can be found here:* 
https://cran.r-project.org/

First, download the app.R and the data folder from this repository. Put both
into one folder where you will remember (recommend Desktop)

1.) Open terminal. Wait for it to reset

2.) Type: R.

3.) Type: library(“shiny”)

4.) Type: setwd(“*insert path to folder here*”)

5.) Type: getwd()

6.) Type: runApp()

![](README_files/figure-html/unnamed-chunk-1-1.png)<!-- -->



