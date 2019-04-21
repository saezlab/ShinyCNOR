# --- Output CNORode --- # 

preprocessed_model_CNORode <- NULL
res_CNORode <- NULL

# --- PlotModel CNORode --- #

output$PlotFit_CNORode <- renderPlot({
  
  if (input$run_CNORode) {
    
    # Pre-processing CNORode (set gate expansion to False by default[?])
    # preprocessed_model_CNORode <<- preprocessing(model = SIF_model, data = cno,cutNONC = T,
    #                                              compression = input$compression_CNORode,
    #                                              expansion = F )
    preprocessed_model_CNORode <<- preprocessing(model = SIF_model(), data = CNO(),cutNONC = T,
                                                 compression = input$compression_CNORode,
                                                 expansion = F )
    
    # Initialise parameters
    initial_pars=createLBodeContPars(preprocessed_model_CNORode, LB_n = 1, LB_k = 0.1,
                                     LB_tau = 0.01, UB_n = 5, UB_k = 0.9, UB_tau = 10, random = TRUE)
    paramsGA = defaultParametersGA()
    paramsGA$maxStepSize = 1
    paramsGA$popSize = 50
    paramsGA$iter = 100
    paramsGA$transfer_function = 2
    
    # Optimisation
    # opt_pars=parEstimationLBode(cno,preprocessed_model_CNORode,ode_parameters=initial_pars,
    #                             paramsGA=paramsGA)
    opt_pars=parEstimationLBode(CNO(),preprocessed_model_CNORode,ode_parameters=initial_pars,
                                paramsGA=paramsGA)
    
    # Plotting
    # plotLBodeFitness(cno, preprocessed_model_CNORode,ode_parameters=opt_pars)
    plotLBodeFitness(CNO(), preprocessed_model_CNORode,ode_parameters=opt_pars)
    
  }
})

# --- End of the script --- #
