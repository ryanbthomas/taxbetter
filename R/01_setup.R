library(tidyverse)
library(usethis)
library(fs)

# shape files from teh U.S. Census
# https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html

shape_files <- c(
        "https://www2.census.gov/geo/tiger/TIGER2018/CD/tl_2018_us_cd116.zip",
        "https://www2.census.gov/geo/tiger/TIGER2018/ZCTA5/tl_2018_us_zcta510.zip"
)

# irs data from 
# https://www.irs.gov/statistics/soi-tax-stats-individual-income-tax-statistics-2016-zip-code-data-soi

irs_zip_data <- "https://www.irs.gov/pub/irs-soi/zipcode2016.zip"

# setup project structure
walk(c("data", "R", "cache", "report"), use_directory)        

message("Downloading data")

save_data <- function(x, replace = FALSE) {
        destfile <- path("data", str_extract(x, "(?<=\\/)[0-9a-z_]+\\.zip"))
        
        if (replace || !file.exists(destfile)) {
                download.file(x, destfile, method = "libcurl", mode = "wb")
        }
}

walk(shape_files, save_data)

save_data(irs_zip_data)
