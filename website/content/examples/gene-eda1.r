# A "typical" exploratory data analysis workflow for microarray data
# 
# Before trying to go straight to performing some statistical analysis or
# machine learning procedure it is essential to first take a "look" at the
# data.  For example, examine the structure of the data, check whether there is
# anything odd about it, look for potential outliers, verify that it is
# distributed in a way that doesn't violate the assumptions your analysis
# procedures will require.


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

# First, look to see what objects we've loaded into our R environment
ls()

# Now take a look at what kind of datastructure these objects correspond to ...
class(gse349)
class(gse349Info)

# Look at the first part of the objects
head(gse349)
head(gse349Info)

# Look at the names of the objects
names(gse349)        # what happened here?
names(gse349Info)

str(gse349)
dimnames(gse349)
class(dimnames(gse349))
dimnames(gse349)[2]
dimnames(gse349)[[2]]

# Now look at some summary information of the data in the gse349 matrix
dim(gse349)
summary(gse349)
fivenum(gse349)
IQR(gse349)
apply(gse349, 2, IQR)
iqrs = apply(gse349, 2, IQR)
sd(apply(gse349, 2, IQR))

# Visual summaries
hist(gse34)
hist(gse349[,1])
hist(gse349[,2])
hist(gse349[,2])
hist(gse349[,2])
hist(gse349[,3])
boxplot(gse349)

# Since the histograms are right skewed, take a look at the log-transform of
# the distribution.
log.exprs = log(gse349)
hist(log.exprs)
hist(log.exprs[,1])

# Noting the peak near zero, it may make sense to filter out low values.
# This may not be justified.  So you must proceed with caution.
x = gse349[,1]
summary(x)
sum(x<7)
sum(x>7)
sum(x<7)/length(x)      # What is this computing?
hist(log(x[x>7]))

# Use apply to get summary statistics for each sample (i.e., column in
# this case)
apply(gse349, 2,  mean)
apply(gse349, 2,  median)
apply(gse349, 2,  quantile, probs=0.5)
apply(gse349, 2,  quantile, probs=0.75)

# Filter out low intensity genes
#
# In particular, remove any gene that has low intensity across all samples
# (i.e., remove all rows of the matrix for which every element is below
# a certain cutoff).
cutoff = quantile(gse349, probs=0.25)
n.above.cutoff = rowSums(gse349 > cutoff)
hist(n.above.cutoff)
row.below.cutoff = n.above.cutoff != 0
sum(row.below.cutoff)
filtered.exprs = gse349[row.below.cutoff, ]
log.filtered.exprs = log(filtered.exprs)

# How does the following histogram compare to hist(log.exprs)
hist(log.filtered.exprs)     

# How does the following histogram compare to hist(log.exprs[,1])
hist(log.filtered.exprs[,1])     

# Maybe we should choose a cutoff per sample
# In that case we would do something like the above, but using a vector of
# cutoffs
cutoff.vec = apply(gse349, 2,  quantile, probs=0.1)

# Look at the distribution of the log transform of the filtered data using
# boxplots instead of histograms
boxplot(log.filtered.exprs)

## Improved boxplot
# First, make a factor vector of the status of each sample
status=factor(gse349Info$status)
# Note that there isn't an even division between the sample types
table(status)
# Add additional information to the boxplots to make them more informative
cols = c("red","blue")
boxplot(log.filtered.exprs,
        main="GSE349",
        xlab="Subject",
        ylab="Log-intensity of filtered genes",
        col=cols[status])
legend("topleft", levels(status), fill=cols)
