# Get the data
load('mydoxorubicin07.rda')
ls()
class(train)
class(test.all)
class(test)

# Check what named elements the vars have
names(train)
names(test.all)
names(test)

# K-nearest neighbor
library(class)
gene.knn = knn(t(train$raw), t(test$raw), train$status, k=2, prob=TRUE)

# How well does it do?
mean(gene.knn == test$status)
table(gene.knn, test$status)

# Let's make a helper function (to reduce cutting and pasting)





# How would this look if we added attributes to the knn object
my.knn1 = function(train.data, test.data, test.status, status=train$status) {
    gknn = knn(t(train.data), t(test.data), status, k=2, prob=TRUE)
    attr(gknn, "table") = table(gknn, test.status)
    attr(gknn, "mean") = mean(gknn == test.status)
    return(gknn)
}

# This is a bit cumbersome
raw.knn = my.knn1(train$raw, test$raw, test$status)
attributes(raw.knn)$mean
attributes(raw.knn)$table


# How would this look it we used a list object instead
my.knn = function(train.data, test.data, test.status, status=train$status, k=3) {
    g = list()
    g$predict = knn(t(train.data), t(test.data), status, k=k, prob=TRUE)
    g$table = table(g$predict, test.status)
    g$mean = mean(g$predict == test.status)
    return(g)
}

# Run KNN on the raw, log-transformed, and normalized data
raw.knn = my.knn(train$raw, test$raw, test$status)
raw.all.knn = my.knn(train$raw, test.all$raw, test.all$status)
log.knn = my.knn(train$log, test$log, test$status)
log.all.knn = my.knn(train$log, test.all$log, test.all$status)
norm.knn = my.knn(train$norm, test$norm, test$status)
norm.all.knn = my.knn(train$norm, test.all$norm, test.all$status)

# Which performs best?
raw.knn$mean
raw.all.knn$mean
log.knn$mean
log.all.knn$mean
norm.knn$mean
norm.all.knn$mean

# What if we want to only use some of the variables?
# This is called variable selection


# Use the t-statistic for variable selection
tConvert <- function(gene, status=train$status) {

    # your code here
    means <- by(gene, status, mean)
    stand.devs <- by(gene, status, sd)
    lengths <- by(gene, status, length)

    paired.var <- ((lengths[1]-1) * stand.devs[1]^2 + (lengths[2]-1) *
                  stand.devs[2]^2) / (length(gene)-2)
    t.stat <- (means[1]-means[2]) / (sqrt(paired.var) * sqrt(1/lengths[1]
                +1/lengths[2]))
    return(unname(t.stat))
}

t.stats <- apply(train$norm, 1, tConvert)
hist(t.stats)

# How is performance affected?
top = names(sort(abs(t.stats), decreasing=TRUE)[1:100])
raw.all.vs.knn = my.knn(train$raw[top,], test.all$raw[top,], test.all$status)

# Take a look at performance over a range of numbers for the variable selection
#x = c(10, 20, 50, 100, 200, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 8958)
x = seq(10, 8958, length.out=50)
tops = sapply(x, function(y) names(sort(abs(t.stats), decreasing=TRUE)[1:y]))
means = sapply(tops, function(top) {
                  my.knn(train$raw[top,], test.all$raw[top,], test.all$status)$mean
               }
              )

plot(x, means, type='l')

### What happens when we correctly label the training data?

train.status = train$status
levels(train.status) = c("Sensitive", "Resistant")
means = sapply(tops, function(top) {
                  my.knn(train$raw[top,], test.all$raw[top,], test.all$status, train.status)$mean
               }
              )

plot(x, means, type='l')

## Looks like the top 2000 might be best....

top = names(sort(abs(t.stats), decreasing=TRUE)[1:2000])
raw.all.vs.knn = my.knn(train$raw[top,], test.all$raw[top,], test.all$status)
raw.all.vs.knn$mean
raw.all.vs.knn = my.knn(train$raw[top,], test.all$raw[top,], test.all$status,  train.status)
raw.all.vs.knn$mean

# Let's look at a few different choices for k
raw.all.vs.knn = my.knn(train$raw[top,], test.all$raw[top,], test.all$status,  train.status, k=1)
raw.all.vs.knn$mean
raw.all.vs.knn = my.knn(train$raw[top,], test.all$raw[top,], test.all$status,  train.status, k=2)
raw.all.vs.knn$mean
raw.all.vs.knn = my.knn(train$raw[top,], test.all$raw[top,], test.all$status,  train.status, k=3)
raw.all.vs.knn$mean
raw.all.vs.knn = my.knn(train$raw[top,], test.all$raw[top,], test.all$status,  train.status, k=4)
raw.all.vs.knn$mean
raw.all.vs.knn = my.knn(train$raw[top,], test.all$raw[top,], test.all$status,  train.status, k=5)
raw.all.vs.knn$mean

# Is there a simpler way?
ks = 1:10
means = sapply(ks, function(k) {
                 my.knn(train$raw[top,], test.all$raw[top,], test.all$status,  train.status, k=k)$mean
         })
plot(ks, means, type='l')

# How does variable selection affect PCA
cols=c("red", "blue")

pca.plot <- function(d, status, title) {
    pca = prcomp(t(d))
    plot(pca, main=d$title)
    plot(pca$x[,1:2], col=cols[status], main=title)
    legend("topright", c("Sensitive", "Resistant"), fill=cols)
    plot(pca$x[,2:3], col=cols[status], main=title)
    legend("topright", c("Sensitive", "Resistant"), fill=cols)
}

pca.plot(train$raw[top,], train$status, train$title)
pca.plot(test.all$raw[top,], test.all$status, test.all$title)
pca.plot(test$raw[top,], test$status, test$title)

barplot(colSums(test$raw[top,]))
