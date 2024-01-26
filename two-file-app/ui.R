ui <- navbarPage(
  
  title = "LTER Animal Data Explorer",
  
  # (Page 1) intro tabPanel ----
  tabPanel(title = "About this App",
           
           # intro text fluidrow ----
           fluidRow(
             
             # set a blank column
             column(1),
             # there are 12 columns on a webpage so indicating to take all 12
             column(10, includeMarkdown("text/about.md")),
             column(1)
             
             
           ), # END intro text fluidrow
           
           # adds a light gray line at bottom of page
           hr(),
           
           # add footer beneath colored line
           includeMarkdown("text/footer.md")
           
           
  ), # END (Page 1) intro tabPanel
  
  # (Page 2) data viz tabPanel ----
  tabPanel(title = "Animal Data Explorer",
           
           # tabsetPanel to contain tabs for data viz ----
           tabsetPanel(
             
             # trout tabPanel ----
             tabPanel(title = "Trout",
                      
                      # trout sidebarLayout ----
                      sidebarLayout(
                        
                        # trout sidebarPanel ----
                        sidebarPanel(
                          
                          # channel type picker_input ----
                          pickerInput(inputId = "channel_type_input",
                                      label = "Select channel type(s):",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade", "pool"),
                                      options = pickerOptions(actionsBox = TRUE),
                                      multiple = TRUE),
                          
                          # section checkboxGroupbuttons ----
                          checkboxGroupButtons(inputId = "section_input",
                                                    label = "Select a sampling section(s):",
                                                    choices = c("clear cut forest", "old growth forest"),
                                                    selected = c("clear cut forest", "old growth forest"),
                                                    individual = FALSE, justified = TRUE, size = "sm",
                                              checkIcon = list(yes = icon("square-check"),
                                                               no = icon("square-xmark"))) # icons from font awesome
                          
                        ), # END trout sidebarPanel
                        
                        # trout mainPanel ----
                        mainPanel(
                          
                          # trout scatterplot output ----
                          plotOutput(outputId = "trout_scatterplot_output") |> 
                            withSpinner(color = "magenta", type = 1)
                          
                        ) # END trout mainPanel
                        
                      ) # END trout sidebarLayout
                      
             ), # END trout tabPanel 
             
             # penguin tabPanel ----
             tabPanel(title = "Penguins",
                      
                      # penguin sidebarLayout ----
                      sidebarLayout(
                        
                        # penguin sidebarPanel ----
                        sidebarPanel(
                          
                          # penguin island picker input
                          pickerInput(inputId = "island_input",
                                      label = "Select penguin island(s):",
                                      choices = unique(penguins$island),
                                      selected = c("Biscoe", "Dream", "Torgersen"),
                                      options = pickerOptions(actionsBox = TRUE),
                                      multiple = TRUE),
                          
                          # histogram bin slider input ----
                          sliderInput(inputId = "bin_input",
                                      # instructions 
                                      label = "Select number of bins on histogram:",
                                      min = 1, max = 100, 
                                      value = 25)
                          
                        ), # END penguin sidebarPanel
                        
                        # penguin mainPanel ----
                        mainPanel(
                          
                          # penguin histogram output ----
                          plotOutput(outputId = "penguin_histogram_output")|> 
                            withSpinner(color = "yellow", type = 4, size = 2)
                          
                          
                        ) # END penguin mainPanel
                        
                      ) # END penguin sidebarLayout
                      
             ) # END penguin tabPanel
             
           ) # END tabsetPanel
           
  ) # END (Page 2) data viz tabPanel
  
) # END navbarPage