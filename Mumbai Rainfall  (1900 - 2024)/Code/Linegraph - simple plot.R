# Simple Plot for each month

#Loading packages

library(tidyverse)
library(ggplot2)

#Creating clone dataset
dataset_simple <- `mumbai.monthly.rains[1]`

dataset_simple <- dataset %>%
  pivot_longer(cols = Jan:Dec,
               names_to = "Month",
               values_to = "Rainfall")

ggplot(dataset_simple, aes(x = Year, y = Rainfall, colour = Month)) +
  geom_line(alpha = 0.8, size = 1) +  # Line plot showing rainfall by year for each month
  scale_color_viridis_d(option = "plasma") +  # Use a color palette for months
  labs(x = "Year (1900 - 2024)",
       y = "Monthly Rainfall (in mm)",
       title = "Yearly Rainfall Trends in Mumbai (1900 - 2024)",
       subtitle = "Comparison of rainfall across months over time",
       caption = "Data Source: Kaggle | Visualization: James Lewis")
+
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
    plot.subtitle = element_text(size = 14, hjust = 0.5),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(size = 12),
    legend.position = "right")

#Thoughts:
# Its too chaotic
#I like the concept, but it needs to be more clear, Maybe i turn this into seasons


