tabPanel(
  title = "Upload Data",
  sidebarLayout(
    sidebarPanel(
      
      fileInput("upload_SIF", label="Upload SIF file"),
      fileInput("upload_MIDAS", label="Upload MIDAS file"),
      fileInput("upload_DF", label="Or upload data table file (for MIDAS-format conversion) - not working yet..."),
      
      checkboxInput("disp_SIF", "Show SIF data table", FALSE),
      checkboxInput("disp_MIDAS", "Show MIDAS data table", FALSE)),
    
    mainPanel(  
      helpText("Initial model structure"),
      plotOutput("PKNplot",width = "100%"),
      hr(),
      helpText("Data table: model structure"),
      DT::dataTableOutput("SIF"),
      hr(),
      helpText("Plot measurements"),
      plotOutput("MIDASplot",width = "100%"),
      hr(),
      helpText("Data table: MIDAS dataset"),
      DT::dataTableOutput("MIDAS")))
  
  #tags$iframe(style="height:400pm; width:100%; scrolling=yes",src="logo_saezlab.pdf")))
  
  #fileInput("upload_pprot", label="Upload phospho-protein expression"),
  # switchInput(inputId = "take_example_data", label = "Take example data",
  #             onLabel = "Yes", offLabel = "No", value=TRUE),
  # p("Example dataset taken ",
  #   a("Blackham et al, J Virol., 2010", 
  #     href = "https://www.ncbi.nlm.nih.gov/pubmed/20200238",
  #     target = "_blank"),
  
  #bookmarkButton(id = "upload_bookmark"),
  #  hr()
)

# --- End of the script --- #
