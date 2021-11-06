source("utils.R")

map_UI <- function(id) {
  ns <- NS(id)
  tagList(
    segment(
      leafletOutput(ns("map"))
    )
  )
}
map_Server <- function(input, output, session,arg,arg2 ) {
  NS <- session$ns
  output$map <- renderLeaflet({
    
    leaflet() %>% addTiles() %>%
      addMapboxGL(style = "mapbox://styles/mapbox/streets-v9") %>%
      setView(lng = 18.99692	, lat =54.77127	, zoom = 2) 
    
  })
  observeEvent(arg$ship_names_select_result(), {
    validate(
      need(nchar(arg$ship_names_select_result()) > 0, "Select Ship type to porceed...")
    )
    leafletProxy(NS("map"))   %>%
      clearControls() %>%      
      clearMarkers() %>%                    
      addCircleMarkers(
        data = cbind(arg2()[1,"LON"], arg2()[1,"LAT"]), fillColor = "goldenrod",
        fillOpacity = 1,stroke = F,
        layerId = 1
      )%>%
      addCircleMarkers(
        data = cbind(arg2()[2,"LON"], arg2()[2,"LAT"]), fillColor = "red",
        fillOpacity = 1,stroke = F,
        layerId = 2)%>%
      flyTo(lng = as.numeric(arg2()[2,2]),
            lat = as.numeric(arg2()[2,1]), zoom = 10)%>% 
      addLegend("topright", 
       colors =c("red",  "goldenrod"),
       labels= c("Arrival point", "Starting point"),
       opacity = 1)
    
  })  
  
}