# --- Generate CNORprob model --- #

optmodel_CNORprob <- reactive({
  
  # ---------------------------- # 
  
  # if (input$run_CNORprob) {
  #   
  #   # Assign CNORprob-specitifc parameters for pre-processing step
  #   ProbCompression <- input$compression_CNORprob;
  #   ProbCutNONC <- T;
  #   
  #   # Run CNORprob-specific pre-processing (expansion=FALSE by default and report)
  #   ModDatppProb <- preprocessing_Prob(CNO(), SIF_model(), expansion=FALSE,
  #                                      compression=ProbCompression, cutNONC=ProbCutNONC,
  #                                      verbose=FALSE)
  #   optmodel <- ModDatppProb$cutModel
  #   #  optCNOlist <- ModDatppProb$data
  #   
  #   return(optmodel)
  # }
  
  # ---------------------------- # 
    
  req(SIF_model(),CNO())
  
  # Run CNORprob-specific pre-processing (expansion=FALSE by default and report)
  ModDatppProb <- preprocessing_Prob(CNO(), SIF_model(), 
                                     compression=input$compression_CNORprob, 
                                     expansion=F,
                                     cutNONC=T,
                                     verbose=FALSE)
  optmodel <- ModDatppProb$cutModel
  #  optCNOlist <- ModDatppProb$data
    
  return(optmodel)
  # }
  
  
})

optCNOlist_CNORprob <- reactive({
  
  # ---------------------------- # 
  
  # if (input$run_CNORprob) {
  #   
  #   # Assign CNORprob-specitifc parameters for pre-processing step
  #   ProbCompression <- input$compression_CNORprob;
  #   ProbCutNONC <- T;
  # 
  #   # Run CNORprob-specific pre-processing (expansion=FALSE by default and report)
  #   ModDatppProb <- preprocessing_Prob(CNO(), SIF_model(), expansion=FALSE,
  #                                      compression=ProbCompression, cutNONC=ProbCutNONC,
  #                                      verbose=FALSE)
  #   # optmodel <- ModDatppProb$cutModel
  #   optCNOlist <- ModDatppProb$data
  #   
  #   return(optCNOlist)
  # }
  
  # ---------------------------- # 
  
  req(SIF_model(),CNO())
  
  # Run CNORprob-specific pre-processing (expansion=FALSE by default and report)
  ModDatppProb <- preprocessing_Prob(CNO(), SIF_model(), 
                                     compression=input$compression_CNORprob, 
                                     expansion=F,
                                     cutNONC=T,
                                     verbose=FALSE)
  # optmodel <- ModDatppProb$cutModel
  optCNOlist <- ModDatppProb$data
  
  return(optCNOlist)
  
})
    

# --- Optimise CNORprob model --- #

