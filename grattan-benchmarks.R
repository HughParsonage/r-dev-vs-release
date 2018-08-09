
if (requireNamespace("grattan", quietly = TRUE) &&
	  requireNamespace("bench", quietly = TRUE)) {
library(grattan)
  set.seed(19842014)
  from_fys10K <- sample(yr2fy(1984:2014), size = 10e3, replace = TRUE)
  from_fys100M <- rep(from_fys10K, times = 100e6/10e3)
  print(cpi_inflator(from_fy = from_fys100M,
                                                to_fy = "2015-16",
                                                adjustment = "none"))
} else {
	cat("\nUnable to record benchmark.\n")
}




