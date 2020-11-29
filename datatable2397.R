# datatable2397.R
if (unname(Sys.info()["sysname"] == "Linux")) {
	if ("package:data.table" %in% search()) {
		detach("package:data.table", unload = TRUE)
	}
remove.packages("data.table")
install.packages("data.table")
library(data.table)
fread("https://github.com/HughParsonage/US-flights-data-2017/raw/master/data-raw/ReleaseableAircraft2017/ACFTREF.txt")

detach("package:data.table", unload = TRUE)
remove.packages("data.table")
devtools::install_github("rdatatable/data.table")
library(data.table)
fread("https://github.com/HughParsonage/US-flights-data-2017/raw/master/data-raw/ReleaseableAircraft2017/ACFTREF.txt")
}


