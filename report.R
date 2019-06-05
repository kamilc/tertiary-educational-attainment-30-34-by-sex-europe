#' ---
#' output:
#'   html_document:
#'     theme: united
#'     highlight: textmate
#' author: "Kamil Ciemniewski <kamil@ciemniew.ski>"
#' title: "Tertiary educational attainment, age group 30-34 by sex and NUTS 1 regions"
#' ---

#' In this work I'm exploring the tertriary education attament in the EU. The document
#' includes the interactive maps as a result at its bottom.
#'
#' # Obtaining Data

#+ get-data, collapse=TRUE
library(tidyverse)
library(leaflet)
library(eurostat)
library(janitor)
library(knitr)
library(kableExtra)
library(magrittr)
library(geojsonio)
library(spdplyr)
library(glue)

geo_file <- 'NUTS_RG_60M_2016_4326_LEVL_1.geojson'
geo_zip <- 'map.zip'

if(!file.exists(geo_file)) {
  download.file(
    'https://ec.europa.eu/eurostat/cache/GISCO/distribution/v2/nuts/download/ref-nuts-2016-60m.geojson.zip',
    destfile=geo_zip
  )
  unzip(geo_zip)
}

maps <- geojson_read(geo_file, what="sp")
maps$NUTS_ID <- as.character(maps$NUTS_ID)

edu.data <- get_eurostat(id='tgs00105')

#' The data comes directly from Eurostat. Let's see how it looks like:

edu.data %>% glimpse

edu.data %>% summary

#' We'll compare the percentage of members populations with terriary educational level attained
#' between 2018 and 2017. We'll compute the percentage difference which will give us a way to
#' quantify the 11 years change. Two maps will be presented - the one overlaying the change
#' and the one showing actual percentages in 2018.

edu.data %<>% filter(time == "2007-01-01" | time == "2018-01-01") %>%
  select(-unit, -isced11, -age) %>%
  group_by(geo, time) %>%
  summarise(values=mean(values, na.rm = TRUE)) %>%
  ungroup %>%
  spread(time, values) %>%
  mutate(diff=.[["2018-01-01"]] - .[["2007-01-01"]]) %>%
  drop_na() %>%
  mutate(nuts_id=as.character(geo)) %>%
  select(-geo) %>%
  filter(nuts_id %in% maps$NUTS_ID)

maps <- maps[maps$NUTS_ID %in% edu.data$nuts_id, ]
maps <- maps[match(edu.data$nuts_id, maps$NUTS_ID), ]

#' Let's look at the data:

edu.data %>%
  arrange(nuts_id) %>%
  kable %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(width = "100%", height = "400px")

#' # Map overlay of the 11 year percentage difference 2018-2017

pal <- colorNumeric(
  palette = colorRamp(c("#ff0000", "#00ff00"), interpolate='spline'),
  domain = edu.data$diff
)

labels <-
  glue("<strong>{edu.data$nuts_id}</strong><br/>{edu.data$diff}%") %>%
  lapply(htmltools::HTML)

#+ map, cache=FALSE
leaflet(maps, width="100%") %>%
  addPolygons(
    color = 'grey',
    weight=0.5,
    opacity = 1,
    fillColor=~pal(edu.data$diff),
    label = labels,
    labelOptions = labelOptions(
      style = list("font-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto"
    ),
    highlight = highlightOptions(
      weight = 1,
      color = "#666",
      fillOpacity = 0.7,
      bringToFront = TRUE
    )
  ) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addLegend(
    pal = pal,
    values = ~edu.data$diff,
    opacity = 0.7,
    title = NULL,
    position = "bottomright"
  )

#' # Map overlay of the percentage levels in 2018

pal <- colorNumeric(
  palette = colorRamp(c("#ff0000", "#00ff00"), interpolate='spline'),
  domain = edu.data[["2018-01-01"]]
)

labels <-
  glue("<strong>{edu.data$nuts_id}</strong><br/>{edu.data[[\"2018-01-01\"]]}%") %>%
  lapply(htmltools::HTML)

#+ map2, cache=FALSE
leaflet(maps, width="100%") %>%
  addPolygons(
    color = 'grey',
    weight=0.5,
    opacity = 1,
    fillColor=~pal(edu.data[["2018-01-01"]]),
    label = labels,
    labelOptions = labelOptions(
      style = list("font-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto"
    ),
    highlight = highlightOptions(
      weight = 1,
      color = "#666",
      fillOpacity = 0.7,
      bringToFront = TRUE
    )
  ) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addLegend(
    pal = pal,
    values = ~edu.data[["2018-01-01"]],
    opacity = 0.7,
    title = NULL,
    position = "bottomright"
  )
