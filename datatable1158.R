library(data.table)
for (tries in 1:1000) {
	if (i %% 10 == 9) cat(".")
	DT = data.table(k = 1:50, g = 1:20, val = rnorm(1e4))
	before = gc()["Vcells",2]
	for (i in 1:50) DT[ , unlist(.SD), by = 'k']
	after = gc()["Vcells",2]
	if (after >= before + 3) {
		cat("before:\t", prettyNum(round(before, 3), big.mark = ","), "\n",
			"after:\t", prettyNum(round(after, 3), big.mark = ","), "\n", sep = "")
		warning("data.table 1158 on ", tries, ".")
	}
}
