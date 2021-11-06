library(DT)
library(plotly)
library(geosphere)
library(dplyr)
library(ggpubr)
library(tidyverse)
library(tibble)
library(data.table)
library(shiny)
library(shiny.semantic)
library(leaflet.mapboxgl)
library(leaflet)
source("utils.R")
source("dropdown_selection_module.R")
source("not_box_module.R")
source("map_module.R")
source("Title_module.R")
options(mapbox.accessToken = "pk.eyJ1IjoiYXBwc2lsb24iLCJhIjoiY2s4YmdoaGl4MGJzczNsdHF0Mjg0eGd2cCJ9.PIE5mJe5pER9EFy088xz_A")
ui <- semanticPage(
    title = "SHIP App",
    shiny::tagList(
        tags$head(
            tags$link(rel="stylesheet", href="style.css", type="text/css" )
        ),
        div( h1("Ship sailing Analysis")),br(),
        sidebar_layout(
            sidebar_panel(
                select_vessel_type_UI("select_ship_type"),
                br(),br(),br(),br(),br(),
                a("@Github", href = "https://github.com/Medbenhmida/ShipSailingAnalysis",style = "padding-left: 30px;"),
                p( "Author : Mohamed Ben Hmida",style = "padding-left: 30px;"),
                p( "email : medbenhmida10@gmail.com",style = "padding-left: 30px;")
            ),
            main_panel(style = "background: #F9F9F9;",
                div(class="ui center aligned header",h3(title_UI("SHIP_NAME"))),
                div(class = "ui two column stackable grid container",
                    div(class = "six wide column",style = "text-align: center;",
                        
                        distance_inf_UI  ("LDistance"),
                        
                    ),
                    div(class = "ten wide column",
                        map_UI  ("map")
                    )
                )
            )
        ),
        br(),br(), br()
    )
    
)

server <- function(input, output, session) {
    SHIPTYPE_Module<-callModule(select_vessel_type_Server,"select_ship_type")
    longest_distance_df <- reactive({
        longest_distance(SHIPTYPE_Module$ship_types_select_result(),SHIPTYPE_Module$ship_names_select_result())
    })
    callModule(title_Server,"SHIP_NAME",SHIPTYPE_Module )
    callModule(distance_inf_Server,"LDistance",SHIPTYPE_Module,longest_distance_df )
    callModule(map_Server,"map",SHIPTYPE_Module,longest_distance_df )
}
shinyApp(ui, server)