quantile.norm = function(x) {
    # x: p by n data matrix
    #    where columns are the samples and rows are observations

    norm = x
    x.sort = apply(x, 2, sort)    # sort within sample
    x.rank = apply(x, 2, rank)    # rank within sample
    reference = rowMeans(x.sort)
    norm = apply(x.rank, 2, function(smpl) reference[smpl])
    return(norm)
}
