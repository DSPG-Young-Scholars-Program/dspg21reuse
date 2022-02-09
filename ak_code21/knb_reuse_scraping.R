library(RSelenium)
library(rvest)
library(XML)
library(methods)
library(jsonlite)
library(xml2)
library(curl)
library(dataone)
library(tidyverse)
library(stringr)
library(data.table)

#Dataone package
#Helpful documentation for searching - https://cran.r-project.org/web/packages/dataone/vignettes/v03-searching-dataone.html
cn <- CNode()
getQueryEngineDescription(cn, "solr")

cn <- CNode("PROD")
mn <- getMNode(cn, "urn:node:KNB")
queryParamList <- list(q="id:doi*", rows="1000",fq="abstract:carbon",fl="id, size, documents")
results <- query(mn, solrQuery=queryParamList, as="data.frame",parse=FALSE)
view(results)

length(unique(results$id))
#Returns 28000, but even near the bottom begin with A, and cant see documents column either


#This function counts the number of files from the documents column
count_files <- function(doc){
  if (is.na(doc)){
    doc = 1
  } else{
    num_commas = str_count(doc,",")
    doc = num_commas + 1
  }
}


### FUNCTIONS for KNB

#Only run once
rD <- rsDriver(browser="firefox", port=4577L, verbose=F)
remDr <- rD[["client"]]

#This function counts the number of files from the documents column
count_files <- function(doc){
  if (is.na(doc)){
    doc = 1
  } else{
    num_commas = str_count(doc,",")
    doc = num_commas + 1
  }
}


## Returns a dataframe "articles" with a column for id, size, and number of documents
get_articles <- function(){
  cn <- CNode("PROD")
  mn <- getMNode(cn, "urn:node:KNB")
  queryParamList <- list(q="id:doi*", rows="200", fq="abstract:carbon",fl="id,size,documents")
  articles <- query(mn, solrQuery=queryParamList, as="data.frame",parse=FALSE)
  docs <- articles[,3]
  numfiles <- lapply(docs,count_files)
  articles$documents <- numfiles
  articles
}

articles

## Get Article Stats 
get_article_stats <- function(articleid) {
  
  #Downloads, Views, and Citations
  url <- paste0("https://knb.ecoinformatics.org/view/", articleid)
  remDr$navigate(url)
  Sys.sleep(10) # give the page time to fully load
  html <- remDr$getPageSource()[[1]]
  page<-read_html(html)
  bigthree_metrics <- html_nodes(page,".metric-value.badge")
  bigthree_metrics <- html_text(bigthree_metrics)
  downloads <- as.numeric(bigthree_metrics[1])
  citations <- as.numeric(bigthree_metrics[2])
  views <- as.numeric(bigthree_metrics[3])
  
  
  #Metadata Stats
  #urls <-(html_nodes(page,"a.route-to-metadata"))
  #urls <- html_attr(urls, "href")
  #md_id <-str_extract(urls, "doi.*")
  md_url <- paste0("https://knb.ecoinformatics.org/quality/",md_id)
  remDr$navigate(md_url)
  Sys.sleep(10) #give the page time to fully load
  md_html <- remDr$getPageSource()[[1]]
  md_page<-read_html(md_html)
  checks <- html_nodes(md_page, "h4")
  checks <- html_text(checks)
  regexp <- "[[:digit:]]+"
  passed_checks <- as.numeric(str_extract(checks[1], regexp))
  warning_checks <- as.numeric(str_extract(checks[2], regexp))
  failed_checks <- as.numeric(str_extract(checks[3], regexp))
  total_checks <- passed_checks + warning_checks + failed_checks
  #Fail Descriptions
  #fail <- html_nodes(md_page,"li.list-group-item.check.fail.in.collapse.row-fluid")
  #fail <- html_text(fail)
  #failure <- clean_failure(fail)
  
  #All Stats
  dt <- data.table(articleid, downloads, citations, views, total_checks, passed_checks, warning_checks, failed_checks) #failure)
  dt
}

view(get_article_stats("doi:10.5063/AA/connolly.116.10"))

# GET INFO AND STATS FOR ALL ARTICLES
## Create empty data.table
final_dt <- data.table(id = character(), size = numeric(), number_of_files = numeric(),downloads = numeric (),citations = numeric(), views = numeric(),
                       total_checks = numeric(), passed_checks = numeric(), warning_checks = numeric(), failed_checks = numeric()) #failure = character())


