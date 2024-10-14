library(tidyverse)
library(ggplot2)

#Creating 2nd dataset
dataset <- `mumbai.monthly.rains[1]`


# Graph of yearly changes

ggplot(data = dataset, aes(x=Year, y=Total, colour = Total)) +
  geom_point() +
  labs(x = "Years", y = "Total rainfall", title = "Yearly Rainfall in Mumbai (1900 - 2024)")


## What i would like is to compare each month. I could do this through a facet grid/ maybe ggpairs?
# First I will add months, then ill facet

ggplot(data = dataset, aes(x=Year, y=Total, colour = Total)) +
  geom_point() +
  facet_grid(. ~ Jan, Feb, Mar, April, June, July, Aug, Sept, Oct, Nov, Dec) +
  labs(x = "Bruh", y = "Total rainfall", title = "Yearly Rainfall in Mumbai (1900 - 2024)")

## This didnt work, so I will have to restructure my dataset

## I will use the pivot longer command

dataset_long <- dataset %>%
  pivot_longer(cols = Jan:Dec, # Adjust if you have different column names
               names_to = "Month",
               values_to = "Rainfall") 

# New data set created, based around monthly raunfall
# This data set no longer has yearly totals, but can be added

# Visualising it using facet

ggplot(data = dataset_long, aes(x = Year, y = Rainfall, colour = Rainfall)) +
  geom_point() +
  facet_wrap(~ Month) +  # This will create a separate graph for each month
  labs(x = "Year", y = "Total Rainfall", title = "Yearly Rainfall in Mumbai (1900 - 2024)")


# As we can see, August, July, June and September recieve significantly more rainfall than the other months.
# We can infer this is due to Monsoon season??

## Using chatgpt to see possible improvements:

ggplot(data = dataset_long, aes(x = Year, y = Rainfall, colour = Rainfall)) +
  geom_point(alpha = 0.7) +  # Add some transparency to avoid overcrowding
  geom_smooth(method = "loess", se = FALSE, colour = "black", linetype = "dashed") +  # Add smoothing lines
  facet_wrap(~ Month, ncol = 3) +  # Facet by month in a grid
  scale_color_viridis_c(option = "D", direction = -1) +  # Use the viridis color palette for colorblind-friendly and appealing color
  labs(x = "Year (1900 - 2024)",
       y = "Monthly Rainfall (in mm)",
       title = "Yearly Rainfall Trends in Mumbai (1900 - 2024)",
       subtitle = "Monthly breakdown of rainfall in Mumbai over time",
       caption = "Data Source: Kaggle | Visualization: James Lewis") +  # Add title, subtitle, and caption for a professional look
  theme_minimal(base_size = 14) +  # Apply a minimal theme with a larger font size for readability
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5),  # Center and bold the title
    plot.subtitle = element_text(size = 14, hjust = 0.5),  # Center the subtitle
    axis.title = element_text(face = "bold"),  # Bold axis titles
    axis.text = element_text(size = 12),  # Adjust axis text size
    strip.text = element_text(face = "bold", size = 12),  # Facet labels (months) to be bold
    legend.position = "none"  # Remove the legend since it's not necessary for point colors
  )


# I am going to try to create an animated plot.

install.packages("gganimate")
library(gganimate)

          ## Lighter coloured Plot

Gif_Mumbai <- ggplot(dataset_long, aes(x = Year, y = Rainfall, colour = Rainfall)) +
  +   geom_point(alpha = 0.7, show.legend = FALSE) +
  +   scale_color_viridis_c(option = "D", direction = -1) +
  +   scale_size(7) +
  +   scale_x_log10() +
  +   facet_wrap(~ Month, ncol = 3) +
  +   labs(x = "Year (1900 - 2024)",
           +        y = "Monthly Rainfall (in mm)",
           +        title = "Yearly Rainfall Trends in Mumbai (1900 - 2024)",
           +        subtitle = "Monthly breakdown of rainfall over time",
           +        caption = "Data Source: Kaggle | Visualization: James Lewis") +
  +   theme_minimal(base_size = 14) +
  +   theme(
    +     plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
    +     plot.subtitle = element_text(size = 14, hjust = 0.5),
    +     axis.title = element_text(face = "bold"),
    +     axis.text = element_text(size = 12),
    +     strip.text = element_text(face = "bold", size = 12),
    +     legend.position = "none") +
  +   transition_time(Year) +      # Animate over time (Year)
  +   view_follow(fixed_y = TRUE) +  # Keep the y-axis fixed for better comparison
  +   ease_aes('linear') +          # Smooth transitions
  +   shadow_mark(alpha = 0.3, size = 1)


      ## High-level animation 

animate(Gif_Mumbai, nframes = 200, fps = 15, width = 800, height = 600, renderer = gifski_renderer("mumbai_rainfall.gif"))



      ## Below is the dark version of the plot

Gif_Mumbai <- ggplot(dataset_long, aes(x = Year, y = Rainfall, colour = Rainfall)) +
  +   geom_point(alpha = 0.7, show.legend = FALSE) +
  +   scale_color_viridis_c(option = "plasma", direction = -1) +  # Lighter colors for points
  +   scale_size(7) +
  +   scale_x_log10() +
  +   facet_wrap(~ Month, ncol = 3) +
  +   labs(x = "Year (1900 - 2024)",
           +        y = "Monthly Rainfall (in mm)",
           +        title = "Yearly Rainfall Trends in Mumbai (1900 - 2024)",
           +        subtitle = "Monthly breakdown of rainfall over time",
           +        caption = "Data Source: Kaggle | Visualization: James Lewis") +
  +   theme_dark(base_size = 14) +  # Switch to a dark theme
  +   theme(
    +     plot.title = element_text(face = "bold", size = 16, hjust = 0.5, color = "white"),
    +     plot.subtitle = element_text(size = 14, hjust = 0.5, color = "white"),
    +     axis.title = element_text(face = "bold", color = "white"),
    +     axis.text = element_text(size = 12, color = "white"),
    +     strip.text = element_text(face = "bold", size = 12, color = "white"),
    +     legend.position = "none",
    +     panel.background = element_rect(fill = "black"),
    +     plot.background = element_rect(fill = "black"),
    +     panel.grid = element_line(color = "gray")) +  # Light gridlines for better visibility
  +   transition_time(Year) +  
  +   view_follow(fixed_y = TRUE) +  
  +   ease_aes('linear') +         
  +   shadow_mark(alpha = 0.3, size = 1, colour = "white")

animate(Gif_Mumbai, nframes = 200, fps = 15, width = 800, height = 600, renderer = gifski_renderer("mumbai_rainfall_dark.gif"))


# This format is fun, but overwhelming and not very informative.