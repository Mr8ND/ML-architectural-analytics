### CODE TAKEN FROM
### https://www.csc2.ncsu.edu/faculty/nfsamato/practical-graph-mining-with-R/PracticalGraphMiningWithR.html

library(igraph)

computeDecay <-
function(m) {


   # In order to take advantage of igraph's capabilities, we
   # will convert the DPG adjacency matrix to an "igraph" class

   mgraph <- graph.adjacency(m, mode=c("directed"), weighted=NULL)


   # We compute the indegree and outdegree of each node in
   # the DPG using the igraph's degree() function.

   # This assigns a vector, where each element is anode's indegree,
   # to the 'inDegree' variable. Likewise for 'outDegree'.

   inDegree <- degree(mgraph,mode=c("in"))
   outDegree <- degree(mgraph,mode=c("out"))

   # As per the algorithm, we need the global maximum indegree
   # and outdegree for the graph. max() returns the maximum value
   # in a vector (a scalar).

   maxIndegree <- max(inDegree)
   maxOutdegree <- max(outDegree)

   # Compute the decay value - one over the minimum
   # between indegree and outdegree. The decay constant
   # must be less than this.

   decay <- 1 / min(maxIndegree, maxOutdegree)

   # Make sure that the decay constant is less than one.
   # Otherwise, there would be no decay! (and our series
   # would not converge)

   if (decay == 1)
   {
      decay = 0.9;
   }

   return(decay)

}

