if (requireNamespace("data.table", quietly = TRUE)) {
	remove.packages("data.table")
}

install.packages("data.table", repos="https://Rdatatable.gitlab.io/data.table")

library(data.table)
print(sessionInfo())

library(data.table)
DT=as.data.table(list(V1=NULL))
DT[V1==0] # seg fault.

