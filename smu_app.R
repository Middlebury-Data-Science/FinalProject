#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(stringr)
library(DT)



tTags_annot <- read.csv("data/tTags_annot.csv", header=TRUE)
GO_SMU <- read.csv("data/GO_SMU.csv", header = TRUE)

choices <- dput(as.character(tTags_annot$SMU))
GO <- dput(as.character(GO_SMU$GO))

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(

  # Application title
  titlePanel("RNA Sequencing Results of S.mutans UA159 vs. GMS584"),


  wellPanel(
    helpText("You can find SMU numbers at :", a("http://www.genome.jp/kegg-bin/show_organism?org=smu", href="http://www.genome.jp/kegg-bin/show_organism?org=smu"))
  ),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("smu",
                  "Plot 1: Enter SMU number",
                  choices),

      selectInput("GO", "Plot 2: Enter GO Term", GO),
      textInput("text", "Plot 3: Enter term", "Enter term here"),
      submitButton("Submit")

    ),


    # Show a plot of the generated distribution
    mainPanel(
      h4("Plot 1: Differential Expression by SMU #"),
      plotOutput('distPlot'),
      h5('Table 1: Raw Data Assosciated with SMU of Interest'),
      dataTableOutput('table'),
      headerPanel(('\n')),
      headerPanel(('\n')),
      h5(('-----------------------------------')),
      headerPanel(('\n')),
      headerPanel(('\n')),
      h3('Table 2: All SMU found in RNA-Seq Analysis'),
      dataTableOutput('table2'),
      h3('Table 3: All Genes by GO terms'),
      dataTableOutput('table3'),
      h3("Plot 2: Differential Expression by GO term"),
      plotOutput('GOPlot'),
      h5('Table 4: Raw Data Assosciated with GO of Interest'),
      dataTableOutput('table4'),
      h3('Plot 3: Differential Expression by Search Term'),
      plotOutput('DescPlot'),
      h5('Table 5: Raw Data Assosciated with Search Term of Interest'),
      dataTableOutput('table5')

    )
  )
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    smu <- input$smu
    row_number <- which(tTags_annot$SMU == smu)

    ggplot(data = tTags_annot,
           aes(x = avgCPM_UA159[row_number], y = avgCPM_GMS584[row_number])) +
      geom_point() +
      geom_abline(mapping = NULL, data = NULL, slope = 1, intercept = 0) +
      coord_cartesian(xlim = c(0, 20), ylim = c(0,20)) +
      labs(title = paste("CPM Between UA159 and GMS84 for",
                         tTags_annot$SMU[row_number]),
           x= "UA159(CPM)", y = "GMS584(CPM)")

  })


  output$table <- DT::renderDataTable({
    smu <- input$smu
    row_number <- which(tTags_annot$SMU == smu)
    new_table <- slice(tTags_annot, row_number)

    new_table <- select(new_table, SMU, Gene, NCBI_ID, logFC,
                        logCPM, PValue, FDR, Desc)

    datatable(new_table, options = list(lengthChange = FALSE, dom = 't'))
  })

  output$table2 <- DT::renderDataTable({

    show_table <- select(tTags_annot, SMU, Gene, NCBI_ID, logFC,
                         logCPM, PValue, FDR, Desc)

    datatable(show_table)

  })


  output$table3 <- DT::renderDataTable({

    show_table <- select(GO_SMU, GO, name, SMU, Gene, Desc, logFC, PValue)

    datatable(show_table)

  })


#Plot for GO Term
  output$GOPlot <- renderPlot({

    gene_comp2 <- GO_SMU %>%
      select(SMU, logFC, GO, name, Desc, avgCPM_UA159, avgCPM_GMS584) %>%
      filter(GO ==input$GO)

    ggplot(gene_comp2, aes(x = avgCPM_UA159, y = avgCPM_GMS584, color = logFC)) +
      geom_point(size = 3) +
      scale_colour_gradient2(low="red", high="blue") +
      geom_abline(mapping = NULL, data = NULL, slope = 1, intercept = 0) +
      coord_cartesian(xlim = c(0, 20), ylim = c(0,20)) +
      labs(title = input$GO)

  })

#Data Table for GO Term
  output$table4 <- DT::renderDataTable({
    GO <- input$GO
    row_number <- which(GO_SMU$GO == GO)
    new_table <- slice(GO_SMU, row_number)

    new_table <- select(new_table, GO, name, SMU, Desc, logFC,
                        logCPM, PValue)

    datatable(new_table, options = list(lengthChange = FALSE))

  })

  #Plot for Search Term
  output$DescPlot <- renderPlot({

    gene_comp <- tTags_annot %>%
      select(SMU, logFC, logCPM, PValue, Desc, avgCPM_UA159, avgCPM_GMS584) %>%
      filter(str_detect(Desc,input$text))


    ggplot(gene_comp, aes(x = avgCPM_UA159, y = avgCPM_GMS584,
                          colour = logFC)) +
      geom_point(size = 3) +
      geom_abline(mapping = NULL, data = NULL, slope = 1, intercept = 0) +
      coord_cartesian(xlim = c(0, 20), ylim = c(0,20)) +
      scale_colour_gradient2(low="red", high="blue") +
      labs(title = paste("CPM Between UA159 and GMS84 for",
                         input$text),
           x= "UA159(CPM)", y = "GMS584(CPM)")
  })

#Data Table for Search Term
  output$table5 <- DT::renderDataTable({
    text <- input$text
    new_table <- tTags_annot %>%
      select(SMU, logFC, logCPM, PValue, Desc) %>%
      filter(str_detect(Desc,input$text))

    datatable(new_table, options = list(lengthChange = FALSE))
  })


})



# Run the application
shinyApp(ui = ui, server = server)

