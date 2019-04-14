# --- Inputs and UI for CellNOptR --- #

tabPanel(
  title="CellNOptR",
  
  sidebarLayout(
    sidebarPanel(

      helpText("Preprocessing CellNOptR"),

      checkboxInput("compression_CellNOptR", "Compression CellNOptR", FALSE),
      checkboxInput("expansion_CellNOptR", "Boolean gates expansion", FALSE),
      actionButton("run_CellNOptR", label="Run CellNOptR")),

    mainPanel(
      helpText("PlotModel - CellNOptR"),
      plotOutput("PlotPrepModel_CellNOptR",width = "100%"),
      plotOutput("PlotOptModel_CellNOptR",width = "100%"),
      hr(),
      helpText("PlotFit - CellNOptR"),
      plotOutput("PlotFit_CellNOptR",width = "100%")
      )),
  hr()

)

# --- End of the script --- #
