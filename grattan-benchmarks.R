remove.packages("grattan")
install.packages("grattan", repos = "https://cran.rstudio.com")
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
  wage_from_fys10K <- rep_len(from_fys10K[from_fys10K >= "1999-00"], 10e3)
  from_fys100M <- rep(from_fys10K, times = 10e6/10e3)
  wage_from_fys100 <- rep(wage_from_fys10K, times = 10e6/10e3)
  cat("cpi\n")
  print(bench::system_time(cpi_inflator(from_fy = from_fys100M,
                                                to_fy = "2015-16",
                                                adjustment = "none")))
  cat("wage (single)\n")
  print(bench::system_time(wage_inflator(from_fy = "2011-12",
                                                to_fy = "2015-16")))
  cat("wage (10K)\n")
  print(bench::system_time(wage_inflator(from_fy = wage_from_fys10K,
                                                to_fy = "2015-16")))
  cat("wage (10M)\n")
  print(bench::system_time(wage_inflator(from_fy = wage_from_fys100,
                                                to_fy = "2015-16")))
  detach("package:grattan", unload = TRUE)
  tmp <- tempfile()
  dir.create(tmp)
  cat("\nReinstall: ...")
  devtools::install_github('hughparsonage/grattan', force = TRUE, quiet = TRUE, args = paste0('--library="', normalizePath(tmp, winslash = "/"), '"'))
  cat(packageVersion("grattan"), "\n")
  library("grattan", lib.loc = tmp)
  cat("cpi\nfrom_fys 10M:\n")
  print(bench::system_time(cpi_inflator(from_fy = from_fys100M,
                                                to_fy = "2015-16",
                                                adjustment = "none")))
  cat("from_fys 10M (hot):\n")
  print(bench::system_time(cpi_inflator(from_fy = from_fys100M,
                                                to_fy = "2015-16",
                                                adjustment = "none")))
  cat("wage (single)\n")
  print(bench::system_time(wage_inflator(from_fy = "2011-12",
                                                to_fy = "2015-16")))
  cat("wage (10K)\n")
  print(bench::system_time(wage_inflator(from_fy = wage_from_fys10K,
                                                to_fy = "2015-16")))
  cat("wage (10M)\n")
  print(bench::system_time(wage_inflator(from_fy = wage_from_fys100,
                                                to_fy = "2015-16")))




  rm(from_fys100M)


} else {
	cat("\nUnable to record benchmark.\n")
}








