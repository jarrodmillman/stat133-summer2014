# A "typical" exploratory data analysis workflow for microarray data (Take 2)

# This dataset was used in data analysis described in:
#
# Baggerly, Keith A., and Kevin R. Coombes.  "Deriving chemosensitivity from
# cell lines: Forensic bioinformatics and reproducible research in
# high-throughput biology." The Annals of Applied Statistics (2009): 1309-1334.
#
# In particular, this data file was obtained in:
#   http://bioinformatics.mdanderson.org/Supplements/ReproRsch-All/rDataObjects.zip
# For more information about this dataset as well as additional data and analysis
# scripts, please see 
#   http://bioinformatics.mdanderson.org/Supplements/ReproRsch-All/

load(url("http://www.jarrodmillman.com/stat133-summer2014/data/gse349.Rda"))

status=factor(gse349Info$status)   # why use factor?
raw.exprs = gse349                 # why not just use gse349 directly?
log.exprs = log(gse349)

# Filter out low intensity genes
cutoff = quantile(raw.exprs, probs=0.25)          # what prob should we use?
n.above.cutoff = rowSums(raw.exprs > cutoff)
row.below.cutoff = n.above.cutoff != 0
filtered.exprs = raw.exprs[row.below.cutoff, ]
log.filtered.exprs = log(filtered.exprs)

## Improved boxplot
boxplt = function(x) {
    cols=c("red","blue")
    boxplot(x,
            main="GSE349",
            xlab="Subject",
            ylab="Log-intensity of filtered genes",
            col=cols[status])
    legend("topleft", levels(status), fill=cols)
}

## exercise
# what if you want to change colors?
# or title?

boxplt(filtered.exprs)
boxplt(log.filtered.exprs)




########################
### Normalize and plot
########################

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

mdnorm.lfiltered.exprs = median.norm(log.filtered.exprs)
boxplt(mdnorm.lfiltered.exprs)
fqnorm.lfiltered.exprs = quantile.norm(log.filtered.exprs)
boxplt(fqnorm.lfiltered.exprs)
