% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/layer_helpers.R
\name{build_sf_inset_layers}
\alias{build_sf_inset_layers}
\title{Build layers to implement an inset-compatible geometry}
\usage{
build_sf_inset_layers(
  data,
  mapping,
  stat,
  position,
  show.legend,
  inherit.aes,
  params,
  inset,
  map_base = "normal",
  map_inset = "auto"
)
}
\arguments{
\item{data}{The data to be displayed in this layer. There are three
options:

If \code{NULL}, the default, the data is inherited from the plot
data as specified in the call to \code{\link[ggplot2:ggplot]{ggplot()}}.

A \code{data.frame}, or other object, will override the plot
data. All objects will be fortified to produce a data frame. See
\code{\link[ggplot2:fortify]{fortify()}} for which variables will be created.

A \code{function} will be called with a single argument,
the plot data. The return value must be a \code{data.frame}, and
will be used as the layer data. A \code{function} can be created
from a \code{formula} (e.g. \code{~ head(.x, 10)}).}

\item{mapping}{Set of aesthetic mappings created by \code{\link[ggplot2:aes]{aes()}}. If specified and
\code{inherit.aes = TRUE} (the default), it is combined with the default mapping
at the top level of the plot. You must supply \code{mapping} if there is no plot
mapping.}

\item{stat}{The statistical transformation to use on the data for this
layer, either as a \code{ggproto} \code{Geom} subclass or as a string naming the
stat stripped of the \code{stat_} prefix (e.g. \code{"count"} rather than
\code{"stat_count"})}

\item{position}{Position adjustment, either as a string naming the adjustment
(e.g. \code{"jitter"} to use \code{position_jitter}), or the result of a call to a
position adjustment function. Use the latter if you need to change the
settings of the adjustment.}

\item{show.legend}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.
It can also be a named logical vector to finely select the aesthetics to
display.}

\item{inherit.aes}{If \code{FALSE}, overrides the default aesthetics,
rather than combining with them. This is most useful for helper functions
that define both data and aesthetics and shouldn't inherit behaviour from
the default plot specification, e.g. \code{\link[ggplot2:borders]{borders()}}.}

\item{params}{Additional parameters to the \code{geom} and \code{stat}.}

\item{inset}{Inset configuration; see \code{\link[=configure_inset]{configure_inset()}}.
If \code{NA} (the default), this is inherited from the coord (see \code{\link[=coord_sf_inset]{coord_sf_inset()}}).}

\item{map_base}{Controls the layer with the base map. Possible values are
\code{"normal"} to create a layer as though the inset were not specified,
\code{"clip"} to create a layer with the inset viewport cut out, and
\code{"none"} to prevent the insertion of a layer for the base map.}

\item{map_inset}{Controls the layer with the inset map. Possible values are
\code{"auto"} to choose the behaviour based on whether \code{inset} is specified,
\code{"normal"} to create a layer with the viewport cut out and transformed, and
\code{"none"} to prevent the insertion of a layer for the viewport map.}
}
\value{
A \code{ggplot} layer, or a pair of layers.
}
\description{
For plotting, use \code{\link[=geom_sf_inset]{geom_sf_inset()}} instead. This helper is intended to be used when
implementing custom geometries based on \code{\link[=geom_sf_inset]{geom_sf_inset()}} so that they can provide
parameters to control the inset.
}
\examples{
my_custom_geom <- function(mapping = ggplot2::aes(),
                           data = NULL,
                           stat = "my_custom_stat",
                           position = "identity",
                           ...,
                           inset = NA,
                           map_base = "normal",
                           map_inset = "auto",
                           na.rm = TRUE,
                           inherit.aes = TRUE) {
  params <- rlang::list2(na.rm = na.rm, ...)
  build_sf_inset_layers(data = data, mapping = mapping,
                        stat = stat, position = position,
                        show.legend = show.legend,
                        inherit.aes = inherit.aes,
                        params = params,
                        inset = inset,
                        map_base = map_base,
                        map_inset = map_inset)
}
}
