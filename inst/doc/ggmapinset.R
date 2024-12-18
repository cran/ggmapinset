## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
suppressPackageStartupMessages(library(dplyr))

## ----setup--------------------------------------------------------------------
library(ggmapinset)
library(ggplot2)

nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)

## -----------------------------------------------------------------------------
head(mozzies_nsw2301)

## ----fig.width=9--------------------------------------------------------------
library(dplyr)
library(sf)

# just take the total count from a single week of the data
mozzies <- mozzies_nsw2301 |>
  filter(species == "total", week_ending == as.Date("2023-01-07")) |>
  st_as_sf(coords = c("long", "lat"), crs = st_crs("WGS84"))

labels <- c("Low (<50)", "Medium (50-100)", "High (101-1,000)",
            "Very High (1,001-10,000)", "Extreme (>10,000)")

scale1 <- scale_colour_manual(
  name = NULL,
  values = c("green", "gold", "darkorange", "red", "black"),
  labels = labels,
  na.value = "grey",
  drop = FALSE
)
scale2 <- scale_size_ordinal(
  name = NULL,
  labels = labels,
  range = c(3, 5),
  na.value = 2,
  drop = FALSE
)

ggplot(mozzies) +
  geom_sf(data = nswgeo::nsw, fill = NA) +
  geom_sf(aes(size = count, colour = count)) +
  geom_sf_text(aes(label = location), hjust = 0, nudge_x = 0.25, size = 3) +
  coord_sf(xlim = c(NA, 158)) +
  scale1 + scale2 +
  theme_void()

## ----fig.width=10-------------------------------------------------------------
library(ggrepel)

ggplot(mozzies) +
  geom_sf(data = nswgeo::nsw, fill = NA) +
  geom_sf(aes(size = count, colour = count)) +
  geom_text_repel(
    aes(label = location, geometry = geometry),
    hjust = 0,
    nudge_x = 0.25,
    size = 3,
    max.overlaps = 15,
    point.padding = 0,
    min.segment.length = 1,
    stat = "sf_coordinates"
  ) +
  coord_sf(xlim = c(NA, 158)) +
  scale1 + scale2 +
  theme_void()

## -----------------------------------------------------------------------------
sydney <- filter(mozzies, type == "sydney")
sydney_size <- st_distance(sydney, sydney) |> max() |> as.numeric() / 1000
sydney_centre <- st_union(sydney) |> st_centroid()

sydney_inset <- configure_inset(
  shape_circle(centre = sydney_centre, radius = sydney_size),
  translation = c(400, -200),
  scale = 4,
  units = "km"
)

## ----fig.width=10-------------------------------------------------------------
ggplot(mozzies) +
  geom_sf_inset(data = nswgeo::nsw, fill = NA) +
  geom_sf_inset(aes(size = count, colour = count), map_base = "clip") +
  geom_text_repel(
    aes(
      x = after_stat(x_inset),
      y = after_stat(y_inset),
      label = location,
      geometry = geometry
    ),
    hjust = 0,
    nudge_x = 0.25,
    size = 3,
    force_pull = 2,
    max.overlaps = Inf,
    point.padding = 0,
    min.segment.length = 1,
    stat = "sf_coordinates_inset"
  ) +
  geom_inset_frame() +
  coord_sf_inset(xlim = c(NA, 158), inset = sydney_inset) +
  scale1 + scale2 +
  theme_void()

## ----separate, fig.width=7, fig.height=3.5------------------------------------
ggplot(nc) +
  # this is equivalent to the following line:
  # geom_sf_inset(fill = "white", map_inset = "none") +
  geom_sf(fill = "white") +
  geom_sf_inset(aes(fill = AREA), map_base = "none") +
  geom_inset_frame() +
  coord_sf_inset(configure_inset(
    shape_circle(
      centre = sf::st_centroid(sf::st_geometry(nc)[nc$NAME == "Bladen"]),
      radius = 50
    ),
    scale = 1.5, translation = c(-180, -50),  units = "mi"
  ))

## ----frame_fill, fig.width=7, fig.height=3------------------------------------
ggplot(nc) +
  geom_sf(aes(fill = AREA)) +
  geom_inset_frame(target.aes = list(fill = "white")) +
  geom_sf_inset(aes(fill = AREA), map_base = "none") +
  coord_sf_inset(configure_inset(
    shape_circle(
      centre = st_centroid(st_geometry(nc)[nc$NAME == "Yancey"]),
      radius = 50
    ),
    scale = 2, translation = c(100, -120), units = "mi"
  ))

## ----multiple, fig.width=7, fig.height=5--------------------------------------
inset1 <- configure_inset(
  shape_rectangle(
    centre = sf::st_centroid(nc[nc$NAME == "Bladen", ]),
    hwidth = 50
  ),
  scale = 1.5, translation = c(150, -50), units = "mi"
)
inset2 <- configure_inset(
  shape_circle(
    centre = sf::st_centroid(nc[nc$NAME == "Orange", ]),
    radius = 30
  ),
  scale = 3, translation = c(30, 120), units = "mi"
)
inset3 <- configure_inset(
  shape_sf(nc[nc$NAME == "Gates", ]),
  scale = 6, translation = c(90, 70), units = "mi"
)

ggplot(nc) +
  # base map
  geom_sf_inset() +
  # inset 1
  geom_sf_inset(map_base = "none", inset = inset1) +
  geom_inset_frame(inset = inset1, colour = "red") +
  # inset 2
  geom_sf_inset(map_base = "none", inset = inset2) +
  geom_inset_frame(inset = inset2, colour = "blue") +
  # inset 3
  geom_sf_inset(map_base = "none", inset = inset3, colour = NA) +
  geom_inset_frame(inset = inset3, colour = "magenta")

