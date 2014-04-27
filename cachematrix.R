## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
## This function helps in setting up a matrix with values. Additionally, getInverseMatrix stores
## the cached values for a given matrix x if the cacheSolve matrix is called on atleast once

makeCacheMatrix <- function(x = matrix()) {
  im <- NULL
  set <- function(y=matrix()) {
    x <<- y
    im <<- NULL
  }
  get <- function() x
  setInverseMatrix <- function(inverse) im <<- inverse
  getInverseMatrix <- function() im
  list(set = set, get = get,
       setInverseMatrix = setInverseMatrix,
       getInverseMatrix = getInverseMatrix)
}

## This function calculates and returns the inverse matrix for a given matrix. If a given matrix is
## same as before, it calls a function in makeCacheVector to get values from the cache instead of
## recalculating it

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  im <- x$getInverseMatrix()
  if(!is.null(im)) {
    message("getting cached data")
    return(im)
  }
  data <- x$get()
  inverse <- solve(data,...)
  x$setInverseMatrix(inverse)
  inverse
}
