# NOTE: no fff function
if (requireNamespace("pryr", quietly = TRUE)) {
  update.packages(ask = FALSE)
} else {
  install.packages("pryr")
}
require(data.table)
n <- 2e6
df <- data.frame(a=rnorm(n),
                 b=factor(rbinom(n,5,prob=0.5),1:5,letters[1:5]),
                 c=factor(rbinom(n,5,prob=0.5),1:5,letters[1:5]))
dt <- setDT(df)
print(pryr::mem_used())
aref <- "a"
for(i in 1:10) {
  ff <- lapply(1:5, function(i) {
    dt2 <- dt[,list(sumA=sum(get(aref))),by=b][,c:=letters[i]]
    dt2
  })
  f <- rbindlist(ff)
  rm("f")
  gc()
  print(pryr::mem_used())
}
# 66.6 MB
# 170 MB
# 273 MB
# 375 MB