## Get info and stats, create data.table, combine with final_dt
for (i in 1:nrow(articles)){
  articleid <- articles[i,1]
  article_stats <- get_article_stats(articleid)
  info_stats_dt <- 
    data.table(
      id = articleid, 
      size = articles[i,2], 
      number_of_files = articles[i,3], 
      downloads = article_stats$downloads[[1]], 
      citations = article_stats$citations[[1]],
      views = article_stats$views[[1]],
      total_checks = article_stats$total_checks[[1]],
      passed_checks = article_stats$passed_checks[[1]],
      warning_checks = article_stats$warning_checks[[1]],
      failed_checks = article_stats$failed_checks[[1]]
      #failure <- article_stats$failure[[1]]
    )
  
  print(info_stats_dt)
  print(paste("adding id", articleid, "to final"))
  final_dt <- rbindlist(list(final_dt, info_stats_dt))
}

view(final_dt)


knb_urls_dt <-data.table(urls = knb_urls)
final_urls_dt <- rbdind(list(final_urls_dt, knb_urls_dt))


##KNB
##Dataset Page
url<-"https://knb.ecoinformatics.org/view/doi:10.5063/AA/nceas.900.10"
remDr$navigate(url)
Sys.sleep(10) # give the page time to fully load
html <- remDr$getPageSource()[[1]]
page<-read_html(html)


#Check if dataset is from KNB

html_nodes(page, "span.publisher")
knb_check <- html_text(knb_check)
knb_check


#Downloads, Citations Views
bigthree_metrics <-html_nodes(page,".metric-value.badge")
bigthree_metrics <- html_text(bigthree_metrics)
as.numeric(bigthree_metrics[3])

#File Name and Size
size_metrics <- html_nodes(page, "div.download-contents")
size_metrics <- html_text(size_metrics)
size_metrics



##Metadata assessment report

md_url<-"https://knb.ecoinformatics.org/quality/doi%3A10.5063%2FF1XK8CT1"
remDr$navigate(md_url)
Sys.sleep(10) # give the page time to fully load
md_html <- remDr$getPageSource()[[1]]
md_page<-read_html(md_html)

#Identification, Discovery, and Interpretation percentages
percent_metrics<-html_nodes(md_page,"#mdqTypeSummary")
percent_metrics <- html_text(percent_metrics)
percent_metrics

#Metadata checks
md_checks <- html_nodes(md_page, "div.check-output")
md_checks <- html_text(md_checks)
md_checks

#check count
check_count <- html_nodes(md_page, "h4")
check_count <- html_text(check_count)
check_count

# prepare regular expression
regexp <- "[[:digit:]]+"

# process string
passed <- as.numeric(str_extract(check_count[1], regexp))
passed

##Which test(s) did the metadata fail
failed1 <- html_nodes(md_page,"li.list-group-item.check.fail.in.collapse.row-fluid")
failed1 <- html_text(failed1)
failed1

#check examples for 0,1, and multiple failures for splicing!


##Metadata assessment report

md_url <-'https://knb.ecoinformatics.org/quality/doi%3A10.6085%2FAA%2Fknb-lter-sbc.19.1'
remDr$navigate(md_url)
Sys.sleep(10) # give the page time to fully load
md_html <- remDr$getPageSource()[[1]]
md_page<-read_html(md_html)
failed2 <- html_nodes(md_page,"li.list-group-item.check.fail.in.collapse.row-fluid")
failed2 <- html_text(failed2)
failed2 <- str_replace_all(failed2, "[\t\n]" , "")
failed2 <- str_replace_all(failed2, "FAILUREREQUIRED","")
failed2 <- str_replace_all(failed2, "  ","")
all_fails <- paste(failed2, collapse='')
all_fails


typeof(failed2)

clean_failure <- function(fail){
  fail <- str_replace_all(fail, "[\t\n]" , "")
  fail <- str_replace_all(fail, "FAILUREREQUIRED","")
  fail <- str_replace_all(fail, "  ","")
  fail
}
 #all_fails <- vector(list)
  #for (i in 1:length(fail)){
   # all_fails <- paste(all_fails, fail[i]," ")
  }
# all_fails
}

clean_failure((failed2))


