
if (requireNamespace("grattan", quietly = TRUE) &&
	  requireNamespace("bench", quietly = TRUE)) {
library(grattan)
  set.seed(19842014)
  from_fys10K <- sample(yr2fy(1984:2014), size = 10e3, replace = TRUE)
  from_fys100M <- rep(from_fys10K, times = 1e6/10e3)
  print(bench::system_time(cpi_inflator(from_fy = from_fys100M,
                                                to_fy = "2015-16",
                                                adjustment = "none")))
  detach("package:grattan", unload = TRUE)
  tmp <- tempfile()
  dir.create(tmp)
  devtools::install_github('hughparsonage/grattan', args = paste0('--library="', normalizePath(tmp, winslash = "/"), '"'))
  library("grattan", lib.loc = tmp)
  print(bench::system_time(cpi_inflator(from_fy = from_fys100M,
                                                to_fy = "2015-16",
                                                adjustment = "none")))

} else {
	cat("\nUnable to record benchmark.\n")
}








