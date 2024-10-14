
#Loading packages

library(tidyverse)
library(ggplot2)
install.packages("ggseas")
library(ggseas)

#Creating clone dataset
dataset <- `mumbai.monthly.rains[1]`

dataset_line <- dataset %>%
  pivot_longer(cols = Jan:Dec,
               names_to = "Month",
               values_to = "Rainfall")


yearly_totals <- dataset_line %>%
  group_by(Year) %>%
  summarize(Total_Rainfall = sum(Rainfall, na.rm = TRUE))

ggplot(yearly_totals, aes(x = Year, y = Total_Rainfall)) +
  geom_line(color = "steelblue", size = 1) +
  geom_point(size = 2) +
  labs(x = "Year (1900 - 2024)",
       y = "Total Yearly Rainfall (in mm)",
       title = "Total Yearly Rainfall in Mumbai (1900 - 2024)",
       subtitle = "Visualizing the overall rainfall trend across years",
       caption = "Data Source: Kaggle | Visualization: James Lewis") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
    plot.subtitle = element_text(size = 14, hjust = 0.5),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(size = 12))