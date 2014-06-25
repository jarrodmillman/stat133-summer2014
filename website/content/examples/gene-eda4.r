load(url("http://www.jarrodmillman.com/stat133-summer2014/data/doxorubicin07.rda"))

data = list()
data$raw = doxorubicin07Numbers
data$info = doxorubicin07Info
data$log = log(data$raw + 1)

## Sample "Test95" is suspicious
# boxplot(data$raw[,100:130])
suspect = "Test95"

train = list()
test = list()

train$title = "Training"
test$title = "Test"
training = data$info$sampleGroup == "Training"
cols=c("red", "blue")

train$log = data$log[, data$info$sampleGroup == "Training"]
test$all.log = data$log[, data$info$sampleGroup == "Test"]
good = names(test$all.log) != suspect
test$log = test$all.log[, good]

train$status = data$info[training, "status"]
test$all.status = data$info[!training, "status"]
test$status = test$all.status[good]

# normalize
source('quantile-normalization.r')
train$norm = quantile.norm(train$log)
test$norm = quantile.norm(test$log)

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
