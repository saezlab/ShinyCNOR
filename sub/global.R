# --- Load libraries --- #
library(shiny)
# library(shinyWidgets)
library(tidyverse)
# library(viper)
library(ggrepel)
library(DT)
#library(furrr)
library(pheatmap)
library(shinyjs)
#library(ggExtra)
library(tidygraph)
library(ggraph)
library(broom)
library(CellNOptR)
library(CNORprob)
library(Rsolnp) 
library(R.utils) 
library(CNORode)

# --- shiny options --- #
enableBookmarking(store = "server")
options(shiny.maxRequestSize=30*1024^2)

# --- load example data ---  # 
SIF_toy = readSIF("data/examples/ToyPKNMMB.sif") 
MIDAS_toy = CNOlist("data/examples/ToyDataMMB.csv") 

# --- functions --- #
DFtoMIDAS <- function(DF=NULL) {
  
  if(is.null(DF)) {stop("Please provide the data frame file to be converted into MIDAS format")}
  
  # Clean working environment
  options(stringsAsFactors = F)
  
  ReadData <- read.csv(file = DF)
  CueList <- sort(unique(ReadData[,'Cues']))
  CueNames <- list(); CueAll <- NULL
  for (counter in 1:length(CueList)) {
    CueNames[[counter]] <- strsplit(x = CueList[counter],split = "+",fixed = T)
    CueAll <- sort(unique(c(CueAll,CueNames[[counter]][[1]])))
  }
  TimeList <- sort(unique(ReadData[,'Time']))
  MeasList <- sort(colnames(ReadData[,3:ncol(ReadData)]))
  
  # MIDASmat <- data.frame(matrix(data = NA,nrow = nrow(ReadData),ncol = 1+length(CueAll)+(2*length(MeasList))))
  MIDASmat <- data.frame(matrix(data = NA,nrow = length(CueList)*length(TimeList),ncol = 1+length(CueAll)+(2*length(MeasList))))
  IdxCL <- 1; IdxCue <- 2:(length(CueAll)+1); IdxDA <- (length(CueAll)+2):(length(CueAll)+1+length(MeasList)); IdxDV <- (length(CueAll)+2+length(MeasList)):(length(CueAll)+1+2*length(MeasList))
  colnames(MIDASmat)[1] <- "TR:mock:CellLine"
  colnames(MIDASmat)[IdxCue] <- paste0("TR:",CueAll)
  colnames(MIDASmat)[IdxDA] <- paste0("DA:",MeasList)
  colnames(MIDASmat)[IdxDV] <- paste0("DV:",MeasList)
  
  # Preset matrix 
  MIDASmat[,1] <- 1
  MIDASmat[,2:(length(CueAll)+1)] <- 0
  MIDASmat[,IdxDA] <- rep(TimeList,length(CueList)) 
  for (counter in 1:length(CueList)) {
    CurrentCueNames <-strsplit(x = CueList[counter],split = "+",fixed = T)[[1]]
    MIDASmat[(((counter-1)*length(TimeList))+1):(counter*length(TimeList)),paste0("TR:",CurrentCueNames)] <- 1
  }
  
  # Start mapping
  for (counter in 1:nrow(ReadData)) {
    CueIdx <- which(ReadData$Cues[counter]==CueList)
    # CurrentCueNames <-strsplit(x = ReadData$Cues[counter],split = "+",fixed = T)[[1]]
    # CueIdx <- which(CurrentCueNames==CueAll)
    TimeIdx <- which(ReadData$Time[counter]==TimeList)
    # RowIdx <- intersect((((CueIdx-1)*length(TimeList))+1):(CueIdx*length(TimeList)),CueIdx*length(TimeList)+TimeIdx)
    RowIdx <- (CueIdx-1)*length(TimeList)+TimeIdx
    # MIDASmat[counter,paste0("TR:",CurrentCueNames)] <- 1
    # MIDASmat[counter,IdxDA] <- ReadData$Time[counter]
    # MIDASmat[counter,IdxDV] <- ReadData[counter,3:ncol(ReadData)]
    MIDASmat[RowIdx,IdxDA] <- ReadData$Time[counter]
    MIDASmat[RowIdx,IdxDV] <- ReadData[counter,3:ncol(ReadData)]
  }
  
  if (grepl(pattern = ".",x = DF,fixed = T)) {
    FinalFileName <- strsplit(x = DF,split = ".",fixed = T)[[1]][1]
  } else {
    FinalFileName <- DF
  }
  
  write.csv(MIDASmat,paste0(FinalFileName,"_MIDAS.csv"),row.names = F,quote = F)
  
  print(paste0("The MIDAS file was written and saved as '",paste0(FinalFileName,"_MIDAS.csv'")))
  
  # return(MIDASmat)
}


row <- function(...) {
  tags$div(class="row", ...)
}

col <- function(width, ...) {
  tags$div(class=paste0("span", width), ...)
}

# --- End of the script --- #
