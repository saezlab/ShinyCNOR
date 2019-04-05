# --- Inputs and UI for CNORode --- #

tabPanel(
  title="CNORode",
  
  sidebarLayout(
    sidebarPanel(

      helpText("Preprocessing CNORode"),
      checkboxInput("compression_CNORode", "Compression CNORode", FALSE),
      # checkboxInput("expansion_CNORode", "OR-gate expansion", FALSE),
      actionButton("run_CNORode", label="Run CNORode")),
    
    mainPanel(
      helpText("PlotFit - CNORode"),
      plotOutput("PlotFit_CNORode",width = "100%")
      # hr(),
      # helpText("PlotModel - CNORode"),
      # plotOutput("PlotModel_CNORode",width = "100%"),
    )),

  hr()
)