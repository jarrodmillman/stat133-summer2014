# create a matrix
x = cbind(c(3,5,4,3,2), c(7,4,5,3,6), c(2,8,5,5,4))
dim(x)
p = nrow(x)
n = ncol(x)
x

# look at distribution
boxplot(x)

#################################
###  Median normalization
#################################

medians = apply(x, 2, median)
reference = mean(medians)
d = reference - medians
x.median.norm = sapply(1:n,  function(i) x[,i]+d[i])

#################################
###  Full quantile normalization
#################################

# sort columns
sort(x[,1])
sort(x[,2])
sort(x[,3])
x.sort = cbind(sort(x[,1]), sort(x[,2]), sort(x[,3]))
# can you use apply to do this?
#x.sort = apply(x, 2, sort)

# get means
means = rowMeans(x.sort)    # what about medians?

# substitute original values with means
x.rank = apply(x, 2, rank)  # what about ties?
x.full.norm = apply(x.rank, 2, function(y) means[y])
