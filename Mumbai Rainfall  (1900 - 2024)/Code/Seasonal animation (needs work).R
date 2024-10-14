library(tidyverse)
library(gganimate)

#Adjusting table structure
dataset <- `mumbai.monthly.rains[1]`
dataset_anime <- dataset %>%
  pivot_longer(cols = Jan:Dec,
               names_to = "Month",
               values_to = "Rainfall")

# Create a new column for the season based on the month
dataset_anime <- dataset_anime %>%
  mutate(Season = case_when(
    Month %in% c("Dec", "Jan", "Feb") ~ "Winter",
    Month %in% c("Mar", "April", "May") ~ "Summer",
    Month %in% c("June", "July", "Aug", "Sept") ~ "Monsoon",
    Month %in% c("Oct", "Nov") ~ "Post-Monsoon"
  ))

# Group the data by Season and Year, then calculate total rainfall for each season
seasonal_rainfall <- dataset_anime %>%
  group_by(Year, Season) %>%
  summarize(Total_Rainfall = sum(Rainfall, na.rm = TRUE))

# Create a line plot of seasonal rainfall over time
seasonal_plot <- ggplot(seasonal_rainfall, aes(x = Year, y = Total_Rainfall, colour = Season)) +
  geom_line(size = 1.5) +  # Thicker lines
  geom_point(size = 5, alpha = 0.8) +  # Larger points with some transparency
  scale_color_manual(values = c("Winter" = "steelblue", 
                                "Summer" = "orange", 
                                "Monsoon" = "green", 
                                "Post-Monsoon" = "purple")) +
  labs(x = "Year (1900 - 2024)",
       y = "Total Rainfall (in mm)",
       title = "Seasonal Rainfall Trends in Mumbai (1900 - 2024)",
       subtitle = "Grouped by Winter, Summer, Monsoon, and Post-Monsoon",
       caption = "Data Source: Kaggle | Visualization: James Lewis") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
    plot.subtitle = element_text(size = 14, hjust = 0.5),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(size = 12),
    legend.position = "right")

# Animate over the years with shadow effect
seasonal_animation <- seasonal_plot +
  transition_time(Year) +
  ease_aes('linear') +
  shadow_mark(alpha = 0.7, size = 1, colour = "gray")  # Adding shadow with transparency

# Render the animation
animate(seasonal_animation, nframes = 200, fps = 15, width = 800, height = 600, renderer = gifski_renderer("seasonal_rainfall_mumbai.gif"))

#####
#####I want it to leave a line plot behind, so its easier to track the points
##### This could be a mk1 into refining the animate plot


