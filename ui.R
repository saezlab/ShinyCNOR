# UI
source("sub/global.R")
ui = function(request) {
  fluidPage(
    useShinyjs(),
    tags$head(includeScript("google-analytics.js")),
    #shinyjs::addClass(id = "welcome", class = "navbar-right"),
    #theme = shinythemes::shinytheme("spacelab"),
    navbarPage(
      id = "menu", title="ShinyCNOR",collapsible=T,
      footer = column(12, align="center", "ShinyCNOR-App 2020 (version: 1.0)"),
      source("sub/01_ui_welcome.R")$value,
      source("sub/02_ui_upload.R")$value,
      source("sub/03_ui_CellNOptR.R")$value,
      source("sub/04_ui_CNORprob.R")$value,
      source("sub/05_ui_CNORode.R")$value,
      source("sub/ui_help.R")$value,
      source("sub/ui_contact.R")$value,
      hr()
      ) # close navbarPage
    ) # close fluidPage
}
