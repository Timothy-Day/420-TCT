#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    # Sample Size by Compound ####
    
    output$chems_obs.plot <- renderPlotly({
        # Draw the sample size illustration.
            plot_ly(
                chems_obs,
                x = ~ Compound,
                y = ~ Observations,
                name = "Number of Observations",
                type = "bar",
                marker = list(color = '#8B008B', 
                              line = list(color = '#8B008B', width = 1.5))
                )
    })
    
    # Histogram ####
    output$chems_obs.histo <- renderPlotly({
        
        h = input$chems_obs.histo_input
        
        h_sample <-
            df.001 %>%
            filter(., !is.na(!!rlang::sym(h)) & !!rlang::sym(h) > 0)
        
            
        plot_ly(h_sample, 
                type = 'histogram', 
                x =  ~ get(input$chems_obs.histo_input), 
                name = 'THC', 
                marker = list(color = '#8B008B'), 
                alpha = 1.0)
    }) 

 
    # Compound Select ####
    output$compound_select <- DT::renderDataTable(DT::datatable({
        t_select = input$compound_select_table
        t_n = 100
        t_sample <-
            df.001 %>%
            filter(., !is.na(!!rlang::sym(t_select)) & !!rlang::sym(t_select) > 0) %>%
            arrange(., desc(!!rlang::sym(t_select))) %>% 
            mutate_if(is.numeric, round, digits = 4)
        
        compound_select = t_sample[1:t_n,]

    }))
    
    output$chems_obs <- DT::renderDataTable(DT::datatable({
        chems_obs
    }))
    
    
    # 3D Scatter ####
    
    output$df.001_sample.scatter <- renderPlotly({   
        
        plot_ly(
            df.001,
            x = ~ get(input$sample_scatter_dim1_input),
            y = ~ get(input$sample_scatter_dim2_input),
            z = ~ get(input$sample_scatter_dim3_input),
            type = 'scatter3d',
            hoverinfo = 'text',
            text = ~paste(Sample.Name,
                          '<br>', as.character(input$sample_scatter_color_input),': ', get(input$sample_scatter_color_input),
                          '<br>', as.character(input$sample_scatter_dim1_input),': ', get(input$sample_scatter_dim1_input),
                          '<br>', as.character(input$sample_scatter_dim2_input),': ', get(input$sample_scatter_dim2_input),
                          '<br>', as.character(input$sample_scatter_dim3_input),': ', get(input$sample_scatter_dim3_input)),
            color = ~get(input$sample_scatter_color_input), colors = 'PuRd', marker = list(title = input$sample_scatter_color_input, opacity = 0.5)
        ) %>%
            add_markers() %>%
            layout(scene = list(
                xaxis = list(title = input$sample_scatter_dim1_input),
                yaxis = list(title = input$sample_scatter_dim2_input),
                zaxis = list(title = input$sample_scatter_dim3_input)
            ))
    })

# Strain Select Table ####
# Note that the below does not work as I want.  Working on it. Think I need to take the user-defined (strain,compound), \
    #determine the rank of the strain  relative to other strains that contain that compound, and take the nearest neighbors ...
    
    output$strain_select <- DT::renderDataTable(DT::datatable({
        ts_select = input$strain_select_compound 
        s_select = input$strain_select_strain
        t_n = 100
        s_sample <-
            df.001 %>%
            filter(., !is.na(!!rlang::sym(ts_select)) & !!rlang::sym(ts_select) > 0) %>%
            arrange(., desc(!!rlang::sym(ts_select))) %>% 
            mutate_if(is.numeric, round, digits = 4)
        strain_select = s_sample[1:t_n,]
        strain_select
    }))
    
    
})


