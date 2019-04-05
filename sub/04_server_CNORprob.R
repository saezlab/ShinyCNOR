# --- Output CNORprob --- # 

preprocessed_model_CNORprob <- NULL
res_CNORprob <- NULL

# --- PlotModel CNORprob --- #

output$PlotModel_CNORprob <- renderPlot({
  
  if (input$run_CNORprob) {
    
    # Assign optimisation and parameter settings
    optRound_optim    <- 3        # rounds of optimisation
    L1Reg             <- 1e-4     # assign weight for L1-regularisation
    MaxTime           <- 180      # time for each round of optimisation [seconds]
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
    Analyses          <- c(T,T,T,T) # [F,T] edge knockout, node knockout, sensitivity analysis
    optRound_analysis <- 1        # rounds of optmisation in each analysis
    LPSA_Increments   <- 2        # number of increments in LPSA analysis
    BS_Type           <- 1        # Type of Bootstrapping [1=resample with replacement from residual; 2=resampling from mean & variant]
    BS_Round          <- 5       # number of rounds for bootstrapping
    
    # Assign CNORprob-specitifc parameters for pre-processing step
    ProbCompression <- input$compression_CNORprob;
    ProbCutNONC <- T;
    ProbExpandOR <- input$expansion_CNORprob;
    ProbHardConstraint <- F;
    ProbForce <- F # Default (most-relaxed) setting
    
    # Run CNORprob-specific pre-processing (expansion=FALSE by default and report)
    ModDatppProb <- preprocessing_Prob(cno, SIF_model, expansion=FALSE,
                                       compression=ProbCompression, cutNONC=ProbCutNONC,
                                       verbose=FALSE)
    optmodel <- ModDatppProb$cutModel
    optCNOlist <- ModDatppProb$data
    
    estim_Result   <<- list() # Initialise global variable of results
    rsolnp_options  <- list(rho=rho,outer.iter=outer.iter,inner.iter=inner.iter,delta=delta,tol=tol,trace=trace) # Collapase optimisation options
    
    # Generate optimisation object
    estim <- CNORprob_buildModel(optCNOlist,optmodel,
                                 expandOR=ProbExpandOR,ORlist=NULL,
                                 HardConstraint=ProbHardConstraint,
                                 Force=ProbForce,
                                 L1Reg=L1Reg,HLbound=HLbound,SSthresh=SSthresh,
                                 PlotIterations=PlotIterations,rsolnp_options=rsolnp_options)
    
    # Run Optimisation
    estim$maxtime <- MaxTime; estim$printCost <- printCost
    estim$optimOptions <- c(rho,outer.iter,inner.iter,delta,tol,trace)
    res_CNORprob <<- CNORprob_optimise(estim,optRound_optim,SaveOptResults)
    
    # Plot model
    MappedProb <- CNORprob_mapModel(optmodel,optCNOlist,estim,res_CNORprob)
    plotModel(MappedProb$model,MappedProb$CNOlist,round(MappedProb$bString,digits=2))
    
  }
})

# --- PlotFot CNORprob --- #

output$PlotFit_CNORprob <- renderPlot({
  
  if (input$run_CNORprob) {

    # Assign optimisation and parameter settings
    optRound_optim    <- 3        # rounds of optimisation
    L1Reg             <- 1e-4     # assign weight for L1-regularisation
    MaxTime           <- 180      # time for each round of optimisation [seconds]
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
    Analyses          <- c(T,T,T,T) # [F,T] edge knockout, node knockout, sensitivity analysis
    optRound_analysis <- 1        # rounds of optmisation in each analysis
    LPSA_Increments   <- 2        # number of increments in LPSA analysis
    BS_Type           <- 1        # Type of Bootstrapping [1=resample with replacement from residual; 2=resampling from mean & variant]
    BS_Round          <- 5       # number of rounds for bootstrapping
    
    
    # Assign CNORprob-specitifc parameters for pre-processing step
    ProbCompression <- input$compression_CNORprob;
    ProbCutNONC <- T;
    ProbExpandOR <- input$expansion_CNORprob;
    ProbHardConstraint <- F;
    ProbForce <- F # Default (most-relaxed) setting
    
    
    # Run CNORprob-specific pre-processing (expansion=FALSE by default and report)
    ModDatppProb <- preprocessing_Prob(cno, SIF_model, expansion=FALSE,
                                       compression=ProbCompression, cutNONC=ProbCutNONC,
                                       verbose=FALSE)
    optmodel <- ModDatppProb$cutModel
    optCNOlist <- ModDatppProb$data
    
    estim_Result   <<- list() # Initialise global variable of results
    rsolnp_options  <- list(rho=rho,outer.iter=outer.iter,inner.iter=inner.iter,delta=delta,tol=tol,trace=trace) # Collapase optimisation options
    
    # Generate optimisation object
    estim <- CNORprob_buildModel(optCNOlist,optmodel,
                                 expandOR=ProbExpandOR,ORlist=NULL,
                                 HardConstraint=ProbHardConstraint,
                                 Force=ProbForce,
                                 L1Reg=L1Reg,HLbound=HLbound,SSthresh=SSthresh,
                                 PlotIterations=PlotIterations,rsolnp_options=rsolnp_options)
    
    # Run Optimisation
    estim$maxtime <- MaxTime; estim$printCost <- printCost
    estim$optimOptions <- c(rho,outer.iter,inner.iter,delta,tol,trace)
    res_CNORprob <<- CNORprob_optimise(estim,optRound_optim,SaveOptResults)
    
    # Plot fit
    CNORprob_plotFit(optmodel,optCNOlist,estim,res_CNORprob,show=TRUE, plotPDF=TRUE, tag=NULL, plotParams=list(cex=0.8, cmap_scale=1, ymin=0))
    
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
