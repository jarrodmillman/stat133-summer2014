load(url("http://www.jarrodmillman.com/stat133-summer2014/data/gse349.Rda"))
ls()

class(gse349)
class(gse349Info)

head(gse349)
head(gse349Info)

names(gse349) # what's wrong with this?
names(gse349Info)

str(gse349)
dimnames(gse349)
class(dimnames(gse349))
dimnames(gse349)[2]
dimnames(gse349)[[2]]


dim(gse349)
summary(gse349)
fivenum(gse349)

hist(gse34)
hist(gse349[,1])
hist(gse349[,2])
hist(gse349[,2])
hist(gse349[,2])
hist(gse349[,3])
boxplot(gse349)

log.exprs = log(gse349)
hist(log.exprs)
hist(log.exprs[,1])

x = gse349[,1]
summary(x)
sum(x<7)
sum(x>7)
sum(x<7)/length(x)
hist(log(x[x>7]))

apply(dse349, 2,  mean)
apply(gse349, 2,  median)
apply(gse349, 2,  quantile, probs=0.5)
apply(gse349, 2,  quantile, probs=0.75)

cutoff = apply(gse349, 2,  quantile, probs=0.1)


status=factor(gse349Info$status)
table(status)

cols = c("red","blue")
boxplot(gse349, col=cols[status])
legend("topleft", levels(status), fill=cols)
