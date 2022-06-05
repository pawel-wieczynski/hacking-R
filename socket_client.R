host <- 'localhost'
port <- 2137

while (TRUE) {
  con <- socketConnection(host = host, port = port, server = FALSE, blocking = TRUE)
  f <- file('stdin')
  open(f)
  cat('\nEnter the message: ')
  message <- readLines(f, 1)
  writeLines(message, con)
  response <- readLines(con, 1)
  cat(paste0('Received response: ', response))
}