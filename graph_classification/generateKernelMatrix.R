### CODE TAKEN FROM
### https://www.csc2.ncsu.edu/faculty/nfsamato/practical-graph-mining-with-R/PracticalGraphMiningWithR.html

generateKernelMatrix <-
  function(M1, M2)
  {
    
    # Number of graphs we will be comparing
    numGraphs1 <- length(M1)
    numGraphs2 <- length(M2)
    
    # Generate an empty matrix for each kernel value
    K <- matrix(data=NA, nrow=numGraphs1, ncol=numGraphs2)
    
    # If both lists are the same, then we can generate a square
    # symmetric matrix and reduce computations by 50%.
    if (identical(M1, M2))
    {
      
      # Fill the kernel matrix with the kernel values
      for (i in 1:numGraphs1)
      {
        for (j in i:numGraphs1)
        {
          
          # Calculate the kernel value for these two graphs
          kValue = kernelFunction(M1[[i]], M1[[j]])
          
          # Since the kernel matrix is symmetric, we can compute
          # the kernel value only once.
          K[i, j] = kValue
          K[j, i] = kValue
          print(paste0(i, ',', j, ' DONE'))
        }
        print(paste0(i, ' DONE'))
      }
    }
    # Otherwise, we must calculate each kernel value
    else
    {
      for (i in 1:numGraphs1)
      {
        for (j in 1:numGraphs2)
        {
          
          # Calculate the kernel value for these two graphs
          kValue = kernelFunction(M1[[i]], M2[[j]])
          
          K[i, j] = kValue
          
        }
      }
    }
    
    #return(as.kernelMatrix(K))
    return(K)
    
  }
