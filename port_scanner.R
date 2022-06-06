# In this script we are looking for TCP open ports in a given network.
# Output is a vector of open ports in a given network.
# To speed up the process we use multiple CPU cores with doParallel library.
# However, it's only for educational purposes. 
# The same goal can be achieved in few seconds with nmap. 
# Moreover nmap yields more details regarding open ports.

library(doParallel)

host <- '192.168.1.110'

my_cluster <- makeCluster(detectCores() - 1, type = 'PSOCK')
registerDoParallel(my_cluster)

open_ports <- foreach(port = 1:1000, .combine = 'c') %dopar% {
  con <- try(suppressWarnings(socketConnection(host = host, port = port, timeout = 1)), silent = TRUE)
  if (!('try-error' %in% class(con))) {port}
}

stopCluster(my_cluster)