#' ---
#' output:
#'   html_document:
#'     theme: united
#'     highlight: textmate
#' author: "Kamil Ciemniewski <kamil@ciemniew.ski>"
#' title: "Tertiary educational attainment, age group 30-34 by sex and NUTS 1 regions"
#' ---

library(tidyverse)
library(leaflet)
library(eurostat)
library(janitor)
library(knitr)
library(kableExtra)
library(magrittr)

geo_file <- 'map.geojson'

if(!file.exists(geo_file)) {
  download.file(
    'https://datahub.io/core/geo-nuts-administrative-boundaries/r/nuts_rg_60m_2013_lvl_1.geojson',
    destfile=geo_file
  )
}

maps <- geojson_read(geo_file, what="sp")

query <- search_eurostat("education", type = "table") %>%
  select(code, title)

query %>%
  kable %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(width = "100%", height = "400px")

query %>%
  filter(code == 'tgs00105') %>%
  unique %>%
  kable %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"))

edu.data <- get_eurostat(id='tgs00105')

edu.data %>% glimpse

edu.data %>% summary

edu.data %<>% filter(time == "2007-01-01" | time == "2018-01-01")
edu.data %<>% select(-unit, -isced11, -age)
edu.data %<>%
  group_by(geo, time) %>%
  summarise(values=mean(values, na.rm = TRUE)) %>%
  ungroup

edu.data %<>% spread(time, values)
edu.data %<>% mutate(diff=.[["2018-01-01"]] - .[["2007-01-01"]])
edu.data %<>% drop_na()
edu.data %<>% mutate(nuts_id=geo) %>% select(-geo)

edu.data %>%
  arrange(nuts_id) %>%
  kable %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(width = "100%", height = "400px")

pal <- colorNumeric(
  palette = "YlOrRd",
  domain = edu.data$diff
)

#+ map, cache=FALSE
leaflet(maps, width="100%") %>%
  addPolygons(
    color = 'grey',
    weight=0.5,
    opacity = 1,
    fillColor=~pal(edu.data$diff)
  ) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addLegend(
    pal = pal,
    values = ~edu.data$diff,
    opacity = 0.7,
    title = NULL,
    position = "bottomright"
  )

#+ map2, cache=FALSE
leaflet(maps, width="100%") %>%
  addPolygons(
    color = 'grey',
    weight=0.5,
    opacity = 1,
    fillColor=~pal(edu.data[["2018-01-01"]])
  ) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addLegend(
    pal = pal,
    values = ~edu.data[["2018-01-01"]],
    opacity = 0.7,
    title = NULL,
    position = "bottomright"
  )