library(shiny)

# Define the UI
ui <- fluidPage(
  titlePanel("Car Distribution"),
  sidebarLayout(
    sidebarPanel(
      selectInput("year", "Select a Year:", choices = unique(cars_colorado$Year)),
    ),
    mainPanel(
      plotOutput("piePlot")
    )
  )
)
server <- function(input, output) {
  
  selectedYearData <- reactive({
  cars_colorado[cars_colorado$Year == input$year, -1] # Exclude the Year column
})
  # Generate the pie plot based on the selected year
  output$piePlot <- renderPlot({
    selectedData <- selectedYearData()
    carTypes <- colnames(selectedData)
    carCounts <- unlist(selectedData)
    
    # Calculate the percentage for each car type
    percentages <- carCounts / sum(carCounts) * 100
  
    # Create the pie plot
    pie(percentages, labels = carTypes, main = paste("Car Distribution for Year", input$year))
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
