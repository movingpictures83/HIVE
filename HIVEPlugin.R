library(bipartite)
library(HiveR)

set.seed(31)

input <- function(inputfile) {
  mydata <<- read.csv(inputfile, row.names=1, header=TRUE);
}

run <- function() {
   hive1 <- adj2HPD(as.matrix(mydata), desc = "Safariland data set from bipartite")
   sumHPD(hive1)
   hive2 <- mineHPD(hive1, option = "rad <- tot.edge.count")
   sumHPD(hive2)
   hive3 <- mineHPD(hive2, option = "axis <- source.man.sink")
   sumHPD(hive3, chk.all = TRUE)
   hive3$edges$weight <- sqrt(hive3$edges$weight)*0.5
   hive3$nodes$size <- 0.5
   plotHive(hive3)
   outputdata <<- hive3$nodes
}

output <- function(outputfile) {
   write.csv(outputdata, outputfile)
   #system(paste("mv Rplots.pdf ", outputfile, sep=""))
}

