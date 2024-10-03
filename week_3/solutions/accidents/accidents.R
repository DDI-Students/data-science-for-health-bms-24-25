library(tidyverse)
library(here)

# Load the data from the .rds file
accidents_data <- readRDS(here("data", "accidents.rds"))

# Add a column for Weekday/Weekend
accidents_data <- accidents_data %>%
  mutate(DayType = ifelse(wday(date) %in% c(1, 7), "Weekend", "Weekday"))

# Plotting the data
ggplot(accidents_data, aes(x = time, fill = severity)) +
  geom_density(alpha = 0.5) +
  facet_wrap(~DayType, ncol = 1) +
  theme_minimal() +
  labs(title = "Number of accidents throughout the day",
       subtitle = "By day of week and severity",
       x = "Time of day",
       y = "Density") +
  scale_fill_manual(
    values = c("Fatal" = "#D55E00", "Serious" = "#009E73", "Slight" = "#F0E442"), 
    name = "Severity"
  )