url<-"https://knb.ecoinformatics.org/view/doi:10.6085/AA/knb-lter-sbc.19.1"
remDr$navigate(url)
Sys.sleep(10) # give the page time to fully load
html <- remDr$getPageSource()[[1]]
page<-read_html(md_html)

#Extracting urls
urls<-(html_nodes(page,"a.route-to-metadata"))
urls <-html_attr(articles, "href")
md_id <-str_extract(urls, "doi.*")
md_id
#above from Aditi


test <- articles[25]
test <- sub(".*Knowledge Network for Biocomplexity.","",test)
test <- str_replace_all(test, " ","")
test <- gsub('.{1}$', '', test)
test

urlss = list()
append(urlss, "myurl")

grepl("Knowledge Network for Biocomplexity", articles_df[17,],fixed=TRUE)


#Only run once
rD <- rsDriver(browser="firefox", port=4798L, verbose=F)
remDr <- rD[["client"]]


master_urls <- list()
####Scraping urls from one data search page
get_KNB_urls <- function(search_page_url){
  remDr$navigate(search_page_url)
  Sys.sleep(10) # give the page time to fully load
  html <- remDr$getPageSource()[[1]]
  page <- read_html(html)
  articles<-(html_nodes(page,"a.route-to-metadata"))
  articles_cleaned <- html_text(articles)
  articles_df <- data.frame(articles_cleaned)
  urls <-html_attr(articles, "href")
  urls <- urls[(get_KNB_articles(articles_df))]
  urls
}

get_KNB_urls("https://knb.ecoinformatics.org/data")

url<-"https://knb.ecoinformatics.org/data"
remDr$navigate(url)
Sys.sleep(10) # give the page time to fully load
html <- remDr$getPageSource()[[1]]
page <- read_html(html)


articles<-(html_nodes(page,"a.route-to-metadata"))
articles_cleaned <- html_text(articles)
articles_df <- data.frame(articles_cleaned)
articles_df

all_urls <-html_attr(articles, "href")
knb_urls <- all_urls[(get_KNB_articles(articles_df))]
knb_urls

knb_urls_dt <-data.table(urls = knb_urls)
knb_urls_dt


get_KNB_article_indices <- function(article_df){
  article_indices = vector()
  for (i in 1:nrow(article_df)){
    if (grepl("Knowledge Network for Biocomplexity", article_df[i,],fixed=TRUE)){
      article_indices = append(article_indices, i)
    }
  }
  article_indices
}



##Trying to click to next page?
url<-"https://knb.ecoinformatics.org/data"
remDr$navigate(url)
Sys.sleep(10) # give the page time to fully load
html <- remDr$getPageSource()[[1]]
page <- read_html(html)

html <- remDr$getPageSource()[[1]]
page <- read_html(html)
articles<-(html_nodes(page,"a.route-to-metadata"))
articles_cleaned <- html_text(articles)
articles_df <- data.frame(articles_cleaned)
all_urls <-html_attr(articles, "href")
knb_urls <- all_urls[(get_KNB_article_indices(articles_df))]
knb_urls



final_urls <- list()
for (i in 1:122)
          {
            # find button
            nextpage <- remDr$findElement(using = 'css selector', "a#results_next_bottom")
            # click button
            nextpage$clickElement()
            # wait
            Sys.sleep(10)
            html <- remDr$getPageSource()[[1]]
            page <- read_html(html)
            articles<-(html_nodes(page,"a.route-to-metadata"))
            articles_cleaned <- html_text(articles)
            articles_df <- data.frame(articles_cleaned)
            all_urls <-html_attr(articles, "href")
            knb_urls <- all_urls[(get_KNB_article_indices(articles_df))]
            final_urls[[i]] <- knb_urls
         
          }

final_urls <- unlist(final_urls)
view(final_urls)


write.csv(final_urls, "08-18_last_KNB_URLS.csv")


KNB_articles <- read.csv("/Users/akileshramakrishna/UVA /DSPG/08-18_KNB_URLS.csv")
KNB_articles <- subset(KNB_articles, select=-c(X))
KNB_articles


KNB_2_articles <- read.csv("/Users/akileshramakrishna/UVA /DSPG/08-18_last_KNB_URLS.csv")
KNB_2_articles <- subset(KNB_2_articles, select=-c(X))
view(KNB_2_articles)

all_KNB_articles <- rbind(KNB_articles,KNB_2_articles)
write.csv(all_KNB_articles, "all_KNB_articles.csv")
