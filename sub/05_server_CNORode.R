# ---  CNORode reactive data--- # 


preprocessed_model_CNORode <- reactive({
  
  req(SIF_model(),CNO())
  print(input$maxTime_input)
  prep_model <- preprocessing(model = SIF_model(), data = CNO(),cutNONC = T,
                              compression = input$compression_CNORode,
                              expansion = FALSE)
  return(prep_model)
  
})


# --- Output CNORode --- # 
# res_CNORode: stores the model, data and optim results in a synchronised way.
# OptimalFit and optimNetwork plots are dependent on this data
res_CNORode = reactiveValues(pkn_model = NULL, 
                             cno_data = NULL,
                             optim_results = NULL,
                             transfer_function = NULL)


# run optimisation upon button pressed:
observeEvent(input$run_CNORode,{
  
  req(preprocessed_model_CNORode(),CNO())
  
  # Initialise parameters
  initial_pars=createLBodeContPars(preprocessed_model_CNORode(), 
                                   LB_n = input$n_range_slider[[1]], UB_n = input$n_range_slider[[2]],
                                   LB_k = input$k_range_slider[[1]], UB_k = input$k_range_slider[[2]],
                                   LB_tau = input$tau_range_slider[[1]], UB_tau = input$tau_range_slider[[2]],
                                   random = TRUE)
  
  opt_pars <- parEstimationLBodeSSm(cnolist = CNO(),
                        model = preprocessed_model_CNORode(),
                        ode_parameters = initial_pars,
                        maxeval = input$maxEval_ode_input,
                        maxtime = input$maxTime_ode_input,
                        transfer_function = input$transferFunction_input)
  
  res_CNORode$pkn_model <- preprocessed_model_CNORode()
  res_CNORode$cno_data <- CNO()
  res_CNORode$optim_results <- opt_pars
  res_CNORode$transfer_function <- input$transferFunction_input
  
},ignoreInit = TRUE)

# --- PlotModel CNORode --- #

output$PlotPrepModel_CNORode <-  renderPlot({
  
  req(preprocessed_model_CNORode())
  
  plotModel(model = preprocessed_model_CNORode(),CNOlist = CNO())
  
})

# --- PlotFit CNORode --- #

# triggered when res_CNORode gets initialised/updated
output$PlotFit_CNORode <- renderPlot({
  
  if(is.null(res_CNORode$optim_results)) return(NULL)
  plotLBodeFitness(res_CNORode$cno_data,
                   res_CNORode$pkn_model,
                   ode_parameters=res_CNORode$optim_results,
                   transfer_function = res_CNORode$transfer_function)
  
})

# --- End of the script --- #

