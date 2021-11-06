source("utils.R")

select_vessel_type_UI <- function(id) {
  ns <- NS(id)
  tagList(segment(
    h3("Select the vessel type"),
    uiOutput(ns("select_ship_type"))),br(),
    segment(
      h3("Select the vessel"),
      uiOutput(ns("select_ship_name"))))
}
  select_vessel_type_Server <- function(input, output, session) {
    NS <- session$ns
    ship_types <-unique(ships_data$ship_type)
    output$select_ship_type <- renderUI({
      dropdown_input(NS("ship_types_select_result"), ship_types)})
    ship_type_names <- reactive({
      validate(
        need(nchar(input[["ship_types_select_result"]]) > 0, "Select Ship type to proceed...")
      )
      unique(filter_ship_by_type(input[["ship_types_select_result"]])$SHIPNAME)
    })
    output$select_ship_name <- renderUI({
      dropdown_input(NS("ship_names_select_result"),ship_type_names())
    })
    return(list(ship_types_select_result = reactive({input$ship_types_select_result}), 
                ship_names_select_result   = reactive({input$ship_names_select_result})))  }