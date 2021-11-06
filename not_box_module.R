source("utils.R")

distance_inf_UI <- function(id) {
  ns <- NS(id)
  tagList(
    segment(div(h3(uiOutput(ns("LDistance"))),
                    p(style = "color: gray;height: 40px","Longest distance sailed between two consecutive observations (meter)"))),    
    segment(    div(h3(uiOutput(ns("LDistanceSpeed"))),
                    p(style = "color: gray;height: 40px;","Ship speed at the longest distance sailed (knot)"))),
    segment(    div(h3(uiOutput(ns("TotalDistance"))),
                    p(style = "color: gray;height: 40px;","Total distance sailed by the ship (meter)"))))
}
distance_inf_Server <- function(input, output, session,arg,arg2 ) {
    NS <- session$ns
    longest_distance_df <- reactive({
    longest_distance(arg$ship_types_select_result(),arg$ship_names_select_result())})
    longest_dist_info <- reactiveValues(x = 0,y=0,z=0,e="Analysis for the Ship:")
    output$LDistance<- renderUI({ longest_dist_info$x})
    output$TotalDistance<- renderUI({ longest_dist_info$z})
    output$LDistanceSpeed<- renderUI({ longest_dist_info$y})
    observeEvent(arg$ship_names_select_result(), {
      validate(
        need(nchar(arg$ship_names_select_result()) > 0, "Select Ship type to proceed...")
      ) 
    longest_dist_info$x =format(round(arg2()[1,"Distance"], 2), nsmall = 2)
    longest_dist_info$y =arg2()[1,"SPEED"]
    longest_dist_info$z =aggregate(arg2()$Distance, by=list(Category=arg2()$SHIPNAME), FUN=sum)[1,2]
    longest_dist_info$z=format(round(longest_dist_info$z, 2), nsmall = 2)
    })
    return(input)

  }