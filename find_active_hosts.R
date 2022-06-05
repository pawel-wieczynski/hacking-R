# In this script we ping all hosts (1-255) in a given network.
# Output is a list of active hosts in a given network.
# To speed up the process we use multiple CPU cores with doParallel library.

library(doParallel)
library(stringr)

my_network <- '192.168.1.'

my_cluster <- makeCluster(detectCores() - 1, type = 'PSOCK')
registerDoParallel(cl = my_cluster)

replies <- foreach(i = 1:255, .combine = 'c') %dopar% {
  ping <- paste0('ping ', my_network, i, ' -n 1')
  system(ping, intern = TRUE)[3]
}

stopCluster(cl = my_cluster)

active_hosts <- replies[!str_detect(replies, 'Destination host unreachable|Request timed out')]
active_hosts <- str_extract(active_hosts, '[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+')

print(active_hosts)
