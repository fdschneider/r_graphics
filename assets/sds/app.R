#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Biodiversity Exploratories : Land Use Intensity on Plots"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        selectInput(inputId = "exploratory",
                    label = "Exploratory region:",
                    choices = c("ALB", "HAI", "SCH")
                    ),
      sliderInput("year",
                    "Year of observation:",
                    min = 2006,
                    max = 2016,
                    value = 2014)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  output$distPlot <-  renderPlot({
    
    dd <- subset(LUI_factors, Year == input$year & Exploratory == input$exploratory )
    
   
    plot(LUI ~ EP_PlotID, 
         data = droplevels(dd),
         ylim = c(0,1)
         )
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