res_CNORprob <- reactive({

  if (input$run_CNORprob) {
    
    ProbExpandOR <- input$expansion_CNORprob;
    ProbHardConstraint <- F;
    ProbForce <- F # Default (most-relaxed) setting
    
    # Assign optimisation and parameter settings
    optRound_optim    <- input$nrRound_input        # rounds of optimisation
    L1Reg             <- input$sizeFac_input     # assign weight for L1-regularisation
    MaxTime           <- input$maxTime_input      # time for each round of optimisation [seconds]
    HLbound           <- 0.5      # cut-off for high and low weights
    SSthresh          <- 2e-16    # cut-off for states' difference at steady-state
    printCost         <- 0        # print or not print intermediate fitting cost [0,1]
    PlotIterations    <- 1        # rounds of optimisation to generate plots
    SaveOptResults    <- TRUE     # [TRUE,FALSE] generate reports from optimisation
    
    # Optimiser (rsolnp) options/control list (see rsolnp vignette: https://cran.r-project.org/web/packages/Rsolnp/Rsolnp.pdf)
    rho               <- 1        # penalty weighting scaler / default = 1
    outer.iter        <- 100       # maximum major iterations / default = 400
    inner.iter        <- 100       # maximum minor iterations / default = 800
    delta             <- 1e-7     # relative step size eval. / default = 1e-7
    tol               <- 1e-8     # relative tol. for optim. / default = 1e-8
    trace             <- 1        # print objfunc every iter / default = 1
    
    # Post-optimisation analysis
    Analyses          <- c(input$edgeKO_input, # edge knockout
                           input$nodeKO_input, # node knockout
                           input$LPSA_input, # sensitivity analysis
                           input$BS_input) # bootstrapping analysis
    optRound_analysis <- 1        # rounds of optmisation in each analysis
    LPSA_Increments   <- 2        # number of increments in LPSA analysis
    BS_Type           <- 1        # Type of Bootstrapping [1=resample with replacement from residual; 2=resampling from mean & variant]
    BS_Round          <- 5       # number of rounds for bootstrapping
    
    estim_Result   <<- list() # Initialise global variable of results
    rsolnp_options  <- list(rho=rho,outer.iter=outer.iter,inner.iter=inner.iter,delta=delta,tol=tol,trace=trace) # Collapase optimisation options
    
    # Generate optimisation object
    estim <<- CNORprob_buildModel(optCNOlist_CNORprob(),optmodel_CNORprob(),
                                  expandOR=ProbExpandOR,ORlist=NULL,
                                  HardConstraint=ProbHardConstraint,
                                  Force=ProbForce,
                                  L1Reg=L1Reg,HLbound=HLbound,SSthresh=SSthresh,
                                  PlotIterations=PlotIterations,rsolnp_options=rsolnp_options)
    
    # Run Optimisation
    estim$maxtime <- MaxTime; estim$printCost <- printCost
    estim$optimOptions <- c(rho,outer.iter,inner.iter,delta,tol,trace)
    res <<- CNORprob_optimise(estim,optRound_optim,SaveOptResults)
  
  estim_Result   <<- list() # Initialise global variable of results
  estim$ProbCompression <- input$compression_CNORprob
  estim$ProbCutNONC <- T
  estim$ProbExpandOR <- input$expansion_CNORprob
  estim$optRound_analysis <- optRound_analysis
  estim_original <- estim
  estim_based <- estim_original; if (Analyses[1]) { estim_Result  <- CNORprob_edgeKO(optmodel_CNORprob(),optCNOlist_CNORprob(),estim_based,res) }
  estim_based <- estim_original; if (Analyses[2]) { estim_Result  <- CNORprob_nodeKO(optmodel_CNORprob(),optCNOlist_CNORprob(),estim_based,res) }
  estim_based <- estim_original; if (Analyses[3]) { estim_Result  <- CNORprob_LPSA(estim_based,res,HLbound,LPSA_Increments,Force=F) }
  estim_based <- estim_original; if (Analyses[4]) { estim_Result  <- CNORprob_BS(optmodel_CNORprob(),optCNOlist_CNORprob(),estim_based,res,BS_Type,BS_Round) }
  
  save(estim_Result,file="Results/CNORprob_PostHocResults.Rdata")
  
  return(res)
  
  }
  
})


# --- PlotModel CNORprob --- #

output$PlotPrepModel_CNORprob <- renderPlot({
  
  req(optmodel_CNORprob(),optCNOlist_CNORprob)
  
  plotModel(model = optmodel_CNORprob(),CNOlist = optCNOlist_CNORprob())
  
})

# triggered when res_CellNOptR gets initialised/updated
# output$PlotOptModel_CellNOptR <- renderPlot({
#   
#   if(is.null(res_CellNOptR$optim_results)) return(NULL)
#   
#   plotModel(model = res_CellNOptR$pkn_model,
#             CNOlist = res_CellNOptR$cno_data,
#             bString = res_CellNOptR$optim_results$bString)
#   
# })


output$PlotModel_CNORprob <- renderPlot({
  
  if (input$run_CNORprob) {
    
    # Plot model
    MappedProb <- CNORprob_mapModel(optmodel_CNORprob(),optCNOlist_CNORprob(),estim,res_CNORprob())
    plotModel(MappedProb$model,MappedProb$CNOlist,round(MappedProb$bString,digits=2))
  
  }
  
})

output$PlotFit_CNORprob <- renderPlot({
  
  if (input$run_CNORprob) {
    
    # Plot fit
    CNORprob_plotFit(optmodel_CNORprob(),optCNOlist_CNORprob(),estim,res_CNORprob(),show=TRUE, plotPDF=TRUE, tag=NULL, plotParams=list(cex=0.8, cmap_scale=1, ymin=0))

  }
})

# --- BkUp code for one-liner function (which doesn't work now...) --- #

# preprocessed_model_CNORprob <<- preprocessing(model = SIF_model, data = cno,cutNONC = T,
#                                                compression = input$compression_CNORprob,
#                                                expansion = input$expansion_CNORprob )
# # SIF_model <<- readSIF(input$upload_SIF$datapath)
# res <<- gaBinaryT1(CNOlist = cno, model = preprocessed_model_CNORprob, verbose=FALSE)
# cutAndPlot(CNOlist = cno, model = preprocessed_model_CNORprob, bStrings = list(res_CNORprob$bString))

# res_CNORprob <<- runCNORprob(model=input$upload_SIF$datapath,data = input$upload_MIDAS$datapath,
#                    CNORprob_Example = NULL,ProbCutNONC = T,
#                    ProbCompression = input$compression_CNORprob,
#                    ProbExpandOR = input$expansion_CNORprob,
#                    Analysis_edgeKO = F,Analysis_nodeKO = F,Analysis_LPSA = F,Analysis_BS = F)

# --- End of the script --- #
