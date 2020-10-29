#' @title dbscrape
#'
#' @description Scrape HTML Tables from Drugbank
#'
#' @param std_url The URL post pagination (stops to 'page=').
#' @param pages Pagination range (i.e. '1:88'). Must start from 1 and end to the respective query end page (search for this manually).
#' @param postfix Optional. Applied on-page filters. These are indicated after the "page=" url part. See second example.
#'
#' @return results
#'
#' @examples
#' std_url <- "https://go.drugbank.com/pharmaco/metabolomics?page="
#' pages <- 1:124
#' postfix <- ""
#' dbscrape::dbscrape(std_url, pages, postfix)
#'
#' std_url <- "https://go.drugbank.com/categories?approved=0&ca=0&eu=1&experimental=1&illicit=0&investigational=0&nutraceutical=0&page="
#' pages <- 1:36
#' postfix <- "&q[description]=&q[drug_count]=&q[target_count]=&q[title]=&us=0&withdrawn=0"
#' dbscrape::dbscrape(std_url, pages, postfix)
#'
#' @export

dbscrape <- function(std_url, pages, postfix) {

urls <- paste0(std_url, pages, postfix)

table_names <- std_url %>%
  xml2::read_html() %>%
  rvest::html_nodes(xpath = "/html/body/main/div/form/div[2]/table/thead/tr[1]") %>%
  rvest::html_children() %>%
  rvest::html_text()


tofill <- data.frame(
  matrix(character(),
         ncol = length(table_names),
         nrow = 0,
         dimnames = list(NULL, table_names))
  )

pb <- progress::progress_bar$new(
  format = "  downloading [:bar] :percent eta: :eta | got :bytes",
  total = length(pages), clear = FALSE, width = 75)

get_tables <- function(x) {

  pb$tick()

  table <- x %>%
    read_html() %>%
    html_nodes(xpath = "/html/body/main/div/form/div[2]/table") %>%
    html_table()

  names(table[[1]]) <- names(tofill)
  tofill <- bind_rows(tofill, table[[1]])

}


results <- lapply(urls, get_tables) %>%
  data.table::rbindlist()

return(results)

}

