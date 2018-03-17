# Veriried R 3.3.3


# set working directory
setwd("~/Dropbox/NorthWestern/Predict 455 - Winter 2018/Predict455FinalProject/indata")

      
# install needed packages if they aren't already 
install.packages("igraph")
install.packages("network")
install.packages("intergraph")

# bring in packages we rely upon for work in network analytics
library(igraph)  # network/graph methods
library(network)  # network representations
library(intergraph)  # for exchanges between igraph and network

# ----------------------------------------------------------------------------------
# Read in Bitcoin OTC trust weighted signed network
# ----------------------------------------------------------------------------------
### https://snap.stanford.edu/data/soc-sign-bitcoinotc.html
### This is who-trusts-whom network of people who trade using Bitcoin on a 
### platform called Bitcoin OTC. Since Bitcoin users are anonymous, there is a need 
### to maintain a record of users' reputation to prevent transactions with fraudulent 
### and risky users. Members of Bitcoin OTC rate other members in a scale of -10 
### (total distrust) to +10 (total trust) in steps of 1. This is the first explicit 
### weighted signed directed network available for research.

all_bitcoin_links <- read.csv("soc-sign-bitcoinotc.csv.gz",header=FALSE)

# check the structure of the input data data frame
View(all_bitcoin_links)
str(all_bitcoin_links)

#------------------------------------------------------------------------
# Notes on the variables
# Each line has one rating, sorted by time, with the following format:
# V1 = SOURCE: node id of source, i.e., rater
# V2 = TARGET: node id of target, i.e., ratee
# V3 = RATING: the source's rating for the target, ranging from -10 to +10 in steps of 1
# V4 = TIME: the time of the rating, measured as seconds since Epoch.
#------------------------------------------------------------------------

# Change the variable names to more intuitive labels
colnames(all_bitcoin_links) <- c("SOURCE","TARGET","RATING","TIME")

# Convert TIME from seconds since epoch to datetime to strftime
all_bitcoin_links$TIME <- as.POSIXct(all_bitcoin_links$TIME, origin = "1970-01-01")

# consider non-zero nodes only
non_zero_bitcoin_links <- subset(all_bitcoin_links, subset = (SOURCE != 0))
non_zero_bitcoin_links <- subset(non_zero_bitcoin_links, subset = (TARGET != 0))
View(non_zero_bitcoin_links)

# Create network object from the links
# Multiple = TRUE allows for multiplex links/edges
# Because it is possible to have two or more links
# Between the same two nodes (multiple ratings between the same two people)
# First create a separate Source + Target dataset and convert to a network object
bitcoin_SourceTarget_links <- subset(all_bitcoin_links, select = c("SOURCE", "TARGET", "RATING"))
View(bitcoin_SourceTarget_links)
bitcoin_SourceTaget_net <- network(as.matrix(bitcoin_SourceTarget_links),matrix.type = "edgelist", directed = TRUE, multiple = TRUE)


# create graph objects with intergraph function asIgraph()
bitcoin_SourceTarget_graph <- asIgraph(bitcoin_SourceTaget_net)
bitcoin_graph <- asIgraph

# set up node reference table/data frame for later subgraph selection
SourceTarget_node_index <- as.numeric(V(bitcoin_SourceTarget_graph))
V(bitcoin_SourceTarget_graph)$name <- SourceTarget_node_name <- as.character(V(bitcoin_SourceTarget_graph))
SourceTarget_node_name <- as.character(SourceTarget_node_index)
SourceTarget_node_reference_table <- data.frame(SourceTarget_node_index, SourceTarget_node_name)

# examine the degree of each node in the complete Source Target network
# and add this measure (degree centrality) to the node reference table
SourceTarget_node_reference_table$node_degree <- degree(bitcoin_SourceTarget_graph)
print(str(SourceTarget_node_reference_table))
View(SourceTarget_node_reference_table)

# sort the node reference table by degree and identify the indices
# of the most active nodes (those with the most links)
sorted_SourceTarget_node_reference_table <- 
  SourceTarget_node_reference_table[sort.list(SourceTarget_node_reference_table$node_degree, 
                                 decreasing = TRUE),]
# check on the sort
print(head(sorted_SourceTarget_node_reference_table))
print(tail(sorted_SourceTarget_node_reference_table))

# consider the subgraph of all people that node "35"
# trust rating given or received
node35 <- induced.subgraph(bitcoin_SourceTarget_graph,neighborhood(bitcoin_SourceTarget_graph, order = 1, nodes = 35)[[1]])

# plot the network subgraph for node35 which has the highest node degree
plot(node35, vertex.size = 15, 
     vertex.color = "blue", 
     vertex.label.color = "white",
     vertex.label.cex = 0.9, edge.arrow.size = 0.25, 
     edge.color = "darkgray", layout = layout.circle)
                                        #layout.kamada.kawai
                                        #layout.circle
                                        #layout.fruchterman.reingold
                                        #layout.reingold.tolford
#the node degrees are so high and dense that any graph layout is a bunch of cobwebs

# select the top K executives... set K 
K <- 25

# identify a subset of K in the Bitcoin OCT network based on rating activity 
top_SourceTarget_node_indices <- sorted_SourceTarget_node_reference_table$SourceTarget_node_index[1:K]
print(top_SourceTarget_node_indices)

# construct the subgraph of the top K in the Bitcoin OCT network
top_SourceTarget_graph <- induced.subgraph(bitcoin_SourceTarget_graph, top_SourceTarget_node_indices)

# Examine network graphs among the most active in the Bitcoin OCT network
set.seed(9999)
plot(top_SourceTarget_graph, vertex.size = 15, 
     vertex.color = "dark gray", 
     vertex.label.color = "black",
     vertex.label.cex = 0.9, edge.arrow.size = 0.15, 
     edge.color = "gray", layout = layout.circle, 
     main = "Circle layout layout")

set.seed(9999)
plot(top_SourceTarget_graph, vertex.size = 15, 
     vertex.color = "dark gray", 
     vertex.label.color = "black",
     vertex.label.cex = 0.9, edge.arrow.size = 0.15, 
     edge.color = "gray", layout = layout.kamada.kawai, 
     main = "Kamada Kawai layout")

set.seed(9999)
plot(top_SourceTarget_graph, vertex.size = 15, 
     vertex.color = "dark gray", 
     vertex.label.color = "black",
     vertex.label.cex = 0.9, edge.arrow.size = 0.15, 
     edge.color = "gray", layout = layout.fruchterman.reingold,
     main = "Fruchterman Reingold layout")

set.seed(9999)
plot(top_SourceTarget_graph, vertex.size = 15, 
     vertex.color = "dark gray", 
     vertex.label.color = "black",
     vertex.label.cex = 0.9, edge.arrow.size = 0.15, 
     edge.color = "gray", layout = layout.reingold.tilford,
     main = "Reingold Tilford layout")

set.seed(9999)
plot(top_SourceTarget_graph, vertex.size = 15, 
     vertex.color = "dark gray", 
     vertex.label.color = "black",
     vertex.label.cex = 0.9, edge.arrow.size = 0.15, 
     edge.color = "gray", layout = layout.random,
     main = "Random layout")

#explore communities and groups in top Bitcoin nodes
install.packages("linkcomm")
cluster_walktrap(top_SourceTarget_graph, weights = E(top_SourceTarget_graph)$weight, steps = 5,
                 merges = TRUE, modularity = TRUE, membership = TRUE)

