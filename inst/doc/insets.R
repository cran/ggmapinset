## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ggmapinset)
library(ggplot2)
library(sf)

nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)

## ----separate, fig.width=7, fig.height=3.5------------------------------------
cfg <- configure_inset(centre = st_centroid(st_geometry(nc)[nc$NAME == "Bladen"]),
                       scale = 1.5, translation = c(-180, -50), radius = 50, units = "mi")

ggplot(nc) +
  # this is equivalent to the following line:
  # geom_sf_inset(fill = "white", inset_copy = FALSE) +
  geom_sf(fill = "white") +
  geom_sf_inset(aes(fill = AREA), inset = cfg, inset_copy = FALSE) +
  geom_inset_frame(inset = cfg) +
  coord_sf()

## ----frame_fill, fig.width=7, fig.height=3------------------------------------
cfg <- configure_inset(centre = st_centroid(st_geometry(nc)[nc$NAME == "Yancey"]),
                       scale = 2, translation = c(100, -120), radius = 50, units = "mi")

ggplot(nc) +
  geom_sf(aes(fill = AREA)) +
  geom_inset_frame(inset = cfg, fill = c(NA, "white", NA, NA)) +
  geom_sf_inset(aes(fill = AREA), inset = cfg, inset_copy = FALSE) +
  coord_sf()

