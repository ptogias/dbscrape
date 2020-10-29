# dbscrape: scrape html tables from drugbank

Export HTML tables from DrugBank to dataframes. This function can come in handy in cases where 
downloading and processing the full database is not viable. Code was kept as simple as possible, 
using only the xpath of each table and spliting respective urls in a manner that takes pagination 
into account.

##### Note
After fetching is finished, some tables may need further proccesing for information to be presentable 
-I suggest using regex to fix those issues.

Install:

```R
if (!requireNamespace("remotes")) install.packages("remotes")
remotes::install_github("ptogias/dbscrape")
```

## Overview

There are three parameters used in dbscrape
#### 1. std_url 
*Character.* The URL post pagination (stops to 'page=').
#### 2. pages 
*Numeric.* Pagination range (i.e. '1:88'). Must start from 1 and end to the respective query end page (search for this manually).
#### 3. postfix 
_[Optional]_ *Character.* Applied on-page filters. These are indicated after the "page=" url part. Defaults to an empty char vector. See second example.

## Examples

```R
std_url <- "https://go.drugbank.com/pharmaco/metabolomics?page="
pages <- 1:124
postfix <- ""
dbscrape::dbscrape(std_url, pages, postfix)

std_url <- "https://go.drugbank.com/categories?approved=0&ca=0&eu=1&experimental=1&illicit=0&investigational=0&nutraceutical=0&page="
pages <- 1:36
postfix <- "&q[description]=&q[drug_count]=&q[target_count]=&q[title]=&us=0&withdrawn=0"
dbscrape::dbscrape(std_url, pages, postfix)
```
