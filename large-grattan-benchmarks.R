tempf <- tempfile()
dir.create(tempf)
cat("R.version", "\n")
print(R.version)
cat("\nSys.info:\n")
print(Sys.info())
install.packages("grattan", repos = "https://cran.rstudio.com", quiet = TRUE, lib = tempf)
if (requireNamespace("grattan", quietly = TRUE, lib.loc = tempf) &&
    requireNamespace("bench", quietly = TRUE) &&
	  requireNamespace("devtools", quietly = TRUE) &&
	  requireNamespace("data.table", quietly = TRUE)) {
  library(grattan, lib.loc = tempf)
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
  from_fys1G <- sample(yr2fy(1984:2016), size = 100, replace = TRUE)
  cat(".")
  from_fys1G <- rep(from_fys1G, times = if (tolower(Sys.info()['sysname']) == "darwin") 50e3 else 8e3)
  cat("cpi ", prettyNum(length(from_fys1G), big.mark = ","), "\n")
  print(bench::system_time(cpi_inflator(from_fy = from_fys1G,
                                                to_fy = "2015-16",
                                                adjustment = "none")))
  tmp <- tempfile()
  dir.create(tmp)
  detach("package:grattan", unload = TRUE)
  cat("\n", crayon::bgGreen("Reinstall: ..."), "\n")
  devtools::install_github('hughparsonage/grattan', force = TRUE, quiet = TRUE, args = paste0('--library="', normalizePath(tmp, winslash = "/"), '"'))
  report_version(tmp)
  library("grattan", lib.loc = tmp)
  print(devtools::session_info())

  cat("cpi ", prettyNum(length(from_fys1G), big.mark = ","), "\n")
  print(bench::system_time(cpi_inflator(from_fy = from_fys1G,
                                                to_fy = "2015-16",
                                                adjustment = "none")))

  from_fys1G <- rep(from_fys1G, times = 10)
  cat("cpi ", prettyNum(length(from_fys1G), big.mark = ","), "\n")
  print(bench::system_time(cpi_inflator(from_fy = from_fys1G,
                                                to_fy = "2015-16",
                                                adjustment = "none")))


} else {
  for (i in rownames(installed.packages())) {
    cat(i, "\n")
  }
	cat("\nUnable to record benchmark.\n")
}








