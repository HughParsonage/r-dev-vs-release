
if (requireNamespace("grattan", quietly = TRUE) &&
	  requireNamespace("bench", quietly = TRUE) &&
	  requireNamespace("data.table", quietly = TRUE) &&
    requireNamespace("taxstats", quietly = TRUE)) {
library(grattan)
  library(taxstats)
  library(data.table)

  cat("sample_file_1314:\n")
  print(bench::system_time(sample_file_1314[, income_tax(Taxable_Income, "2013-14", .dots.ATO = .SD)]))
  cat("sample_file_1314 (hot):\n")
  print(bench::system_time(sample_file_1314[, income_tax(Taxable_Income, "2013-14", .dots.ATO = .SD)]))

  set.seed(19842014)
  from_fys10K <- sample(yr2fy(1984:2014), size = 10e3, replace = TRUE)
  from_fys100M <- rep(from_fys10K, times = 10e6/10e3)
  cat("cpi\n")
  print(bench::system_time(cpi_inflator(from_fy = from_fys100M,
                                                to_fy = "2015-16",
                                                adjustment = "none")))
  cat("wage\n")
  print(bench::system_time(wage_inflator(from_fy = from_fys100M,
                                                to_fy = "2015-16")))
  detach("package:grattan", unload = TRUE)
  tmp <- tempfile()
  dir.create(tmp)
  devtools::install_github('hughparsonage/grattan', force = TRUE, quiet = TRUE, args = paste0('--library="', normalizePath(tmp, winslash = "/"), '"'))
  library("grattan", lib.loc = tmp)
  cat("cpi\nfrom_fys 10M:\n")
  print(bench::system_time(cpi_inflator(from_fy = from_fys100M,
                                                to_fy = "2015-16",
                                                adjustment = "none")))
  cat("from_fys 10M (hot):\n")
  print(bench::system_time(cpi_inflator(from_fy = from_fys100M,
                                                to_fy = "2015-16",
                                                adjustment = "none")))
  cat("wage\n")
  print(bench::system_time(wage_inflator(from_fy = from_fys100M,
                                                to_fy = "2015-16")))




  rm(from_fys100M)


  print(bench::mark(min(1:1e8)))


} else {
	cat("\nUnable to record benchmark.\n")
}








