source("utils.R")

title_UI <- function(id) {
  ns <- NS(id)
  tagList(
    uiOutput(ns("SHIP_NAME"))
  )
}
title_Server <- function(input, output, session,arg ) {
  NS <- session$ns
  ship_analysis_info <- reactiveValues(x ="Analysis for the Ship:")
  output$SHIP_NAME<- renderUI({ship_analysis_info$x})
  observeEvent(arg$ship_names_select_result(), {
    validate(
      need(nchar(arg$ship_names_select_result()) > 0, "Select Ship type to proceed...")
    )
    ship_analysis_info$x=paste("Analysis for the Ship:" , arg$ship_names_select_result())
  })  
  
}