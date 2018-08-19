remove.packages("grattan")
install.packages("grattan", repos = "https://cran.rstudio.com", quiet = TRUE)
if (requireNamespace("grattan", quietly = TRUE) &&
	  requireNamespace("bench", quietly = TRUE) &&
	  requireNamespace("data.table", quietly = TRUE)) {
  library(grattan)
  library(data.table)
  library(utils)
  report_version <- function(lib.loc = NULL) {
    if (getRversion() >= "3.5.0") {
      cat(as.character(packageVersion("grattan", lib.loc = lib.loc)), "\t", as.character(packageDate("grattan", lib.loc = lib.loc)))
    } else {
      cat(as.character(packageVersion("grattan", lib.loc = lib.loc)))
    }
    cat("\n")
  }
  report_version()
  gc()

  set.seed(19842014)
  from_fys1G <- sample(yr2fy(1984:2016), size = 1e6, replace = TRUE)
  cat(".")
  from_fys1G <- rep(from_fys1G, times = 500)
  cat("cpi (1bn)\n")
  print(bench::system_time(cpi_inflator(from_fy = from_fys1G,
                                                to_fy = "2015-16",
                                                adjustment = "none")))
  tmp <- tempfile()
  dir.create(tmp)
  cat("\n", crayon::bgGreen("Reinstall: ..."))
  devtools::install_github('hughparsonage/grattan', force = TRUE, quiet = TRUE, args = paste0('--library="', normalizePath(tmp, winslash = "/"), '"'))
  report_version(tmp)
  library("grattan", lib.loc = tmp)
  cat("cpi\nfrom_fys (1bn):\n")
  print(bench::system_time(cpi_inflator(from_fy = from_fys1G,
                                                to_fy = "2015-16",
                                                adjustment = "none")))
  rm(from_fys1G)


} else {
	cat("\nUnable to record benchmark.\n")
}








