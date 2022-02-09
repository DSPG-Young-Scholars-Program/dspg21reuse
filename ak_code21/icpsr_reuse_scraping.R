##ICSPR
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


rD <- rsDriver(browser="firefox", port=4573L, verbose=F)
remDr <- rD[["client"]]
url<-"https://www.icpsr.umich.edu/web/ICPSR/search/studies?start=0&ARCHIVE=ICPSR&PUBLISH_STATUS=PUBLISHED&sort=NUMCITATIONS%20desc&rows=3000&q="
remDr$navigate(url)
Sys.sleep(30) # give the page time to fully load
html <- remDr$getPageSource()[[1]]
page <- read_html(html)
articles<-(html_nodes(page,"a"))
all_urls <-html_attr(articles, "href")
all_urls


key <- "https://www.icpsr.umich.edu/web/ICPSR/studies/"
grepl(key, all_urls[289], fixed = TRUE)
all_urls[289]

final_urls <- list()
for (i in 1:range(length(all_urls))){
  
  if (grepl("https://www.icpsr.umich.edu/web/ICPSR/studies/", all_urls[i], fixed = TRUE)){
    url <- all_urls[i]
    final_urls <- append(final_urls, url)
  }
  
}
final_urls <- unlist(final_urls)
view(final_urls)

write.csv(final_urls,"ICPSR_urls.csv")

#Using the ICPSR numbers appear to be working should be easy way to scrape them and tab to next page like in KNB, then just run this function on all


get_article_stats <- function(article_url){
 
  remDr$navigate(article_url)
  for (j in 1:10){
    Sys.sleep(1)
    html <- remDr$getPageSource()[[1]]
    page<-read_html(html)
    
    #downloads & related publications
    usage_metrics <-html_nodes(page,"div#studyMetrics")
    
    if(length(usage_metrics)==0){next}
    
    #downloads & related publications
    usage_metrics <-html_nodes(page,"div#studyMetrics")
    usage_metrics <- html_text(usage_metrics)
    downloads <- sub("Downloads.*", "", usage_metrics)
    downloads <- sub(",","",downloads)
    downloads <- as.numeric(downloads)
    downloads
    publications <- sub(".*past three years", "", usage_metrics)
    publications <- sub("Data.*","",publications)
    publications <- sub(",","",publications)
    publications <- as.numeric(publications)
    publications
    
    
    #Unique DOI
    doi <-html_nodes(page,"p.doi")
    doi <- html_text(doi)
    doi
    
    #Principal Investigator(s)
    pi <-html_nodes(page,"p.p-i")
    pi <- html_text(pi)
    p_key <- ".*View help for Principal Investigator"
    pi <- sub(p_key,"",pi)
    pi <- str_replace_all(pi, "[()]","")
    pi <- str_replace_all(pi, "[\t\n]","")
    pi <- sub('.', '', pi)
    pi
    
    
    #Version- may need to filter data table at end, not labeled in the html
    version <- html_nodes(page,"p")
    version <- html_text(version)
    version <- version[10]
    version <- str_replace_all(version,"[\t\n]","")
    version <- regmatches(version, gregexpr("[[:digit:]]+", version)) 
    version <- as.numeric(version[[1]][1])
    version
    
    
    #Funding Agency
    funder <- html_nodes(page, "div.panel-body")
    funder <- html_text(funder)
    funder <- str_replace_all(funder[1], "[\t\n]" , "")
    f <- ".*View help for Funding"
    funder <- sub(f, "", funder)
    s <- "Subject Terms.*"
    funder <- sub(s, "",funder)
    funder <- str_replace_all(funder, "  " , "")
    funder
    
    
    if(length(usage_metrics)!=0){break}
  }
  dt <- data.table(articleid, doi, downloads, publications, pi, version, funder)
  dt
}


get_article_stats(7010)


#File name & size
size_metrics <- html_nodes(page, "table#data-doc.table.table-striped")
size_metrics <- html_text(size_metrics)
size_metrics



#Methodology
methodology <- html_nodes(page, "div.panel-body")
methodology <- html_text(methodology)
methodology <- str_replace_all(methodology[3], "[\t\n]" , "")
methodology <-str_replace_all(methodology, " " , "")
methodology

#https://www.icpsr.umich.edu/web/ICPSR/studies/4373
#https://pcms.icpsr.umich.edu/pcms/reports/studies/4373/utilization



