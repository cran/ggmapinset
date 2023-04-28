## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ggmapinset)
library(ggplot2)

nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)

## ----separate, fig.width=7, fig.height=3.5------------------------------------
ggplot(nc) +
  # this is equivalent to the following line:
  # geom_sf_inset(fill = "white", map_inset = "none") +
  geom_sf(fill = "white") +
  geom_sf_inset(aes(fill = AREA), map_base = "none") +
  geom_inset_frame() +
  coord_sf_inset(inset = configure_inset(
    centre = sf::st_centroid(sf::st_geometry(nc)[nc$NAME == "Bladen"]), scale = 1.5,
    translation = c(-180, -50), radius = 50, units = "mi"))

## ----frame_fill, fig.width=7, fig.height=3------------------------------------
ggplot(nc) +
  geom_sf(aes(fill = AREA)) +
  geom_inset_frame(target.aes = list(fill = "white")) +
  geom_sf_inset(aes(fill = AREA), map_base = "none") +
  coord_sf_inset(inset = configure_inset(
    centre = st_centroid(st_geometry(nc)[nc$NAME == "Yancey"]), scale = 2,
    translation = c(100, -120), radius = 50, units = "mi"))

## ----multiple, fig.width=7, fig.height=5--------------------------------------
inset1 <- configure_inset(
  centre = sf::st_centroid(sf::st_geometry(nc)[nc$NAME == "Bladen"]), scale = 1.5,
  translation = c(150, -50), radius = 50, units = "mi")
inset2 <- configure_inset(
  centre = sf::st_centroid(sf::st_geometry(nc)[nc$NAME == "Orange"]), scale = 3,
  translation = c(30, 120), radius = 30, units = "mi")

ggplot(nc) +
  # base map
  geom_sf_inset() +
  # inset 1
  geom_sf_inset(map_base = "none", inset = inset1) +
  geom_inset_frame(inset = inset1, colour = "red") +
  # inset 2
  geom_sf_inset(map_base = "none", inset = inset2) +
  geom_inset_frame(inset = inset2, colour = "blue")

