host <- 'localhost'
port <- 2137

while (TRUE) {
  writeLines(paste0('\nSocket is listening to port ', port))
  con <- socketConnection(host = host, port = port, server = TRUE, blocking = TRUE)
  message <- readLines(con, 1)
  cat(paste0('Received message: ', message))
  writeLines('Thanks for the message.', con)
  close(con)
}