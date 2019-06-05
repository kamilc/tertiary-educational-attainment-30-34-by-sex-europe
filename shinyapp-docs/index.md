---
title       : Tertiary educational attainment, age group 30-34 by sex and NUTS 1 regions
subtitle    : App Presentation
author      : Kamil Ciemniewski <kamil@ciemniew.ski>
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      #
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Intro



Eurostat is the source of lots of data for the EU countries. The assignment
Shiny app allows to easily explore the tetriary education level assignment
accross Union's countries.

---

## Data

Here's how the from Eurostat looks like:

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> 2007-01-01 </th>
   <th style="text-align:right;"> 2018-01-01 </th>
   <th style="text-align:right;"> diff </th>
   <th style="text-align:left;"> nuts_id </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 23.26667 </td>
   <td style="text-align:right;"> 43.73333 </td>
   <td style="text-align:right;"> 20.466667 </td>
   <td style="text-align:left;"> AT1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 18.36667 </td>
   <td style="text-align:right;"> 38.16667 </td>
   <td style="text-align:right;"> 19.800000 </td>
   <td style="text-align:left;"> AT2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 19.33333 </td>
   <td style="text-align:right;"> 38.13333 </td>
   <td style="text-align:right;"> 18.800000 </td>
   <td style="text-align:left;"> AT3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 47.60000 </td>
   <td style="text-align:right;"> 56.26667 </td>
   <td style="text-align:right;"> 8.666667 </td>
   <td style="text-align:left;"> BE1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 42.03333 </td>
   <td style="text-align:right;"> 48.16667 </td>
   <td style="text-align:right;"> 6.133333 </td>
   <td style="text-align:left;"> BE2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 38.03333 </td>
   <td style="text-align:right;"> 42.50000 </td>
   <td style="text-align:right;"> 4.466667 </td>
   <td style="text-align:left;"> BE3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 22.20000 </td>
   <td style="text-align:right;"> 25.76667 </td>
   <td style="text-align:right;"> 3.566667 </td>
   <td style="text-align:left;"> BG3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 29.96667 </td>
   <td style="text-align:right;"> 40.30000 </td>
   <td style="text-align:right;"> 10.333333 </td>
   <td style="text-align:left;"> BG4 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 36.50000 </td>
   <td style="text-align:right;"> 55.00000 </td>
   <td style="text-align:right;"> 18.500000 </td>
   <td style="text-align:left;"> CH0 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 46.20000 </td>
   <td style="text-align:right;"> 56.90000 </td>
   <td style="text-align:right;"> 10.700000 </td>
   <td style="text-align:left;"> CY0 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 13.33333 </td>
   <td style="text-align:right;"> 33.86667 </td>
   <td style="text-align:right;"> 20.533333 </td>
   <td style="text-align:left;"> CZ0 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 29.96667 </td>
   <td style="text-align:right;"> 39.06667 </td>
   <td style="text-align:right;"> 9.100000 </td>
   <td style="text-align:left;"> DE1 </td>
  </tr>
</tbody>
</table>

---

## Map

<img src="map1.png" title="map" alt="map" width="100%" />

---

## App UI

<img src="screen.png" title="ui" alt="ui" width="100%" />
