### CODE TAKEN FROM
### https://www.csc2.ncsu.edu/faculty/nfsamato/practical-graph-mining-with-R/PracticalGraphMiningWithR.html

kernelFunction <-
function(g1,g2) {

  # The first step is to compute the direct product graph between
  # g1 and g2. This can be computed by taking the kronecker
  # matrix between two adjacency matrices. This returns the
  # adjacency matrix representation of the direct
  # product graph (DPG).

  directProductMatrix <- kronecker(g1, g2)

  # Note that the decay value must be greater than or
  # equal to the value computed in step 7 of Algorithm 2.
  # In this implementation, we are choosing the "equal to"
  # value for 'a'.

  decay = computeDecay(directProductMatrix)

  # Now we use the closed-form expression to take the geometric
  # series of the matrix.

  # The formula for this is roughly: (I - aE)^(-1) where:
  #   I is an identity matrix
  #   a is the decay constant
  #   E is the direct product graph
  #   the notation "^(-1)" means "take the inverse"

  # Thus, in R:

  # Create identity matrix
  #
  # dim() returns a vector with the number of rows and
  # columns respectively.

  matrixDimensions = dim(directProductMatrix)
  I = diag(nrow=matrixDimensions[1], ncol=matrixDimensions[2])

  # solve() takes the inverse of a matrix
  result <- 0
  tryCatch(expr = {
    geometricMatrix <- solve(I - (decay * directProductMatrix))
    result <- sum(geometricMatrix)
  },
  error = function(e) return(0)
  )
  
  # Finally, we sum the values of each element in our
  # geometric series of matricies.
  return(result)
}

