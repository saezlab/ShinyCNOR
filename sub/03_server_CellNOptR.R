# ---  CellNOptR reactive data--- # 


preprocessed_model_CellNOptR <- reactive({
  
  req(SIF_model(),CNO())
  
  prep_model <- preprocessing(model = SIF_model(), data = CNO(),cutNONC = T,
                              compression = input$compression_CellNOptR,
                              expansion = input$expansion_CellNOptR )
  return(prep_model)
  
})


# --- Output CellNOptR --- # 
# res_CellNOptR: stores the model, data and optim results in a synchronised way.
# OptimalFit and optimNetwork plots are dependent on this data
res_CellNOptR = reactiveValues(pkn_model = NULL, 
                               cno_data = NULL,
                               optim_results = NULL)


# run optimisation upon button pressed:
observeEvent(input$run_CellNOptR,{
  print("res_CellNOptR triggered")
  req(input$run_CellNOptR,preprocessed_model_CellNOptR(),CNO())
  
  res <- gaBinaryT1(CNOlist = CNO(), model = preprocessed_model_CellNOptR(), verbose=FALSE,
                    sizeFac = input$sizeFac_input,
                    NAFac = input$NAFac_input,
                    popSize = input$popSize_input,
                    pMutation = input$pMutation_input,
                    maxTime = input$maxTime_input,
                    maxGens = input$maxGens_input,
                    stallGenMax = input$stallGenMax_input,
                    selPress = input$selPress_input,
                    elitism = input$elitism_input,
                    relTol = input$relTol_input)
  
  res_CellNOptR$pkn_model = preprocessed_model_CellNOptR()
  res_CellNOptR$cno_data = CNO()
  res_CellNOptR$optim_results = res
  
},ignoreInit = TRUE)

# --- PlotModel CellNOptR --- #

output$PlotPrepModel_CellNOptR <-  renderPlot({
  
  req(preprocessed_model_CellNOptR())
  
  plotModel(model = preprocessed_model_CellNOptR(),CNOlist = CNO())
  
})

# triggered when res_CellNOptR gets initialised/updated
output$PlotOptModel_CellNOptR <- renderPlot({
  
  if(is.null(res_CellNOptR$optim_results)) return(NULL)
  
  plotModel(model = res_CellNOptR$pkn_model,
            CNOlist = res_CellNOptR$cno_data,
            bString = res_CellNOptR$optim_results$bString)
  
})

# --- PlotFit CellNOptR --- #

# triggered when res_CellNOptR gets initialised/updated
output$PlotFit_CellNOptR <- renderPlot({
  
  if(is.null(res_CellNOptR$optim_results)) return(NULL)
  
  cutAndPlot(CNOlist = res_CellNOptR$cno_data,
             model = res_CellNOptR$pkn_model,
             bStrings = list(res_CellNOptR$optim_results$bString))
  
})

# --- End of the script --- #