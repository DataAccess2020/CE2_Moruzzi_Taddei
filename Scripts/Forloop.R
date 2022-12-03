#Punto 4 a) get all link ìs on the 47 pages (archivio 2016)

# OUR FUNCTION DOWNLOAD
download_politely <- function(from_url, to_html, my_email, my_agent = R.Version()$version.string) {
  
  require(httr)
  
  # Check that arguments are inputted as expected:
  stopifnot(is.character(from_url))
  stopifnot(is.character(to_html))
  stopifnot(is.character(my_email))
  
  # GET politely
  beppe_req <-httr::GET(url = links_arc[i], 
                        add_headers(
                          From = email, 
                          `User-Agent` = R.Version()$version.string
                        )
  )
  # If status == 200, extract content and save to a file:
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
  
  Sys.sleep(2)
}

################
#COSì NELLA LISTA ABBIAMO TUTTI I LINK DI OGNI PAGINA
to_scrape <- list.files(here::here("archivio2016"), full.names = TRUE)   # get the list of pages for the seasons
all_html_archivio2016 <- vector(mode = "list", length = length(to_scrape))    # empty container where to place the titles

for (i in seq_along(all_html_archivio2016)){
  all_html_archivio2016[[i]] = XML::getHTMLLinks(to_scrape[i], externalOnly = T)
                        
  Sys.sleep(0.5)
}
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

# CREARE FOR LOOP PER TUTTE LE PAGINE NELLA LISTA all_html_archivio2016 ????

blog="^https://beppegrillo\\.it/[^category].+[^jpg]$"

for (i in seq_along(all_html_archivio2016[[i]])){
  all_links_47 [[i]] = all_html_archivio2016[[i]] %>% 
    str_subset(blog)
  all_links_47[[i]] %>% 
    str_extract(all_html_archivio2016[[i]])
  
  Sys.sleep(0.5)
}

print(all_links_47)
