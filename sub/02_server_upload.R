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

SIF = reactive({
  # if (input$take_example_data == F) {
  shinyjs::enable("upload_SIF")
  # shinyjs::enable("select_organism")
  inFile = input$upload_SIF
  if (is.null(inFile)){
    return(NULL)
  }
  read.table(inFile$datapath,header = F)
  # } else {
  #   shinyjs::disable("upload_expr")
  #   shinyjs::disable("select_organism")
  #   example_data 
  # }
})

MIDAS = reactive({
  # if (input$take_example_data == F) {
  shinyjs::enable("upload_MIDAS")
  # shinyjs::enable("select_organism")
  inFile = input$upload_MIDAS
  if (is.null(inFile)){
    return(NULL)
  }
  read_csv(inFile$datapath)
  # } else {
  #   shinyjs::disable("upload_expr")
  #   shinyjs::disable("select_organism")
  #   example_data 
  # }
})

DF = reactive({
  # if (input$take_example_data == F) {
  shinyjs::enable("upload_MIDAS")
  # shinyjs::enable("select_organism")
  inFile = input$upload_MIDAS
  if (is.null(inFile)){
    return(NULL)
  }
  read_csv(inFile$datapath)
  # } else {
  #   shinyjs::disable("upload_expr")
  #   shinyjs::disable("select_organism")
  #   example_data 
  # }
  
})

# --- Output Plots --- #

SIF_model <- reactive({
  
  req(input$upload_SIF)
  
  readSIF(input$upload_SIF$datapath)
})

output$PKNplot <- renderPlot({
  
  req(SIF_model())
  
  if(is.null(CNO())) plotModel(model = SIF_model())
  else plotModel(model = SIF_model(),CNOlist = CNO())
  
})

CNO <- reactive({
  req(input$upload_MIDAS)
  
  CNOlist(input$upload_MIDAS$datapath)
  
})


output$MIDASplot <- renderPlot({
  
  req(CNO())
  plotCNOlist(CNO())
  
})

# --- Output data table --- #

output$SIF = DT::renderDataTable({
  if (!is.null(SIF()) & input$disp_SIF) {
    DT::datatable(SIF(), option = list(scrollX = TRUE, autoWidth=T), 
                  filter = "top", selection = list(target = "none")) %>%
      formatSignif(which(map_lgl(SIF(), is.numeric)))
  }
})

output$MIDAS = DT::renderDataTable({
  if (!is.null(MIDAS())& input$disp_MIDAS) {
    DT::datatable(MIDAS(), option = list(scrollX = TRUE, autoWidth=T), 
                  filter = "top", selection = list(target = "none")) %>%
      formatSignif(which(map_lgl(MIDAS(), is.numeric)))
  }
})

# --- End of the script --- #
