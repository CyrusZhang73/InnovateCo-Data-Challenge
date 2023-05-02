library(shiny)

# Define the UI
ui <- fluidPage(
  titlePanel("Car Distribution"),
  sidebarLayout(
    sidebarPanel(
      selectInput("year", "Select a Year:", choices = unique(cars_colorado$Year)),
    selectInput("plotType", "Select Plot Type:", choices = c("Grouped Bar Plot", "Scaled Bar Plot")),
    selectInput("FuelType", "Select fuel Type:", choices = colnames(cars_colorado)[-9]),
    br(),
    ),
    mainPanel(
      plotOutput("barplot")
    )
  )
)

# Define the server
server <- function(input, output) {
  
  
  generateGroupedBarPlot <- function() {
    selectedData <- cars_colorado
    ggplot(selectedData, aes(x = Year, y = .data[[input$FuelType]], fill = .data[[input$FuelType]])) +
      geom_bar(stat = "identity") +
      labs(x = "Year", y = "Amount", title = "Car Distribution by Year") +
      theme_bw() +
      theme(legend.position = "none")
  }
  
  generateScaledBarPlot <- function() {
    selectedData <- percentage_in_US
    ggplot(selectedData, aes(x = Year, y = .data[[input$FuelType]], fill = .data[[input$FuelType]])) +
      geom_bar(stat = "identity") +
      labs(x = "Year", y = "Scaled Value", title = "Scaled Car Distribution by Year") +
      theme_bw() +
      theme(legend.position = "none")
  }
  
  # Render the plot based on the selected plot type
  output$plot <- renderPlot({
    if (input$plotType == "Grouped Bar Plot") {
      generateGroupedBarPlot()
    } else if (input$plotType == "Scaled Bar Plot") {
      generateScaledBarPlot()
    }
  })
  
  
}
# Run the application
shinyApp(ui = ui, server = server)
