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
test.all = list()

train$title = "Training"
test$title = "Test (w/out Test95)"
test.all$title = "Test"
training = data$info$sampleGroup == "Training"
cols=c("red", "blue")

train$log = data$log[, data$info$sampleGroup == "Training"]
test.all$log = data$log[, data$info$sampleGroup == "Test"]
good = names(test.all$log) != suspect
test$log = test.all$log[, good]

train$status = data$info[training, "status"]
test.all$status = data$info[!training, "status"]
test$status = test.all$status[good]

# normalize
source('quantile-normalization.r')
train$norm = quantile.norm(train$log)
test$norm = quantile.norm(test$log)
test.all$norm = quantile.norm(test.all$log)

boxplot(train$norm, col=cols[train$status], main=train$title)
boxplot(test$norm, col=cols[test$status], main=test$title)
boxplot(test.all$norm, col=cols[test.all$status], main=test.all$title)

## PCA
pca.plot <- function(d, type="norm") {
    pca = prcomp(t(d[[type]]))
    plot(pca, main=d$title)
    plot(pca$x[,1:2], col=cols[d$status], main=d$title)
    legend("topright", c("Sensitive", "Resistant"), fill=cols)
    plot(pca$x[,2:3], col=cols[d$status], main=d$title)
    legend("topright", c("Sensitive", "Resistant"), fill=cols)
}

pca.plot(train)
pca.plot(test.all)
pca.plot(test)

## Correlation
cor.plot = function(d, threshold=FALSE) {
    if (threshold) {
        img = as.matrix(cor(d$norm) > 0.9999)
    } else {
        img = as.matrix(cor(d$norm))
    }
    cols = grey(seq(0,1,length=256))
    image(img, col=cols)
}

cor.plot(train)
cor.plot(test)

cor.plot(train, threshold=TRUE)
cor.plot(test, threshold=TRUE)


image(as.matrix(dist(t(train$norm))))
image(as.matrix(dist(t(test$norm))))
