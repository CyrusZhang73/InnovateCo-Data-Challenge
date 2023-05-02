library(shiny)
library(leaflet)
library(leaflet.extras)

# Define the UI
ui <- fluidPage(
  titlePanel("Solar Power Heatmap"),
  leafletOutput("map")
)

# Define the server logic
server <- function(input, output) {
  
  # Load the solar power data from a CSV file
  solar_data <- read.csv("solar_in_colorado.csv")
  solar_data$X.1 <-scale(solar_data$X.1)
  # Render the leaflet map
  output$map <- renderLeaflet({
    leaflet(solar_data) %>%
      addTiles() %>%
      addHeatmap(
        lng = ~lng, 
        lat = ~lat, 
        intensity = ~X.1,
        blur = 30,
        max = 100,
        radius = 10
      ) %>%
      addLegend(
        position = "bottomright",
        title = "Solar Power (kW/m2)",
        colors = colorNumeric(palette = "YlOrRd", domain = solar_data$X.1)
      )
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
