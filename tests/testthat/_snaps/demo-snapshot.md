# Gaussian SIS without regularization works

    Code
      cat("Selected variables (ix):\n")
    Output
      Selected variables (ix):
    Code
      print(model10$ix)
    Output
      [1] 3 2 1 5 4
    Code
      cat("\nRanked variables from screening (sis.ix0):\n")
    Output
      
      Ranked variables from screening (sis.ix0):
    Code
      print(model10$sis.ix0)
    Output
       [1]  3  2  1  5 29  9 31 47 24 30 46  7 11 25 43 35 42 18 48  6 21 32 10 50 22
      [26]  4  8 44 34 36 26 41 33 17 19 16 13 14 12 23 45 49 39 20 15 27 38 28 40 37
    Code
      cat("\nTop 10 ranked variables:\n")
    Output
      
      Top 10 ranked variables:
    Code
      print(model10$ix0[1:10])
    Output
       [1]  3  2  1  5 29  9 31 47 24 30

# Gaussian SIS with SCAD regularization works

    Code
      cat("Selected variables (ix):\n")
    Output
      Selected variables (ix):
    Code
      print(model11$ix)
    Output
      [1] 3 2 1 5 4
    Code
      cat("\nTop 10 ranked variables for final screening:\n")
    Output
      
      Top 10 ranked variables for final screening:
    Code
      print(model11$ix0[1:10])
    Output
       [1]  3  2  1  5  4 24 13 45 42 16
    Code
      cat("\nTop 10 ranked variables for each screening step:\n")
    Output
      
      Top 10 ranked variables for each screening step:
    Code
      print(lapply(model11$ix_list, function(x) {
        x[1:10]
      }))
    Output
      [[1]]
       [1]  3  2  1  5 29  9 31 47 24 30
      
      [[2]]
       [1]  3  2  1  5  4 24 13 45 42 16
      

# Binomial SIS works

    Code
      cat("Selected variables (ix):\n")
    Output
      Selected variables (ix):
    Code
      print(model21$ix)
    Output
      [1] 1 3 2 5 4
    Code
      cat("\nTop 10 ranked variables for final screening:\n")
    Output
      
      Top 10 ranked variables for final screening:
    Code
      print(model21$ix0[1:10])
    Output
       [1]  1  3  2  5  4 11  7 17 27 46
    Code
      cat("\nTop 10 ranked variables for each screening step:\n")
    Output
      
      Top 10 ranked variables for each screening step:
    Code
      print(lapply(model21$ix_list, function(x) {
        x[1:10]
      }))
    Output
      [[1]]
       [1]  1  3  2  5 29 30 31 25 17 13
      
      [[2]]
       [1]  1  3  2  5  4 11  7 17 27 46
      

# Cox survival model works

    Code
      cat("Model 41 (aggr) selected variables:\n")
    Output
      Model 41 (aggr) selected variables:
    Code
      print(model41$ix)
    Output
       [1]  1  2  3  4  5  6  9 18 29 31 40 42 47 12 14 22 23 27 28 33 34 39 43 49 50
    Code
      cat("\nModel 42 (cons) selected variables:\n")
    Output
      
      Model 42 (cons) selected variables:
    Code
      print(model42$ix)
    Output
       [1]  1  2  3  4  5  6  9 22 23 29 31 34 39 47 50 12 14 18 27 28 33 40 42 43 49

# Multinomial classification works

    Code
      cat("Selected variables (ix):\n")
    Output
      Selected variables (ix):
    Code
      print(model21$ix)
    Output
      [1]   4   3   1   2  73 177  34
    Code
      cat("\nTop 10 ranked variables for final screening:\n")
    Output
      
      Top 10 ranked variables for final screening:
    Code
      print(model21$ix0[1:10])
    Output
       [1]   4   3   1   2  73 177  34  NA  NA  NA
    Code
      cat("\nTop 10 ranked variables for each screening step:\n")
    Output
      
      Top 10 ranked variables for each screening step:
    Code
      print(lapply(model21$ix_list, function(x) {
        x[1:10]
      }))
    Output
      [[1]]
       [1]   4   3   1   2  13  18 100 188 167  37
      
      [[2]]
       [1]   4   3   1   2  73 177  34  16 174  44
      

