# ---  CellNOptR reactive data--- # 

preprocessed_model_CellNOptR <- reactive({
  
  req(SIF_model(),CNO())
  
  prep_model <- preprocessing(model = SIF_model(), data = CNO(),cutNONC = T,
                              compression = input$compression_CellNOptR,
                              expansion = input$expansion_CellNOptR )
  return(prep_model)
  
})


# --- Output CellNOptR --- # 

# stores the optimisation results
res_CellNOptR <- reactive({
  req(input$run_CellNOptR,preprocessed_model_CellNOptR(),CNO())
  
  res <- gaBinaryT1(CNOlist = CNO(), model = preprocessed_model_CellNOptR(), verbose=FALSE)
  
})

# --- PlotModel CellNOptR --- #

output$PlotPrepModel_CellNOptR <-  renderPlot({
  
  req(preprocessed_model_CellNOptR())
  
  plotModel(model = preprocessed_model_CellNOptR(),CNOlist = CNO())
  
})


output$PlotOptModel_CellNOptR <- renderPlot({
  req(res_CellNOptR())
  
  plotModel(model = preprocessed_model_CellNOptR(), CNOlist = CNO(), bString = res_CellNOptR()$bString)
  
})

# --- PlotFit CellNOptR --- #

output$PlotFit_CellNOptR <- renderPlot({
  
  req(res_CellNOptR()) 
    
  cutAndPlot(CNOlist = CNO(), model = preprocessed_model_CellNOptR(), bStrings = list(res_CellNOptR()$bString))

})

# --- End of the script --- #