# Seasonal Adjustment mumbai plots
# https://github.com/ellisp/ggseas

#Loading packages

library(tidyverse)
library(ggplot2)
install.packages("forecast")
library(forecast)
install.packages("ggseas")
library(ggseas)

#Creating clone dataset
dataset <- `mumbai.monthly.rains[1]`

#Adjusting table structure
dataset_seas <- dataset %>%
  pivot_longer(cols = Jan:Dec,
               names_to = "Month",
               values_to = "Rainfall")


# Convert the data into a time series object for use with ggseas
# First, create a numeric month value for each row
dataset_seas <- dataset_seas %>%
  mutate(date = as.Date(paste(Year, Month, "01", sep = "-"), format = "%Y-%b-%d"))

# Summarize monthly rainfall data into a time series object
rainfall_ts <- ts(dataset_seas$Rainfall, 
                  start = c(min(dataset_seas$Year), 1), 
                  frequency = 12)

# Create a ggseas plot with STL decomposition (seasonal, trend, and remainder)
ggseas_plot <- autoplot(stl(rainfall_ts, s.window = "periodic")) +
  labs(title = "Seasonal Decomposition of Rainfall in Mumbai (1900-2024)",
       subtitle = "Decomposing Rainfall into Trend, Seasonal, and Remainder Components",
       x = "Year",
       y = "Rainfall (mm)") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
    plot.subtitle = element_text(size = 14, hjust = 0.5),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(size = 12))

# Show the plot
print(ggseas_plot)


#It still needs to be more clear.....
# What is remainder
# It needs refining but the graph is awesome
