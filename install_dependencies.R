# ---- Install Libraries ---- # 
# install the dependencies listed in global.R. 

cran_packages <- c("shiny","shinyWidgets","tidyverse","DT","shinyjs","Rsolnp")
new.packages <- cran_packages[!(cran_packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

bioconductor_packages <- c("CellNOptR","CNORode")
new.packages <- bioconductor_packages[!(bioconductor_packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) BiocManager::install(new.packages)


if(!"CNORprob" %in% installed.packages()[,"Package"]) remotes::install_github("saezlab/CNORprob")
