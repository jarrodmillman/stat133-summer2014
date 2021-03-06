median.norm = function(x) {
    # x: p by n data matrix
    #    where columns are the samples and rows are observations

    medians = apply(x, 2, median)
    reference = mean(medians)
    d = reference - medians
    norm = sapply(1:ncol(x),  function(i) x[,i]+d[i])
    dimnames(norm) = dimnames(x)
    return(norm)
}

### exercise
# change reference to use the .75 quantile for each row


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

### exercise
# change reference to use the median for each row
# change reference to use the .75 quantile for each row
