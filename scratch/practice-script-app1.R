# load packages ----
library(palmerpenguins)
library(tidyverse)
library(DT)

# filter data 
body_mass_df <- penguins |> 
  filter(body_mass_g %in% c(3000:4000))

# create scatter plot ----
ggplot(na.omit(body_mass_df),
       aes(x = flipper_length_mm, y = bill_length_mm,
           color = species,
           shape = species)) +
  geom_point() +
  scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
  scale_shape_manual(values = c("Adelie" = 19,"Chinstrap" = 17, "Gentoo" = 15)) +
  labs(x = "Flipper length (mm)",
         y = "Bill length (mm)",
         color = "Penguin species",
         shape = "Penguin species") +
  theme_minimal() +
  theme(
    legend.position = c(0.85, 0.2),
    legend.background = element_rect(color = "white")
  )

# filter dataframe for years
year_df <- penguins |> 
  filter(year %in% c(2007:2008))

DT::datatable(year_df)
