source('graph_classification/computeDecay.R')
source('graph_classification/kernelFunction.R')

# data/full_adj is the folder with the full adjadency matrices.
# In case that folder changes, it needs to be changed throughout this file.


list.files('data/full_adj/')
tot_mon <- 19   ### Hardcoded - to be checked
tot_mosques <- 20   ## Hardcoded - to be checked

## Loading Monasteries
list_mon <- list()
for (j in c(1:tot_mon)){
  temp_mat <- read.table(file = paste0('data/full_adj/Monasteries_',
                                       as.character(j-1),'.txt'), sep='|')
  print(dim(temp_mat))
  list_mon[[j]] <- temp_mat
}
list_mon <- lapply(X= list_mon, FUN = as.matrix)

## Loading Mosques
list_mosques <- list()
for (j in c(1:tot_mosques)){
  temp_mat <- read.table(file = paste0('data/full_adj/Mosques_', as.character(j-1),'.txt'), sep='|')
  print(dim(temp_mat))
  list_mosques[[j]] <- temp_mat
}
list_mosques <- lapply(X= list_mosques, FUN = as.matrix)

## Getting labels and preparing full list of adjeciency matrices
labels_vec <- c(rep(1, tot_mon), rep(0, tot_mosques))
full_list <- append(list_mon, list_mosques)

print('Everything has been imported for classification')

## Calculate Gram Matrix
limit_kernel <- 99
gram_mat <- matrix(data=NA, nrow=length(full_list), ncol=length(full_list))
for (i in 1:length(full_list))
{
  for (j in i:length(full_list))
  {
    if (dim(full_list[[i]])[1] <= limit_kernel && dim(full_list[[j]])[1] <= limit_kernel){
      gram_mat[i,j] <-  kernelFunction(full_list[[i]], full_list[[j]])
    } else {
      gram_mat[i,j] <- -1
    }
    gram_mat[j,i] <- gram_mat[i,j]
    print(paste0(i, ',', j, ' Calculated'))
  }
}

## Save Gram Matrix
today_date <- format(Sys.Date(), format="%b-%d-%Y")
filename_out <-paste0('data/gram_mat_full_adj_', today_date, '.csv')
write.csv(x = gram_mat, file=filename_out)

## Save Labels in the same order as Gram Matrix column
filename_out <-paste0('data/y_vec_full_adj_', today_date, '.txt')
write.table(file = filename_out, x = labels_vec)
