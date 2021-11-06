
#' Load the ships data
#'
#' @param path character with data path
#'
#' @return data.frame with ships data
load_ships_data <- function(path = "https://github.com/Medbenhmida/ShipSailingAnalysis/ships.csv") {
  ships_data <- fread(path)
  ships_data
}

#' Distance between consecutive observations
#' 
#' @return data.frame with distance between consecutive observations
distance <- function() {
  ships_data=  ships_data %>% mutate(ships_data, 
         Distance = distHaversine(cbind(ships_data$LON, ships_data$LAT),
                                  cbind(lag(ships_data$LON), lag(ships_data$LAT)))) %>% 
         replace_na(list(Distance = 0))
}

#' Filter ship type
#'
#' @param ship_type character with ship type
#'
#' @return data.frame with ship type data
filter_ship_by_type<- function(selected_ship_type) {
  ships_data %>% filter(ship_type == selected_ship_type)
}


#' Longest distance between consecutive observations
#'
#' @return data.frame with distance between consecutive observations
longest_distance <- function(selected_ship_type,selected_ship_name) {
  ships_data %>% filter(ship_type == selected_ship_type ) %>%
                 filter(SHIPNAME == selected_ship_name) %>%
                 arrange(desc(Distance))
}


ships_data <- load_ships_data()
ships_data <- distance()