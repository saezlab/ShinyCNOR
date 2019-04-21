# --- Button trigger control --- #(to be checked - doesn't work for now...)
# if a file is uploaded, the calculation button in enabled 

observeEvent({
  input$upload_SIF
  input$upload_MIDAS
  input$take_example_data}, {
    toggleState("run_CellNOptR",
                # input$take_example_data == T | (!is.null(input$upload_SIF) & !is.null(input$upload_MIDAS)) )
                (!is.null(input$upload_SIF) & !is.null(input$upload_MIDAS)) )
    toggleState("run_CNORprob",
                # input$take_example_data == T | (!is.null(input$upload_SIF) & !is.null(input$upload_MIDAS)) )
                (!is.null(input$upload_SIF) & !is.null(input$upload_MIDAS)) )
    toggleState("run_CNORode",
                # input$take_example_data == T | (!is.null(input$upload_SIF) & !is.null(input$upload_MIDAS)) )
                (!is.null(input$upload_SIF) & !is.null(input$upload_MIDAS)) )
  })

# --- Upload data --- #

SIF_raw = reactive({
  # here data is imported as text
  if(devel_data){
    warning("development version")
    read.table("data/examples/ToyPKNMMB.sif",header = F) 
  }else{
    req(input$upload_SIF)
    read.table(input$upload_SIF$datapath, header = F)
  }
})


SIF_model <- reactive({
  # here data is converted to model object (PKN)
  if(devel_data){
    warning("development version")
    readSIF("data/examples/ToyPKNMMB.sif") 
  }else{
    req(input$upload_SIF)
    readSIF(input$upload_SIF$datapath)
  }
})

MIDAS_raw = reactive({
  # here data is imported as text
  if(devel_data){
    warning("development version")
    read_csv("data/examples/ToyDataMMB.csv") 
  }else{
    req(input$upload_MIDAS)
    read_csv(input$upload_MIDAS$datapath)
  }
})

CNO <- reactive({
  # here data is converted to CNOlist object
  if(devel_data){
    warning("development version")
    CNOlist("data/examples/ToyDataMMB.csv") 
  }else{
    req(input$upload_MIDAS)
    
    CNOlist(input$upload_MIDAS$datapath)
  }
  
})

# --- Output Plots --- #


output$PKNplot <- renderPlot({
  
  req(SIF_model())
  
  if(is.null(CNO())) plotModel(model = SIF_model())
  else plotModel(model = SIF_model(),CNOlist = CNO())
  
})

output$MIDASplot <- renderPlot({
  
  req(CNO())
  plotCNOlist(CNO())
  
})

# --- Output data table --- #

# -- SIF_data_table
output$SIF_data_table = DT::renderDataTable({
  
  req(SIF_raw())
  
  DT::datatable(SIF_raw(), option = list(scrollX = TRUE, autoWidth=T), 
                filter = "top", selection = list(target = "none")) %>%
    formatSignif(which(map_lgl(SIF_raw(), is.numeric)))
  
})

# tick-box control of show SIF_data_table
observeEvent(input$disp_SIF, {
  
  if (input$disp_SIF) shinyjs::show("SIF_data_table") else shinyjs::hide("SIF_data_table")
})


# -- MIDAS_data_table
output$MIDAS_data_table = DT::renderDataTable({
  req(MIDAS_raw())
  
  DT::datatable(MIDAS_raw(), option = list(scrollX = TRUE, autoWidth=T), 
                filter = "top", selection = list(target = "none")) %>%
    formatSignif(which(map_lgl(MIDAS_raw(), is.numeric)))
  
})

# tick-box control of show MIDAS_data_table
observeEvent(input$disp_MIDAS, {
  if (input$disp_MIDAS) shinyjs::show("MIDAS_data_table") else shinyjs::hide("MIDAS_data_table")
})

# --- End of the script --- #
