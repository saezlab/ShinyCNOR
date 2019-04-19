# SERVER
server = function(input, output, session) {
  
  source("sub/02_server_upload.R", local=T)
  source("sub/03_server_CellNOptR.R", local=T)
  source("sub/04_server_CNORprob.R", local=T)
  source("sub/05_server_CNORode.R", local=T)
  # source("sub/server_bookmark.R", local=T)
}
