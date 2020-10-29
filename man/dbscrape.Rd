\name{dbscrape}
\alias{dbscrape}
\title{dbscrape}
\usage{

"std_url" The URL post pagination (stops to 'page=').
"pages" Pagination range (i.e. '1:88'). Must start from 1 and end to the respective query end page (search for this manually).
"postfix" Optional. Applied on-page filters. These are indicated after the "page=" url part. See second example.

}
\description{
Scrape HTML Tables from Drugbank
}
\examples{
std_url <- "https://go.drugbank.com/pharmaco/metabolomics?page="
pages <- 1:124
postfix <- ""
dbscrape::dbscrape(std_url, pages, postfix)

std_url <- "https://go.drugbank.com/categories?approved=0&ca=0&eu=1&experimental=1&illicit=0&investigational=0&nutraceutical=0&page="
pages <- 1:36
postfix <- "&q[description]=&q[drug_count]=&q[target_count]=&q[title]=&us=0&withdrawn=0"
dbscrape::dbscrape(std_url, pages, postfix)
}
