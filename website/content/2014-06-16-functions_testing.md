title: Section Notes - 3
author: Karl Kumbier
date: 2014-06-17
slug: notes3


# Functions and Unit Testing
## Functions

Functions are an important tool for interacting with data in R. You're probably
already familiar with the idea of functions from math classes. In R, we use
functions to manipulate some input argument(s) and return some output
arguments(s). You've already seen some examples of built in R functions:


```r
# Take the mean of <numeric.vector>
numeric.vector <- 1:10
mean(numeric.vector)
```

```
## [1] 5.5
```

```r

# Generate 10 standard normal random variables
rnorm(10)
```

```
##  [1]  1.8051 -1.3698  0.2661  0.4697  1.0124  1.5709  0.4211  0.8027
##  [9]  0.2071  0.9277
```


R also allows you to define your own functions. The implementation of a generic
function is shown below.


```r
someFunction <- function(arg1, arg2, ...) {
    
    # statement 
    # return(object)
    
}
```


The following code (when the statement and return values are not commented out)
would store a function called "someFunction" in your workspace. When called,
someFunction would perform the computations indicated by "statement" (presumably
on the values supplied by **arg1**, **arg2**, ...) and return the value
**object** (presumably a result of the computations in "statement"). It is
important to note that *implementing* a function is different than *calling* the
function. When we *implement* a function, it is stored in your workspace for
later use.  When we *call* a function, we are telling R to use the stored function to actually perform the calculations associated with it.


```r
# Here, we are implementing the function 'add'. This function takes two
# arguments and returns their sum.
add <- function(x, y) {
    result <- x + y
    return(result)
}

# Here, we are calling the function with different arguments
add(1, 1)
```

```
## [1] 2
```

```r
add(0, 10)
```

```
## [1] 10
```

```r
add(1.5, 2.5)
```

```
## [1] 4
```


Something that is important to note with R is that functions can only return
*one* result. If we want to write a function that returns multiple values, we
can get around this by having the function return a vector or list (depending on
whether the return values are the same type). Suppose we wanted to write a
function that returned both the sum and difference of its two arguments.


```r
# This function will throw an error when it is called when it tries to
# return multiple results
sumDiff <- function(x, y) {
    result.sum <- x + y
    result.diff <- x - y
    return(result.sum, result.diff)
}

sumDiff(4, 2)
```

```
## Error: multi-argument returns are not permitted
```

```r

# Either of these functions will work since we combine the two return values
# into one argument
sumDiff <- function(x, y) {
    result.sum <- x + y
    result.diff <- x - y
    return(c(result.sum, result.diff))
}

sumDiff(4, 2)
```

```
## [1] 6 2
```

```r

sumDiff <- function(x, y) {
    result.sum <- x + y
    result.diff <- x - y
    return(list(s = result.sum, d = result.diff))
}

sumDiff(4, 2)
```

```
## $s
## [1] 6
## 
## $d
## [1] 2
```


### A brief mention of scoping

When you start to define functions, you'll need to think about what variables different parts of the program have access. This idea is known as *scoping*. R uses *lexical scoping* which means that functions access variables relative to where they are defined (as opposed to where they are called). The basic idea is that when you use a variable in the body of a function, R will first look to see if that variable is defined in the body. If it isn't, R will move to the environment in which the function was defined (i.e. your workspace or the body of another function). As with many things in R, an example should make this a bit more clear.


```r
bob.age = 10
jane.age = 12
getAge <- function(person) {
    if (person == "Bob") 
        return(bob.age) 
	else if (person == "Jane") 
        return(jane.age)
}

getNewAge <- function(person) {
    bob.age = 11
    jane.age = 13
    getAge(person)
}

getNewAge("Bob")
```

```
## [1] 10
```

```r
getNewAge("Jane")
```

```
## [1] 12
```


The definition of "getAge" requires the variables **bob.age** and **jane.age**. Since they are not defined in the body of the function, R looks up one level and finds them defined in the workspace. Whenever we call the function "getAge", these variables in the workspace are tied to the values that "getAge" returns. Even if we redefine the variables **bob.age** and **jane.age** in a new environment (the body of "getNewAge"), "getAge" will still access the variables from the workspace because of where it was defined.


## Unit Testing

When you learned basic algebra, you were probably told to check your answer by
plugging your result back into the equation. This is an easy test to make sure
you performed the correct calculations. As you start to build larger projects in
R (or any language for that matter), it becomes increasingly important to check
that your code is performing correctly along the way. Unit testing packages in R
provide the framework to test your code in this way. We're going to cover the
"RUnit" package, but there are other unit testing packages that work
well. First, you'll have to install the package using the following command:

```{R}
install.packages("RUnit")
```

Whenever you install a package, make sure the name is in quotes. Otherwise R
will think you're referring to some variable in the workspace. You should get a
prompt telling you to select a CRAN Mirror, choose CA1. After the package is
installed, you'll need to load it using the following command:


```r
library("RUnit")
```


Congratulations! You can now use all of the functions supplied in the RUnit
package. You will have to load the package (using "library") every time you
start a new R session, but you don't have to install it again. The most
important functions for you to know in this package are the check functions:
"checkEquals", "checkEqualsNumeric", "checkIdentical", "checkTrue",
"checkException".  These functions are used to compare the output of your
functions with some expected output (target value, logical, or exception).

If our function returns some numeric value, we can use "checkEquals" to compare
the output of our function with the desired value:

```r
checkEquals(add(1, 1), 2)
```

```
## [1] TRUE
```

```r
checkEquals(add(1, 1), 4)
```

```
## Error: Mean relative difference: 1
```


If our function returns a logical, we can check to see whether it returns TRUE
when we expect it to:


```r
isPositive <- function(x) {
    return(x > 0)
}

checkTrue(isPositive(1))
```

```
## [1] TRUE
```

```r
checkTrue(isPositive(-1))
```

```
## Error: Test not TRUE
```


You'll notice that R throws an error when the check statements don't evaluate to
TRUE. Normally, you would write your tests in such a way that the statements
evaluate to TRUE if your function performs as you expect it to. Thus,
an error in the test for some specific function would indicate that it is not doing what
you expect. Often times, you'll want to use multiple tests for each function to
check the range of input/output values you expect to use/see. However, if one of
the tests throws an error, our program will stop running and the remaining tests
will fail to evaluate. To prevent this, we'll use a "tryCatch"
statement. Essentially, R will try to evaluate some statement and then perform a
specified action if an error is thrown. We'll write a function "divide" to show
this in action. We would like "divide" to perform standard division in R, but
when dividing by 0 it should return NA instead of Inf.


```r
# This is an incorrect version of the function. It will throw an error when
# we try to run our unit tests on it

divide <- function(numerator, denominator) {
    return(numerator/denominator)
}

tryCatch(checkIdentical(divide(1, 0), NA), error = function(err) print(paste("Error:", 
    err)))
```

```
## [1] "Error: Error in checkIdentical(divide(1, 0), NA): FALSE \n"
```

```r

tryCatch(checkEquals(divide(1, 2), 0.5), error = function(err) print(paste("Error:", 
    err)))
```

```
## [1] TRUE
```


If we ran this code without "tryCatch", R would throw an error after the first
test and stop running. As a result, our second test wouldn't get
evaluated. This means we wouldn't be able to tell if there was a problem with
our entire function or just a small part. With "tryCatch" we can test different
evaluations of our function all at once, which helps
isolate why the function is failing. After seeing the output in the example
above, it would be clear that our function is dividing properly but not dealing
with the divide by 0 case like we expect it to.
