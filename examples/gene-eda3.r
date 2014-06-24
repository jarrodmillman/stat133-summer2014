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

full = list()
train = list()
test = list()

full.log = log(subset(doxorubicin07Numbers, select=-Test95)+1)
indx.test = 1:22
train$log = full.log[, indx.test]
test$log = full.log[, -indx.test]

badrow = rownames(doxorubicin07Info) == "Test95"
status = doxorubicin07Info[!badrow, 'status']
train$status = status[indx.test]
test$status = status[-indx.test]

train$title = "Train"
test$title = "Test"
boxplot(train$log, main=train$title)
boxplot(test$log, main=test$title)

# normalize
source('quantile-normalization.r')
train$norm = quantile.norm(train$log)
test$norm = quantile.norm(test$log)

cols=c("red", "blue")
cols[train$status]

boxplot(train$norm, col=cols[train$status], main=train$title)
boxplot(test$norm, col=cols[train$status],main=test$title)

train$pca = prcomp(t(train$norm))
plot(train$pca$x[,1:2], col=cols[train$status], main=train$title)
plot(train$pca$x[,2:3], col=cols[train$status], main=train$title)


test$pca = prcomp(t(test$norm))
plot(test$pca$x[,2:3], col=cols[test$status], main=test$title)
plot(test$pca$x[,1:2], col=cols[test$status], main=test$title)

image(as.matrix(cor(train$norm)))
image(as.matrix(cor(test$norm)))

image(as.matrix(dist(t(train$norm))))
image(as.matrix(dist(t(test$norm))))
