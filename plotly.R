#' ---
#' output:
#'   html_document:
#'     theme: united
#'     highlight: textmate
#' author: "Kamil Ciemniewski <kamil@ciemniew.ski>"
#' title: "Tertiary educational attainment, age group 30-34 by sex and NUTS 1 regions"
#' ---

#' In this work I'm exploring the tertriary education attament in the EU.
#'
#' # Obtaining Data

#+ get-data, collapse=TRUE
library(tidyverse)
library(plotly)
library(eurostat)
library(janitor)
library(knitr)
library(kableExtra)
library(magrittr)
library(glue)

edu.data <- get_eurostat(id='tgs00105')

#' The data comes directly from Eurostat. Let's see how it looks like:

edu.data %>% glimpse

edu.data %>% summary

#' We'll compare the percentage of members populations with terriary educational level attained
#' between 2018 and 2017. We'll compute the percentage difference which will give us a way to
#' quantify the 11 years change.

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

#' Let's look at the data:

edu.data %>%
  arrange(nuts_id) %>%
  kable %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>%
  scroll_box(width = "100%", height = "400px")

#' # 11 year percentage difference 2018-2017

plot_ly(
  x = edu.data$nuts_id,
  y = edu.data$diff
)

#' # Levels in 2018

plot_ly(
  x = edu.data$nuts_id,
  y = edu.data[["2018-01-01"]]
)

