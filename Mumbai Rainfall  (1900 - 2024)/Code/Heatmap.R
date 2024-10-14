#Heatmap

#Loading packages

library(tidyverse)
library(ggplot2)
install.packages("gganimate")
library(gganimate)

#Creating clone dataset
dataset <- `mumbai.monthly.rains[1]`

#Adjusting table structure
dataset_Heat <- dataset %>%
  pivot_longer(cols = Jan:Dec,
               names_to = "Month",
               values_to = "Rainfall")

#Heatmap

ggplot(dataset_Heat, aes(x = Year, y = Month, fill = Rainfall)) +
  geom_tile() +
  scale_fill_viridis_c(option = "plasma") +  # Color intensity for rainfall
  labs(x = "Year (1900 - 2024)",
       y = "Month",
       title = "Yearly Rainfall Heatmap in Mumbai (1900 - 2024)",
       subtitle = "Visualizing monthly rainfall over time",
       caption = "Data Source: Kaggle | Visualization: James Lewis") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
    plot.subtitle = element_text(size = 14, hjust = 0.5),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(size = 12))

#Thoughts:
      # Its informative, but could be better coloured.
      #It feels like it lacks something. I think this would be great a long side a graphical plot
