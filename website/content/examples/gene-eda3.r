load("../data/doxorubicin07.rda")
class(doxorubicin07Numbers)
barplot(colMeans(doxorubicin07Numbers))
barplot(colMeans(doxorubicin07Numbers[,100:130]), las=2)

summary(doxorubicin07Numbers$Test94)
summary(doxorubicin07Numbers$Test95)

#summary(doxorubicin07Numbers[-"Test95"])
max(subset(doxorubicin07Numbers, select=-Test95))
max(subset(doxorubicin07Numbers, select=Test95))

boxplot(doxorubicin07Numbers[,100:130])

full = log(subset(doxorubicin07Numbers, select=-Test95)+1)
indx.test = 1:22
train = full[, indx.test]
test = full[, -indx.test]

badrow = rownames(doxorubicin07Info) == "Test95"
status = doxorubicin07Info[!badrow, 'status']
train.status = status[indx.test]
test.status = status[-indx.test]

boxplot(test)
boxplot(train)

# normalize
source('quantile-normalization.r')
ntrain = quantile.norm(train)
ntest = quantile.norm(test)

boxplot(ntrain)
boxplot(ntest)

pca = prcomp(t(ntrain))
cols=c("red", "blue")
cols[train.status]
plot(pca$x[,1:2], col=cols[train.status])
plot(pca$x[,2:3], col=cols[train.status])


pca = prcomp(t(ntest))
plot(pca$x[,1:2], col=cols[test.status])
plot(pca$x[,2:3], col=cols[test.status])

