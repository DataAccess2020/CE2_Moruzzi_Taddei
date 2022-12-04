install.packages("RCurl")

library(RCurl)
require(httr)
library(tidyverse)


https://beppegrillo.it/un-mare-di-plastica-ci-sommergera/


download_politely <- function(from_url, to_html, my_email, my_agent = R.Version()$version.string) {
  
  require(RCurl)
  
  stopifnot(is.character(from_url))
  stopifnot(is.character(to_html))
  stopifnot(is.character(my_email))
  
  BG <- RCurl::getURL("https://www.vatican.va/content/vatican/it.html", from
                           From = chiaramoruzzi@gmail.com, 
                           `User-Agent` = R.Version()$version.string
                         )
  )
  if (httr::http_status(BG)$message == "Success: (200) OK") {
    bin <- content(BG, as = "raw")
    writeBin(object = bin, con = to_html)
  } else {
    cat("Houston, we have a problem!")
  }
}

download_politely(from_url = "https://www.vatican.va/content/vatican/it.html", 
                  to_html = here::here("prova.html"), 
                  my_email = "chiaramoruzzi@gmail.com")

# Extract the titles:
read_html(here::here("season_32_polite.html")) %>% 
  html_elements(css = "#episodes_content strong a") %>% 
  html_text(trim = TRUE)



BG <- RCurl::getURL("https://www.vatican.va/content/vatican/it.html", 
                    httpHEAD(
                      From = chiaramoruzzi@gmail.com, 
                      `User-Agent` = R.Version()$version.string
                    ))

#### prove for loop




for (i in seq_along(all_html_archivio2016[[i]]) {
  lapply (blog="^https://beppegrillo\\.it/[^category].+[^jpg]$",
          prova47 = all_html_archivio2016[[i]] %>% 
            str_subset(blog),
          prova47 %>% 
            str_extract(all_html_archivio2016[[i]]))
  Sys.sleep(0.5)
}

install.packages("rvest")
library(rvest)

links_47_archivio  <- sapply(all_html_archivio2016, function(x) {
  tryCatch({
    x %>%
      read_html() %>%
      html_nodes('.value:nth-child(8) .fixed') %>%
      html_text(trim = T) %>%
      read_html %>%
      html_nodes('p') %>%
      html_text(trim = T) %>%
      toString()
  }, error = function(e) NA)
})







