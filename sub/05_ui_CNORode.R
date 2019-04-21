# --- Inputs and UI for CNORode --- #

tabPanel(
  title="CNORode",
  
  sidebarLayout(
    sidebarPanel(

      helpText("Preprocessing CNORode"),
      checkboxInput("compression_CNORode", "Compression CNORode", FALSE),
      # checkboxInput("expansion_CNORode", "OR-gate expansion", FALSE),
      helpText("Interaction types:"),
      radioButtons("transferFunction_input", "Transfer function type:",
                   c("Hill" = "2",
                     "Normalised Hill" = "3",
                     "Inv-norm-Hill" = "4"),selected = "4"),
      actionButton("run_CNORode", label="Run CNORode"),
      helpText("Optimisation bounds:"),
      sliderInput("k_range_slider", "Bounds for parameter k:",
                  min = 0, max = 10, value = c(1,5),step = 0.1),
      sliderInput("n_range_slider", "Bounds for parameter n:",
                  min = 1, max = 10, value = c(1,5),step = 0.1),
      sliderInput("tau_range_slider", "Bounds for parameter tau:",
                  min = 0, max = 10, value = c(0,1),step = 0.01),
      helpText("Termination conditions:"),
      numericInput("maxTime_ode_input", "Max. optim. time [s]", 15, min = 0, max = 120),
      numericInput("maxEval_ode_input", "Max. obj.func evaluation", 5000, min = 0, max = 1e5)
      ),
    
    mainPanel(
      helpText("PlotFit - CNORode"),
      plotOutput("PlotPrepModel_CNORode",width = "100%"),
      plotOutput("PlotFit_CNORode",width = "100%")
      # hr(),
      # helpText("PlotModel - CNORode"),
      # plotOutput("PlotModel_CNORode",width = "100%"),
    )),

  hr()
)