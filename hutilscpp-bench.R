install.packages(c("data.table", "bench", "hutils", "Rcpp", "devtools"), repos = "https://cran.rstudio.com", quiet = TRUE)
library(hutils)
provide.file("~/.R/Makevars")
cat("PKG_CXXFLAGS += -O3\n", file = "~/.R/Makevars", append = TRUE)
cat("PKG_LIBS += -O3\n", file = "~/.R/Makevars", append = TRUE)


devtools::install_github("hughparsonage/hutilscpp")

library(hutilscpp)

N <- 1e5
N <- 1e8  ## too slow for CRAN

# Two examples, from slowest to fastest,
# run with N = 1e8 elements

bench_system_time <- function(...) {res <- hutilscpp::bench_system_time(...); cat(as.character(as.integer(1000 * as.numeric(res[2]))), "ms\n\n")}

                                       # seconds
cat("x <- rep_len(runif(1e4, 0, 6), N)\n")
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
cat("\n\nx <- rep_len(sample(1:100), N)\n")
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
cat("\n\ndouble(N)\n")
x <- double(N)
cat("which\n")
bench_system_time(which(x > 0))        # 1.0
cat("which.max\n")
bench_system_time(which.max(x > 0))    # 0.4  but returns 1, not 0
cat("which_first\n")
bench_system_time(which_first(x > 0))  # 0.1

x <- NULL
x <- integer(N)

library(Rcpp)
sourceCpp("rollers.cpp", showOutput = TRUE)
bench_system_time(which_first_equal_A(x, 1L))
bench_system_time(which_first_equal_B(x, 1L))

print(bench::mark(which_first_equal_A(x, 1L),
                  which_first_equal_B(x, 1L),
                  iterations = 10))

cat("CXX = clang++\n", file = "~/.R/Makevars", append = TRUE)

sourceCpp("rollers.cpp", showOutput = TRUE)
bench_system_time(which_first_equal_A(x, 1L))
bench_system_time(which_first_equal_B(x, 1L))

print(bench::mark(which_first_equal_A(x, 1L),
                  which_first_equal_B(x, 1L),
                  iterations = 10)








