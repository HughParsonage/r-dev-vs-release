
	Sys.setenv('R_GRATTAN_BUILD_MAIN_VIGNETTE' = 'true')
	Sys.setenv('R_GRATTAN_ALLOW_TAXSTATS' = 'true')
install.packages("remotes", repos = "https://cran.rstudio.com")
install.packages("grattan", repos = "https://cran.rstudio.com")

install.packages("taxstats", repos = "https://hughparsonage.github.io/tax-drat/", type = "source")
grattan::install_taxstats()
remotes::install_github("hughparsonage/grattan", dependencies = NA, upgrade = "never")




