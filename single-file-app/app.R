# load packages ----
library(shiny)
library(palmerpenguins)
library(tidyverse)
library(DT)

# user interface ----
ui <- fluidPage(
  
  # app title as a level 1 header in html and bolded ----
  tags$h1(strong("Single file App")),
  
  # app subtitle as a level 4 header in html (aka smaller) and bolded ----
  h4(strong("Exploring Arctic Penguin Data")),
  
  # body mass slider input ----
  sliderInput(inputId = "body_mass_input",
              # instructions 
              label = "Select a range of bady masses (g)",
              min = 2700, max = 6300, 
              value = c(3000, 4000)),
  
  # body mass plot output ---- 
  plotOutput(outputId = "bodyMass_scatterplot_output"),
  
  # year input ----
  checkboxGroupInput(inputId = "year_input",
                     label = "Select year(s):",
                     choices = c("2007", "2008", "2009"),
                     selected = c("2007", "2008")),
  
  # dt  output ----
  DT::dataTableOutput(outputId = "penguin_DT_output")
)


# server ----
server <- function(input, output) {
  
  # filter body masses ---- 
  body_mass_df <- reactive({
    
    penguins |> 
      # brackets specify slider value like low and high
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
  })

  
  # render penguin scatter plot ----
  output$bodyMass_scatterplot_output <- renderPlot({ # generate plot
    
    # add ggplot code here
    # create scatter plot
    # reactive data frame requires a set of () after any df's
    ggplot(na.omit(body_mass_df()),
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
        legend.background = element_rect(color = "white"))
  }) 
  
  # filter for years ----
  years_df <- reactive({
    
    penguins |> 
      filter(year %in% c(input$year_input))
  })
  
  # render DT table ----
  output$penguin_DT_output <- DT::renderDataTable({
    
    DT::datatable(years_df())
  })
  
  
}

# combine ui and server into app ----
shinyApp(ui = ui,
         server = server)

