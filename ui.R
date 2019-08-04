
navbarPage("Cannabis Strain Selection",
           theme = shinytheme("sandstone"),
           
           tabPanel("Summary",
                    sidebarLayout(
                        sidebarPanel(width = 2.0,
                        ),
                        mainPanel(
                            plotlyOutput('chems_obs.plot'),
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            br(),
                            DT::dataTableOutput("chems_obs")
                        )
                    )),
           
           tabPanel("Compounds",
                    sidebarLayout(
                      sidebarPanel(width = 2.0,
                        selectInput("chems_obs.histo_input", "Histogram Input:",
                                    choices = cols),
                        selectInput("compound_select_table", "Table Input:",
                                    choices = cols)
                      ),
                      mainPanel(
                        plotlyOutput('chems_obs.histo'),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        DT::dataTableOutput("compound_select")
                      )
                    )),
           
           tabPanel("Strains",
                    sidebarLayout(
                      sidebarPanel(width = 2.0, 
                        'Plot Inputs',
                        selectInput("sample_scatter_color_input", "Color By:", choices = cols),
                        selectInput("sample_scatter_dim1_input", "Compound 1:", choices = cols),
                        selectInput("sample_scatter_dim2_input", "Compound 2:", choices = cols),
                        selectInput("sample_scatter_dim3_input", "Compound 3:", choices = cols),
                        br(),
                        br(),
                        'Table Strain Select',
                        selectInput("strain_select_compound", "Compound:", choices = cols),
                        selectInput("strain_select_strain", "Strain:", choices = df.001$Sample.Name)
                      ),
                      mainPanel(
                        plotlyOutput('df.001_sample.scatter'),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        br(),
                        DT::dataTableOutput('strain_select')
                      )
                    ))
)
           