load(url("http://www.jarrodmillman.com/stat133-summer2014/data/doxorubicin07.rda"))
class(doxorubicin07Numbers)
barplot(colMeans(doxorubicin07Numbers))
barplot(colMeans(doxorubicin07Numbers[,100:130]), las=2)

summary(doxorubicin07Numbers$Test94)
summary(doxorubicin07Numbers$Test95)

#summary(doxorubicin07Numbers[-"Test95"])
max(subset(doxorubicin07Numbers, select=-Test95))
max(subset(doxorubicin07Numbers, select=Test95))

boxplot(doxorubicin07Numbers[,100:130])

head(doxorubicin07Info)
class(doxorubicin07Info$sampleGroup)
levels(doxorubicin07Info$sampleGroup)

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
