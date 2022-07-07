# load libraries
library(lubridate)
library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(plotly)

# read data files
raw_data <- read.csv("data/raw/ramp-data-232-2022-06-04 00_00_00-07_00-2022-07-05 00_00_00-07_00.csv")
view(raw_data)
detectors <- read.csv("data/raw/portaldetectors.csv")
stations <- read.csv("data/raw/portalstations.csv")

# reshaped dataframe to one observation per row
data <- pivot_longer(raw_data, cols = 2:11, names_to = "metric")

# changed time format
data$start_time <- ymd_hms(data$start_time, tz = "America/Los_Angeles")

# plot speed data
speed_fig <- data %>% 
  filter(metric == "speed.lane1") %>% 
  ggplot(aes(x = start_time, y = value)) + 
  geom_point() + geom_line()
speed_fig
ggplotly(speed_fig)

all_speeds_fig <- data %>%
  filter(metric %in% c("speed.lane1", "speed.lane2", "speed.lane3", "speed.lane4")) %>%  
  ggplot(aes(x = start_time, y = value, color = metric)) + 
  geom_point() +
  geom_line()
all_speeds_fig
ggplotly(all_speeds_fig)

volume_fig <- data %>% 
  filter(metric == "volume.lane1") %>% 
  ggplot(aes(x = start_time, y = value)) + 
  geom_bar(stat = "identity")
volume_fig
