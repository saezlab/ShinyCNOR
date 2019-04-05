# --- Inputs and UI for CNORprob --- #

tabPanel(
  title="CNORprob",
  
  sidebarLayout(
    sidebarPanel(

      helpText("Preprocessing CNORprob"),
      checkboxInput("compression_CNORprob", "Compression CNORprob", FALSE),
      checkboxInput("expansion_CNORprob", "OR-gate expansion", FALSE),
      actionButton("run_CNORprob", label="Run CNORprob")),

    mainPanel(
      helpText("PlotModel - CNORprob"),
      plotOutput("PlotModel_CNORprob",width = "100%"),
      hr(),
      helpText("PlotFit - CNORprob"),
      plotOutput("PlotFit_CNORprob",width = "100%"),
      hr()
    )),

  hr()
)

# --- End of the script --- #