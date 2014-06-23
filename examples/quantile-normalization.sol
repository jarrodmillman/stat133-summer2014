quantile.norm = function(x) {
    # x: p by n data matrix
    #    where columns are the samples and rows are observations

    x.sort = apply(x, 2, sort)    # sort within sample
    x.rank = apply(x, 2, rank)    # rank within sample
    reference = rowMeans(x.sort)
    norm = apply(x.rank, 2, function(smpl) reference[smpl])
    dimnames(norm) = dimnames(x)
    return(norm)
}

# exercise
#reference = apply(x.sort, 1, median)
#reference = apply(x.sort, 1, quantile, prob=0.75)

median.norm = function(x) {
    # x: p by n data matrix
    #    where columns are the samples and rows are observations

    medians = apply(x, 2, median)
    reference = mean(medians)
    d = reference - medians
    norm = sapply(1:14,  function(i) x[,i]+d[i])
    dimnames(norm) = dimnames(x)
    return(norm)
}

# exercise
#third.quartile = apply(x.sort, 2, quantile, prob=0.75)
