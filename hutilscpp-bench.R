install.packages(c("data.table", "bench", "hutils", "Rcpp"), repos = "https://cran.rstudio.com", quiet = TRUE)
devtools::install_github("hughparsonage/hutilscpp", quick = TRUE)

library(hutilscpp)

N <- 1e5
N <- 1e8  ## too slow for CRAN

# Two examples, from slowest to fastest,
# run with N = 1e8 elements

                                       # seconds
x <- rep_len(runif(1e4, 0, 6), N)
bench_system_time(x > 5)
cat("which\n")
bench_system_time(which(x > 5))        # 0.8
cat("which.max\n")
bench_system_time(which.max(x > 5))    # 0.3
cat("Position\n")
bench_system_time(Position(f = function(x) x > 5, x, nomatch = 0L))
cat("which_first\n")
bench_system_time(which_first(x > 5))  # 0.000

rm(x)
x <- rep_len(sample(1:100), N)
bench_system_time(x > 5)
cat("which\n")
bench_system_time(which(x > 5))        # 0.8
cat("which.max\n")
bench_system_time(which.max(x > 5))    # 0.3
cat("Position\n")
bench_system_time(Position(f = function(x) x > 5, x, nomatch = 0L))
cat("which_first\n")
bench_system_time(which_first(x > 5))  # 0.000
rm(x)


## Worst case: have to check all N elements
x <- double(N)
cat("which\n")
bench_system_time(which(x > 0))        # 1.0
cat("which.max\n")
bench_system_time(which.max(x > 0))    # 0.4  but returns 1, not 0
cat("which_first\n")
bench_system_time(which_first(x > 0))  # 0.1



