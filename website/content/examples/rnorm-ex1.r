# x = rnorm(3)
# length(x)
# str(x)
# summary(x)

x = rnorm(1000000)
hist(x, freq=FALSE)
curve(dnorm, add=TRUE)

