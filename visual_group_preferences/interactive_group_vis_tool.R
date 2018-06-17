## This code creates an interactive graphic of the preferences reported by 
# students for group assignment. 

# Also provides information in connected components in friends graphic

# In Data Entry, you will find format for the needed files, which should be
# named:
# - `all_names_interactive.csv` <- a n x 1 data frame with names of students 
#     and ids. Format: Benjamin LeRoy (bpleroy)
# - `google_form.csv` <- a m x 8 data frame with survey responses.
#     See format below, can easily manipulate the names. Also note name format 
#     expected to be the same as in `all_names_interactive.csv`.

library(tidyverse)
library(ggraph)
library(igraph)
library(visNetwork)

########################
# Data Entry / Reading #
########################

# for best practice I recommend a google form with
# 1. Their name provided for them 
# (need to mention that you need to track their student ids,
# mention in header than you are - so they can't fill it out for other students)
# - note I didn't write code the check this

# 2. 3 other drop down menus with class mates 
# 3. Final dropdowns for non-friend.

names_data <- read.csv("all_names_interactive.csv")
# assumed:
# Name
# -----
# Benjamin LeRoy (bpleroy)
# ...
# ...
data_google <- read.csv("google_form.csv")

# assumed:
# Timestamp      | Name                     | Friend1                   | Friend2 | Friend3 | NotFriend1 | NotFriend2 | NotFriend3
# --------------------------------------------------------------------------------------------------------------------------------
# 01/01/18 12:01 | Benjamin LeRoy (bpleroy) | Jacqueline Liu (jacquel2) | ...
# ...

# -------------
# NOTE: make sure columns names are correct (NAs can fill all columns but Name and Timestamp at the end)
# if not, but correct format, try: 

# names(names_data) <- "Name"
# names(data_google) <- c("Timestamp", "Name", paste0("Friend",1:3),
#                         paste0(NotFriend,1:3) )
# -------------


#######################
# Basic Data Cleaning #
#######################

# cleaning (removing the "(bpleroy)" tags):

data_google <- data_google %>% mutate(
  Name = sapply(as.character(data_google$Name), function(x) strsplit(x," \\(")[[1]][1]),
  Friend1 = sapply(as.character(data_google$Friend1), function(x) strsplit(x," \\(")[[1]][1]),
  Friend2 = sapply(as.character(data_google$Friend2), function(x) strsplit(x," \\(")[[1]][1]),
  Friend3 = sapply(as.character(data_google$Friend3), function(x) strsplit(x," \\(")[[1]][1]),
  NotFriend1 = sapply(as.character(data_google$NotFriend1), function(x) strsplit(x," \\(")[[1]][1]),
  NotFriend2 = sapply(as.character(data_google$NotFriend2), function(x) strsplit(x," \\(")[[1]][1]),
  NotFriend3 = sapply(as.character(data_google$NotFriend3), function(x) strsplit(x," \\(")[[1]][1])
  )

# removing duplicates (taking final submission)

duplicates_names = names(table(data_google$Name))[table(data_google$Name) > 1]

for (dname in duplicate_names) {
  idx <- which(data_google$Name == dname)
  remove_idx <- idx[max(idx)]
  data_google <- data_google[-remove_idx]
}

#################
# Basic Merging #
#################


data <- names_data %>% left_join(data_google, by = c("Name" = "Name"))


##################
# Making Network #
##################
# makes full network and "friends only" network

edges_mat <- c()

for (i in 1:nrow(data)) {
  for (friend in data[i,paste0("Friend",1:3)]) {
    if (is.na(friend)) {next}
    edges_mat  <- rbind(edges_mat,
                        c(as.character(data$Name[i]),as.character(friend)) )
  }
}
friend_length <- nrow(edges_mat)
edge_friends <- edges_mat

for (i in 1:nrow(data)) {
  for (nofriend in data[i,paste0("NotFriend",1:3)]) {
    if (is.na(nofriend)) {next}
    edges_mat  <- rbind(edges_mat,
                        c(as.character(data$Name[i]),as.character(nofriend)) )
  }
}

nofriend_length = nrow(edges_mat) - friend_length

###############
###############
# Network Vis #
###############
###############


##################################
# Friends and Not Friend Network #
##################################

# naturally friends edges are colored differently

gr <- graph_from_edgelist(el = edges_mat, directed = TRUE) %>%
  set_edge_attr("color", value = c(rep(1, friend_length),rep(-1,nofriend_length))) %>%
  set_edge_attr("color", value = c(rep('blue', friend_length),rep('red',nofriend_length)))




nodes2 <- as_data_frame(gr, what = "vertices") 

data_names_only <- data$Name

extra_nodes <- data.frame(name = unique(c(data_names_only,nodes2$name )))
rownames(extra_nodes) <- extra_nodes$name


nodes2 <- extra_nodes

nodes2 <- nodes2 %>% mutate(id = name,
                            title = name,
                            shape = "dot",
                            size = 10,
                            color = "black") %>% 
  select(id,title,shape,size,color)
edges2 <- as_data_frame(gr, what = "edges") %>%
  mutate(arrows = "to")

visNetwork(nodes2, edges2,main = "Friends and Not Friends") %>%
  visOptions(highlightNearest = TRUE,nodesIdSelection = TRUE
  ) 

########################
# Friends Only Network #
########################
# this file also prints out connected components in the friends only network

gr_friends <- graph_from_edgelist(edge_friends, directed = TRUE) %>%
  set_edge_attr("color", value = rep('blue', friend_length))

nodes3 <- as_data_frame(gr_friends, what = "vertices") 
nodes3 <- nodes3 %>% mutate(id = name,
                            title = name,
                            shape = "dot",
                            size = 10,
                            color = "black") %>% 
  select(id,title,shape,size,color)
edges3 <- as_data_frame(gr_friends, what = "edges") %>%
  mutate(arrows = "to")

visNetwork(nodes3, edges3,main = "Friends only") %>%
  visOptions(highlightNearest = TRUE,nodesIdSelection = TRUE)

# connected components (prints membership - is only based on friends graphics)
cc <- components(gr_friends)

print(cc$membership %>% sort)
