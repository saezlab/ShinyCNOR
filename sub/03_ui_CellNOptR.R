# --- Inputs and UI for CellNOptR --- #

tabPanel(
  title="CellNOptR",
  
  sidebarLayout(
    sidebarPanel(
      
      helpText("Preprocessing CellNOptR"),
      
      checkboxInput("compression_CellNOptR", "Compression CellNOptR", FALSE),
      checkboxInput("expansion_CellNOptR", "Boolean gates expansion", FALSE),
      hr(),
      actionButton("run_CellNOptR", label="Optimise model"),
      helpText("Optimisation settings:"),
      numericInput("maxTime_input", "Maximum optim. time [s]", 15, min = 0, max = 120),
      numericInput("sizeFac_input", "Size factor", 1e-04, min = -Inf, max = Inf),
      numericInput("NAFac_input", "NA factor", 1, min = 0, max = Inf),
      numericInput("popSize_input", "Population size", 50, min = 0, max = Inf),
      numericInput("pMutation_input", "Mutation probability", 0.5, min = 0, max = 1),
      numericInput("maxGens_input", "Maximum generations", 500, min = 0, max = 1000),
      numericInput("stallGenMax_input", "Stall generations", 100, min = 0, max = 500),
      numericInput("selPress_input", "Selective pressure", 1.2, min = 1, max = 2),
      numericInput("elitism_input", "Elitism", 5, min = 1, max = 100),
      numericInput("relTol_input", "Relative tolerance", 0.1, min = 0, max = 1)
    ),
    
    
    mainPanel(
      helpText("Initial network"),
      plotOutput("PlotPrepModel_CellNOptR",width = "100%"),
      helpText("Optimised network"),
      plotOutput("PlotOptModel_CellNOptR",width = "100%"),
      hr(),
      helpText("Data vs. Model prediction"),
      plotOutput("PlotFit_CellNOptR",width = "100%")
    )),
  hr()
  
)

# --- End of the script --- #
