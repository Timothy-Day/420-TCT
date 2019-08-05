
navbarPage(
  "Cannabis Strain Selection",
  theme = shinytheme("sandstone"),
  
  tabPanel('Descriptive',
           sidebarLayout(
             sidebarPanel(width = 2.0),
             mainPanel(
               h1("Cannabis' Chemical Constituents"),
               h2('Cannabidoids and Terpenes'),
               p('We are all familiar with marijuana and the active chemical constituents which include CBD and THC. \
                 What many are less familiar are the [25+] terpenes and 112+ additional cannabinoids. Terpenes are volatile hydrocarbonsfound in the essential oils \
                 of plants and can have profound physiological effects on the human body.  Cannabinoids are known for both their psychoactive and physiological effects.'
                 ),
               p('Research suggests that Cannabis sativa can (in the right circumstances) have positive effects. \
                 However, each strain acts differently on the body and, due to a dearth of research, we do not know which acts in what way.  \
                 The broad prohibition both in time and space on cannabis use has stymied research into this arena.'),
               p('This has also led to confounding issue regarding the strains themselves in that it is in general indeterminable \
                 as to whether a given strain is consistent to itself in name unless samples are known to be from the same plant. \
                 These two issues lead to the preponderance of incorrect information regarding strain effects never-mind which plant belongs to what strain.'),
               p('For our purposes, we assume strains are identical and aggregate accordingly. \
                 See ”Future Work” for the anticipated future treatment to correct this simplifying, and clearly incorrect, assumption.'),
               br(),
               h3('Compound Profiles'),
               p('We define a compound profile as a listing of active chemical constituents present in a biological sample. \
                 Here, we are concerned with the cannabinoids and terpenes.  Specifically, those listed at the below left.'
               ),
               p('In the interest of time, for purposes of analysis and ease of exposition, we aggregated isomer (and other) \
                 variants to arrive at the table above right.'
               ),
               br(),
               img(
                 src = 'chems.png',
                 height = "110%",
                 width = "110%",
                 align = "left"
               ),
               br(),
               br(),
               h3('Medicinal Uses by Compound'),
               img(
                 src = 'TCT-Uses-RefTable.png',
                 height = "110%",
                 width = "110%",
                 align = "left"
               ),
               br(),
               br(),
               h2('Future Work'),
               p("Coming Soon"),
               img(
                 src = 'Gary.png',
                 height = "50%",
                 width = "50%",
                 align = "left"
               )
               
             )
           )),
  
  tabPanel("Summary",
           sidebarLayout(
             sidebarPanel(width = 2.0),
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
             sidebarPanel(
               width = 2.0,
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
             sidebarPanel(
               width = 2.0,
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
