#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(ggthemes)
library(dplyr)
library(tidyr)

#Import the dataset, this is from Children's Safe Product Act Reported Data
#Download from: https://fortress.wa.gov/ecy/cspareporting/Reports/ReportViewer.aspx?ReportName=GetAllReport
#Dates: June 1, 2012 as the start date and March 09, 2016 as the end date
cspa <- read.csv("data/cspa.csv", header=TRUE)

#Make some things more pallatable in terms of names 
cspa <- rename(cspa, Chemical = `chemicalName`)
cspa <- rename(cspa, Organization = `AccountableOrganizationName`)

#Get some global stuff in there 
l<-levels(cspa$ProductClassDescription)
m <- levels(cspa$Organization)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
   
   # Application title
   titlePanel("Children's Safe Product Act"),
   br(),
   
   # Sidebar with a slider input for number of bins 
      fluidRow(
           column(4, 
                  selectInput("product", "I'm buying:", l),
           
           br(),
           
            radioButtons('age', "I would like to see results for:", 
                         c("All Ages", "Under 3 years", "3-12 years old"))),
   
           
           column(8,
           plotlyOutput("companies"))
   
   ),
   
   br(),
   br(),
   br(),
   
      fluidRow(
        column(4, 
               selectInput("organization", "I want to learn more about:", m)
      
      )

   
   ),
   
      fluidRow(
        column(7,
        plotlyOutput("compounds")),
      
        column(4,
        plotlyOutput("purpose"))
        
        
      )
   
   
   
   ))
    
      

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output, clientData, session) {

   
   output$companies <- renderPlotly({
     
     
     if(input$age == "All Ages"){
       
       
       temp <- cspa %>% filter(ProductClassDescription == input$product) %>% 
         group_by(Organization) %>% tally()
       temp <- temp %>% rename(NumberOfSubmissions = n)
  
       temp$Organization <- factor(temp$Organization, 
                                   levels = temp$Organization[order(temp$NumberOfSubmissions)])
       
       x <- ggplot(temp, aes(x = Organization, y = NumberOfSubmissions))+
         geom_bar(stat= "identity", aes(fill = NumberOfSubmissions)) +
         theme_tufte()+
         coord_flip() +
         labs(x = "", y = "Number of Submissions")+
         guides(fill = "none")
       
     }
       
       if(input$age == "Under 3 years"){
         temp <- cspa %>% filter(ProductClassDescription == input$product) %>% 
           filter(TargetAgeGroupDescription == "Under 3") %>% 
           group_by(Organization) %>% tally()
         temp <- temp %>% rename(NumberOfSubmissions = n)
         
         temp$Organization <- factor(temp$Organization, 
                                     levels = temp$Organization[order(temp$NumberOfSubmissions)])
         
         x <- ggplot(temp, aes(x = Organization, y = NumberOfSubmissions))+
           geom_bar(stat= "identity", aes(fill = NumberOfSubmissions)) +
           theme_tufte()+
           coord_flip() +
           labs(x = "", y = "Number of Submissions")+
           guides(fill = "none")
       }
       
       if(input$age == "3-12 years old"){
         temp <- cspa %>% filter(ProductClassDescription == input$product) %>% 
           filter(TargetAgeGroupDescription == "3 to 12") %>% 
           group_by(Organization) %>% tally()
         temp <- temp %>% rename(NumberOfSubmissions = n)
         
         temp$Organization <- factor(temp$Organization, 
                                     levels = temp$Organization[order(temp$NumberOfSubmissions)])
        
         
         x <- ggplot(temp, aes(x = Organization, y = NumberOfSubmissions))+
           geom_bar(stat= "identity", aes(fill = NumberOfSubmissions)) +
           theme_tufte()+
           coord_flip() +
           labs(x = "", y = "Number of Submissions")+
           guides(fill = "none")
       }
    x 
   })
   
   observe({
     temp <- cspa %>%  filter(ProductClassDescription == input$product) %>% 
       group_by(Organization) %>% tally()
     
     f <- as.character(temp$Organization)
     
     updateSelectInput(session, "organization", choices = f)
   })
  
   

   output$compounds <- renderPlotly({ 
       
       temp <- cspa %>% filter(ProductClassDescription == input$product) %>% 
         filter(Organization == input$organization) %>% 
         group_by(Chemical) %>% tally()
       temp <- temp %>% rename(NumberOfSubmissions = n)
       
       temp$Chemical <- factor(temp$Chemical, 
                                   levels = temp$Chemical[order(temp$NumberOfSubmissions)])
       
       
       if (nrow(temp) <= 5){
         y <- ggplot(temp, aes(x = Chemical, y = NumberOfSubmissions))+
           geom_bar(stat= "identity", aes(fill = NumberOfSubmissions)) +
           theme_tufte()+
           guides(fill = "none")+
           coord_flip() +
           labs(x = "", y = "Number of Submissions", title = "What chemicals are found in their products?")
       } 
       else{
         temp <- temp[1:5,]
         y <- ggplot(temp, aes(x = Chemical, y = NumberOfSubmissions))+
           geom_bar(stat= "identity", aes(fill = NumberOfSubmissions)) +
           theme_tufte()+
           guides(fill = "none")+
           coord_flip() +
           labs(x = "", y = "Number of Submissions", title = "What chemicals are found in their products?") 
       } 
       y
       
   })

   output$purpose <- renderPlotly({ 
     
     temp <- cspa %>% filter(ProductClassDescription == input$product) %>% 
       filter(Organization == input$organization) %>% 
       group_by(ChemicalFunctionName) %>% tally()
     temp <- temp %>% rename(NumberOfSubmissions = n)
     
     temp$ChemicalFunctionName <- factor(temp$ChemicalFunctionName, 
                             levels = temp$ChemicalFunctionName[order(temp$NumberOfSubmissions)])
     
     
     
     if (nrow(temp) <= 5){
       z <- ggplot(temp, aes(x = ChemicalFunctionName, y = NumberOfSubmissions))+
         geom_bar(stat= "identity", aes(fill = NumberOfSubmissions)) +
         theme_tufte()+
         guides(fill = "none")+
         coord_flip() +
         labs(x = "", y = "Number of Submissions", title = "What is the purpose of these chemicals?")
     } 
     else{
       temp <- temp[1:5,]
       z <- ggplot(temp, aes(x = ChemicalFunctionName, y = NumberOfSubmissions))+
         geom_bar(stat= "identity", aes(fill = NumberOfSubmissions)) +
         theme_tufte()+
         guides(fill = "none")+
         coord_flip() +
         labs(x = "", y = "Number of Submissions", title = "What is the purpose of these chemicals?") 
     } 
    z
   })   
   
      
})

# Run the application 
shinyApp(ui = ui, server = server)