# --- Output CellNOptR --- # 

preprocessed_model_CellNOptR <- NULL
res_CellNOptR <- NULL

# --- PlotModel CellNOptR --- #

output$PlotModel_CellNOptR <- renderPlot({
  
  if (input$run_CellNOptR) {
    
    preprocessed_model_CellNOptR <<- preprocessing(model = SIF_model, data = cno,cutNONC = T,
                                                   compression = input$compression_CellNOptR,
                                                   expansion = input$expansion_CellNOptR )
    res <<- gaBinaryT1(CNOlist = cno, model = preprocessed_model_CellNOptR, verbose=FALSE)
    plotModel(model = preprocessed_model_CellNOptR,CNOlist = cno, bString = res_CellNOptR$bString)
  }
})

# --- PlotFit CellNOptR --- #

output$PlotFit_CellNOptR <- renderPlot({

  if (input$run_CellNOptR) {
  
    preprocessed_model_CellNOptR <<- preprocessing(model = SIF_model, data = cno,cutNONC = T,
                                       compression = input$compression_CellNOptR,
                                       expansion = input$expansion_CellNOptR )
    res_CellNOptR <<- gaBinaryT1(CNOlist = cno, model = preprocessed_model_CellNOptR, verbose=FALSE)
    cutAndPlot(CNOlist = cno, model = preprocessed_model_CellNOptR, bStrings = list(res_CellNOptR$bString))
  
  }
})

# --- End of the script --- #