# load libraries
library(lubridate)
library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)

# read data files
raw_data <- read.csv("data/raw/ramp-data-232-2022-06-04 00_00_00-07_00-2022-07-05 00_00_00-07_00.csv")
view(raw_data)
detectors <- read.csv("data/raw/portaldetectors.csv")
stations <- read.csv("data/raw/portalstations.csv")

# reshaped dataframe to one observation per row
data <- pivot_longer(raw_data, cols = 2:11, names_to = "metric")

# changed time format
data$start_time <- ymd_hms(data$start_time, tz = "America/Los_Angeles")
