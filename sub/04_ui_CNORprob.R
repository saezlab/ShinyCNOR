# --- Inputs and UI for CNORprob --- #

tabPanel(
  title="CNORprob",
  
  sidebarLayout(
    sidebarPanel(

      helpText("Preprocessing CNORprob"),
      checkboxInput("compression_CNORprob", "Compression CNORprob", FALSE),
      checkboxInput("expansion_CNORprob", "OR-gate expansion", FALSE),
      hr(),
      actionButton("run_CNORprob", label="Run CNORprob"),
      hr(),
      helpText("Optimisation settings:"),
      numericInput("nrRound_input", "Round of optimisation", 3, min = 1, max = 10),
      numericInput("maxTime_input", "Maximum optim. time [s]", 180, min = 10, max = 600),
      numericInput("sizeFac_input", "Size factor", 1e-04, min = -Inf, max = Inf),
      hr(),
      helpText("Post optimisation analyses:"),
      checkboxInput("edgeKO_input", "Edge Knock-out", FALSE),
      checkboxInput("nodeKO_input", "Node Knock-out", FALSE),
      checkboxInput("LPSA_input", "Parameter sensitivity analysis", FALSE),
      checkboxInput("BS_input", "Bootstrapping analysis", FALSE),
      actionButton("run_CNORprob", label="Run Post-hoc analysis"),
      helpText("See results in 'Results' folder")
      
      ),

    mainPanel(
      helpText("Initial network"),
      plotOutput("PlotPrepModel_CNORprob",width = "100%"),
      helpText("Optimised network"),
      plotOutput("PlotModel_CNORprob",width = "100%"),
      hr(),
      helpText("Data vs. Model prediction"),
      plotOutput("PlotFit_CNORprob",width = "100%"),
      hr()
    )),

  hr()
)

# --- End of the script --- #