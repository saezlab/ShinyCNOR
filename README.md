## Welcome to the Shiny application for the CellNOpt packages
CellNOpt (from CellNetOptimizer; a.k.a. CNO) is a software used for creating logic-based models of signal transduction networks using different logic formalisms (Boolean, probabilistic logic, or differential equations). CellNOpt uses information on signaling pathways encoded as a Prior Knowledge Network, and trains it against high-throughput biochemical data to create cell-specific models.

### Implemented Approaches
ShinyCNOR is still under development, and the following approaches are implemented or in the process of being implemented.

#### CellNOptR
<a href="https://github.com/saezlab/CellNOptR/" target="_blank">CellNOptR</a> for Boolean formalism. It contains the core functions as well as the boolean and steady states version. It implements the workflow described in Saez-Rodriguez et al Mol Sys Bio 2009, with extended capabilities for multiple time points.

#### CNORprob
<a href="https://github.com/saezlab/CNORprob/" target="_blank">CNORprob</a> for Probablistic Logic formalism. It is a probabilistic logic variant of CellNOpt which allows for quantitative optimisation of logical network for (quasi-)steady-state data. The core optimisation pipeline is derived from FALCON: a toolbox for the fast contextualization of logical networks.

#### CNORode
<a href="https://github.com/saezlab/CNORode/" target="_blank">CNORode</a> for logic-based ODE formalism. It is an ODE add-on to CellNOptR. It is based on the method of (Wittmann et al BMC Sys Bio 2009), also implemented in the tool Odefy (Krusiek et al BMC Bioinf 2010).
