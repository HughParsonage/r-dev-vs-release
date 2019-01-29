

library(data.table)
print(sessionInfo())

library(data.table)
DT=as.data.table(list(V1=NULL))
DT[V1==0] # seg fault.

