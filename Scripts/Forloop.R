#Punto 4 a) get all link ìs on the 47 pages (archivio 2016)

# OUR FUNCTION DOWNLOAD
download_politely <- function(from_url, to_html, my_email, my_agent = R.Version()$version.string) {
  
  require(httr)
  
  stopifnot(is.character(from_url))
  stopifnot(is.character(to_html))
  stopifnot(is.character(my_email))
  
  beppe_req <-httr::GET(url = links_arc[i], 
                        add_headers(
                          From = email, 
                          `User-Agent` = R.Version()$version.string
                        )
  )
  
  if (httr::http_status(beppe_req)$message == "Success: (200) OK") {
    bin <- content(beppe_req, as = "raw")
    writeBin(object = bin, con = to_html)
  } else {
    cat("Houston, we have a problem!")
  }
}

# DOWNLOAD POLITELY STIAMO SCARICANDO LE PAGINE HTML DELL'ARCHIVIO DA PAG 1 A PAG 47
links_arc <- str_c("https://beppegrillo.it/category/archivio/2016/page/", 1:47)
links_arc
dir.create("archivio2016")

for (i in seq_along(links_arc)) {
  cat(i, " ")
  download_politely(from_url = links_arc[i], 
                    to_html = here::here("archivio2016", str_c("page_",i,".html")), 
                    my_email = email)
  
  Sys.sleep(0.5)
}

################
#COSì NELLA LISTA ABBIAMO TUTTI I LINK DI OGNI PAGINA
to_scrape <- list.files(here::here("archivio2016"), full.names = TRUE)   # get the list of pages for the seasons
all_html_archivio2016 <- vector(mode = "list", length = length(to_scrape))    # empty container where to place the titles

for (i in seq_along(all_html_archivio2016)){
  all_html_archivio2016[[i]] = XML::getHTMLLinks(to_scrape[i], externalOnly = T)
                        
  Sys.sleep(0.5)
}

all_html_archivio2016

##############################

#Prova per link giusti ai post per pag2
print(all_html_archivio2016[[2]])

blog="^https://beppegrillo\\.it/[^category].+[^jpg]$"
prova47 = all_html_archivio2016[[1]] %>% 
  str_subset(blog)
prova47 %>% 
  str_extract(all_html_archivio2016[[1]])

print(prova47) # I LINK SONO OK GIUSTI
###########################

# CREARE STESSA FUNZIONE  PER TUTTE LE PAGINE NELLA LISTA all_html_archivio2016 

all_html_chr = unlist(all_html_archivio2016) #From list to characters 

blog="^https://beppegrillo\\.it/[^category].+[^jpg]$"
links_47 = all_html_chr %>% 
  str_subset(blog)
links_47 %>% 
  str_extract(all_html_chr)

df_47_post = tibble(links_47) #ALL LINKS FOR ALL THE POST IN ARCHIVIO 2016 IN DATAFRAME

########################
#Clean all 47 df link removing duplicates
clean_df_47=distinct(df_47_post)


## now we download the webpages for all the links

download_politely_47 <- function(from_url, to_html, my_email, my_agent = R.Version()$version.string) {
  
  require(httr)
  
  stopifnot(is.character(from_url))
  stopifnot(is.character(to_html))
  stopifnot(is.character(my_email))
  
  get_pages <-httr::GET(url = unl_clean_df_47[i], 
                        add_headers(
                          From = email, 
                          `User-Agent` = R.Version()$version.string
                        )
  )
  
  if (httr::http_status(get_pages)$message == "Success: (200) OK") {
    bin <- content(get_pages, as = "raw")
    writeBin(object = bin, con = to_html)
  } else {
    cat("Houston, we have a problem!")
  }
}

#now we download all the html pages for each single post and we put them in a new specific folder

dir.create("Post archivio 2016")

unl_clean_df_47 <- unlist(clean_df_47)

for (i in seq_along(unl_clean_df_47)) {
  cat(i, " ")
  download_politely_47(from_url = unl_clean_df_47[i], 
                    to_html = here::here("Post archivio 2016", str_c("post_",i,".html")), 
                    my_email = email)
  
  Sys.sleep(0.5)
}

#now we scrape the main text from all the articles

library(httr)
library(htmltools)
library(rvest)

#first try just with the first article

read_html(here::here("Post archivio 2016//post_1.html")) %>% 
  html_elements(css = "p") %>% 
  html_text(trim = TRUE)

#now we do the same for all the articles

for (i in seq_along("Post archivio 2016")) {
  cat(i, " ")
  read_html(here::here("Post archivio 2016//post_"[i])) %>% 
    html_elements(css = "p") %>% 
    html_text(trim = TRUE)
  
  Sys.sleep(0.5)
}












