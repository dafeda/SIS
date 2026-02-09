# Snapshot tests for sis-demo.R
# These tests capture the expected behavior of the demo examples

test_that("Gaussian SIS without regularization works", {
  set.seed(0)
  n = 400; p = 50; rho = 0.5
  corrmat = diag(rep(1-rho, p)) + matrix(rho, p, p)
  corrmat[,4] = sqrt(rho)
  corrmat[4, ] = sqrt(rho)
  corrmat[4,4] = 1
  corrmat[,5] = 0
  corrmat[5, ] = 0
  corrmat[5,5] = 1
  cholmat = chol(corrmat)
  x = matrix(rnorm(n*p, mean=0, sd=1), n, p)
  x = x%*%cholmat
  
  set.seed(1)
  b = c(4,4,4,-6*sqrt(2),4/3)
  y=x[, 1:5]%*%b + rnorm(n)
  
  model10 = SIS(x, y, family='gaussian', iter = FALSE)
  
  expect_snapshot({
    cat("Selected variables (ix):\n")
    print(model10$ix)
    cat("\nRanked variables from screening (sis.ix0):\n")
    print(model10$sis.ix0)
    cat("\nTop 10 ranked variables:\n")
    print(model10$ix0[1:10])
  })
})

test_that("Gaussian SIS with SCAD regularization works", {
  set.seed(0)
  n = 400; p = 50; rho = 0.5
  corrmat = diag(rep(1-rho, p)) + matrix(rho, p, p)
  corrmat[,4] = sqrt(rho)
  corrmat[4, ] = sqrt(rho)
  corrmat[4,4] = 1
  corrmat[,5] = 0
  corrmat[5, ] = 0
  corrmat[5,5] = 1
  cholmat = chol(corrmat)
  x = matrix(rnorm(n*p, mean=0, sd=1), n, p)
  x = x%*%cholmat
  
  set.seed(1)
  b = c(4,4,4,-6*sqrt(2),4/3)
  y=x[, 1:5]%*%b + rnorm(n)
  
  model11 = SIS(x, y, family='gaussian', penalty = 'SCAD', iter = TRUE)
  
  expect_snapshot({
    cat("Selected variables (ix):\n")
    print(model11$ix)
    cat("\nTop 10 ranked variables for final screening:\n")
    print(model11$ix0[1:10])
    cat("\nTop 10 ranked variables for each screening step:\n")
    print(lapply(model11$ix_list, function(x){x[1:10]}))
  })
})

test_that("Binomial SIS works", {
  set.seed(0)
  n = 400; p = 50; rho = 0.5
  corrmat = diag(rep(1-rho, p)) + matrix(rho, p, p)
  corrmat[,4] = sqrt(rho)
  corrmat[4, ] = sqrt(rho)
  corrmat[4,4] = 1
  corrmat[,5] = 0
  corrmat[5, ] = 0
  corrmat[5,5] = 1
  cholmat = chol(corrmat)
  x = matrix(rnorm(n*p, mean=0, sd=1), n, p)
  x = x%*%cholmat
  
  set.seed(1)
  b = c(4,4,4,-6*sqrt(2),4/3)
  
  set.seed(2)
  feta <- x[, 1:5] %*% b
  fprob <- exp(feta) / (1 + exp(feta))
  y <- rbinom(n, 1, fprob)
  model21 <- SIS(x, y, family = "binomial", tune = "bic")
  
  expect_snapshot({
    cat("Selected variables (ix):\n")
    print(model21$ix)
    cat("\nTop 10 ranked variables for final screening:\n")
    print(model21$ix0[1:10])
    cat("\nTop 10 ranked variables for each screening step:\n")
    print(lapply(model21$ix_list, function(x){x[1:10]}))
  })
})

test_that("Cox survival model works", {
  set.seed(0)
  n = 400; p = 50; rho = 0.5
  corrmat = diag(rep(1-rho, p)) + matrix(rho, p, p)
  corrmat[,4] = sqrt(rho)
  corrmat[4, ] = sqrt(rho)
  corrmat[4,4] = 1
  corrmat[,5] = 0
  corrmat[5, ] = 0
  corrmat[5,5] = 1
  cholmat = chol(corrmat)
  x = matrix(rnorm(n*p, mean=0, sd=1), n, p)
  x = x%*%cholmat
  
  set.seed(1)
  b = c(4,4,4,-6*sqrt(2),4/3)
  
  set.seed(4)
  myrates <- exp(x[, 1:5] %*% b)
  Sur <- rexp(n, myrates)
  CT <- rexp(n, 0.1)
  Z <- pmin(Sur, CT)
  ind <- as.numeric(Sur <= CT)
  y <- survival::Surv(Z, ind)
  
  model41 <- SIS(x, y,
    family = "cox", penalty = "lasso", tune = "bic",
    varISIS = "aggr", seed = 41
  )
  model42 <- SIS(x, y,
    family = "cox", penalty = "lasso", tune = "bic",
    varISIS = "cons", seed = 41
  )
  
  expect_snapshot({
    cat("Model 41 (aggr) selected variables:\n")
    print(model41$ix)
    cat("\nModel 42 (cons) selected variables:\n")
    print(model42$ix)
  })
})

test_that("Multinomial classification works", {
  y <- as.factor(iris$Species)
  set.seed(0)
  noise <- matrix(rnorm(nrow(iris)*200), nrow(iris), 200)
  x <- cbind(as.matrix(iris[,-5]), noise)
  
  model21 <- SIS(x, y, family = "multinom", penalty = 'lasso')
  
  expect_snapshot({
    cat("Selected variables (ix):\n")
    print(model21$ix)
    cat("\nTop 10 ranked variables for final screening:\n")
    print(model21$ix0[1:10])
    cat("\nTop 10 ranked variables for each screening step:\n")
    print(lapply(model21$ix_list, function(x){x[1:10]}))
  })
})
