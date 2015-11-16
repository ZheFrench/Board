library(shiny)
library(d3heatmap)
library(shinythemes)
library(markdown)
require(RColorBrewer)

#bootstrapPage, fluidPage, navbarPage, or fixedPage
shinyUI(

  navbarPage(
    title = 'IURC Board',
    theme = shinytheme("cerulean"),  #  Application title
   tags$head( tags$title('Example linked stylesheet'), tags$link(rel = 'stylesheet', type = 'text/css', href = 'style.css')), 
    tabPanel("Home",
             fluidRow(
               column(12,
                      includeMarkdown("HOME.md")
               )
             ),
             fluidRow(
              column(6),
              column(3,
                      img(class="img-polaroid",
                          src=paste0("carte.jpg"))
                      ,tags$small( "Laboratoire de Génétique Moléculaire, ",
                     "Institut Universitaire de Recherche Clinique, ",
                     "641 avenue du Doyen Gaston Giraud",
                     "34093 Montpellier Cedex 5", "France")
               )
             )
    )
   ,
     navbarMenu("Tools",
#           tabPanel('HeatMap',
#                         sidebarLayout(
#                           sidebarPanel(
#                             h3("Heatmap Generator"),
#                             
#                             fileInput('file1', 'Choose CSV File', accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
#                             textInput("gene",
#                                       "Gene Symbol:",
#                                       "SPRED1"),
#                           
#                           selectInput("palette", "Palette", c("Reds", "Greens", "Blues")),                          
#                              actionButton("goButton", "Go!")
#                           ),
#                           mainPanel(
#                             #tableOutput("values"),
#                             includeMarkdown("Heatmap.md")
#                             )
#                         ),
#                         fluidRow(column(12,d3heatmapOutput("heatmap",  width = "auto")  ) )
#                ), 
#                
                tabPanel('CNV-HeatMap',
                         sidebarLayout(
                           sidebarPanel(
                             h3("CNV-HeatMap"),
                             
                             fileInput('file2', 'Choose CSV File', accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
                             #checkboxInput("grad", "Gradiant", FALSE),
                             textInput("gene2",
                                       "Gene Symbol:",
                                       "SPRED1"),
                             sliderInput("slider1", label = h4("Homozygous Deletion - upper limit"), min = 0, 
                                         max = 0.1, step=0.01,value = 0.05),
                             sliderInput("slider2", label = h4("Heterozygous Deletion - window"), min = 0, step=0.01,
                                         max = 0.99, value = c(0.25, 0.77)),
                             sliderInput("slider3", label = h4("Duplication - lower limit"), min = 1, 
                                         max = 1.5, step=0.01,value = 1.25),
                             actionButton("goButton2", "Go!")
                            
                           ),
                           mainPanel(
                             #tableOutput("values"),
                             includeMarkdown("Heatmap2.md")
                           )
                         ),
                         
                         #tags$div(id="heatmapPlot", style="background-color:red;margin-left:-300px;padding-left:-30px"),
                         fluidRow(column(3,textOutput("count") )),
                         fluidRow(column(3,  tableOutput('table'),
                                         #4 Make the final row bold using tags$style
                                         tags$style(type="text/css", "#table td {font-weight:bold;text-align:center;}") )  ,column(9, plotOutput("heatmapPlot",  width = "100%",height="1180px") ) ) #  
                                  
                   )
#,
#                   tabPanel("About",
#                        fluidRow(
#                         column(6,
#                                includeMarkdown("Readme.md")
#                          ),
#                          column(3,
#                                 img(class="img-polaroid",
#                                     src=paste0("carte.jpg")),
#                                 tags$small(
#                                   "Source: Google ",
#                                   "Montpellier localised near Mediteranean sea")
#                          )
#                        )
#               )
    )
  )

)