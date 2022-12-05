### TASK 4 ###

# A.

# We create a combined character string which contains all the pages' URLs in Beppe Grillo's "Archivo 2016" (there are 47 pages)
# The URL is "https://beppegrillo.it/category/archivio/2016/page/" and varies from page 1 to page 47

links_arc <- str_c("https://beppegrillo.it/category/archivio/2016/page/", 1:47)
links_arc

# Our function "DOWNLOAD", to download all the HTML pages of Beppe Grillo's "Archivio 2016"

library(httr)
library(htmltools)
library(rvest)

download_politely <- function(from_url, to_html, my_email, my_agent = R.Version()$version.string) {
  
  require(httr)
  
  stopifnot(is.character(from_url))
  stopifnot(is.character(to_html))
  stopifnot(is.character(my_email))     # Only character strings are allowed
  
  beppe_req <-httr::GET(url = links_arc[i],   # GET function for all the pages
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

# We use our customized function to download politely all HTML pages from the archive

dir.create("archivio2016")  # We store all the HTML file (47 files) in a new directory

for (i in seq_along(links_arc)) {
  cat(i, " ")
  download_politely(from_url = links_arc[i], 
                    to_html = here::here("archivio2016", str_c("page_",i,".html")), 
                    my_email = email)
  
  Sys.sleep(0.5)  # We use a sys.sleep of 5 seconds to avoid beign banned from the server
}

# Now that we have all our 47 HTML files we want R to be able to read these document and find them so we list them

to_scrape <- list.files(here::here("archivio2016"), full.names = TRUE)   # get the list of HTML pages
all_html_archivio2016 <- vector(mode = "list", length = length(to_scrape))    # empty container where to place the content (all pages' links)

for (i in seq_along(all_html_archivio2016)){
  all_html_archivio2016[[i]] = XML::getHTMLLinks(to_scrape[i], externalOnly = T)
                        
  Sys.sleep(0.5)              # We run a for loop to get all the HTML links in every page that we downloaded
}

all_html_archivio2016   # It works! Now we have a list with every link in every of the 47 downloaded HTML pages 

# Now we try to figure out the correct function (using Regular Expressions) to get
#only the links that redirects to other articles or post

print(all_html_archivio2016[[2]])  # To see which links are in the second page for example

blog="^https://beppegrillo\\.it/[^category].+[^jpg]$"   # We want links that redirect to other posts (exclude links that redirect to
prova47 = all_html_archivio2016[[1]] %>%                # the main page, categories of the website and images)
  str_subset(blog)
prova47 %>% 
  str_extract(all_html_archivio2016[[1]])

print(prova47)      # The links are right!

# Now we create the same function, but far all the pages in the "all_html_archivio2016" list (previously created)

all_html_chr = unlist(all_html_archivio2016) # From list to characters string with all the link of all the 47 pages

blog="^https://beppegrillo\\.it/[^category].+[^jpg]$"
links_47 = all_html_chr %>% 
  str_subset(blog)
links_47 %>% 
  str_extract(all_html_chr)

df_47_post = tibble(links_47)     # Now we put all the right links of all the 47 pages in a data frame (tibble) to be more readble

# We notice that the dataframe have repetitions and empty rows, so we clean
# "df_47_post" links/rows by removing duplicates and empty spaces

clean_df_47=distinct(df_47_post)

# B.

# Now we download the webpages for all the links contained in the cleaned dataframe ("clean_df_47")

download_politely_47 <- function(from_url, to_html, my_email, my_agent = R.Version()$version.string) {
  
  require(httr)
  
  stopifnot(is.character(from_url))
  stopifnot(is.character(to_html))
  stopifnot(is.character(my_email))
  
  get_pages <-httr::GET(url = unl_clean_df_47[i],       # we change the dataset containing the pages' URLs to be downloaded
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

# Now we download all the HTML pages, for each single post, and we put them in a new specific folder
# Using, again, a for loop

dir.create("Post archivio 2016")

unl_clean_df_47 <- unlist(clean_df_47)

for (i in seq_along(unl_clean_df_47)) {
  cat(i, " ")
  download_politely_47(from_url = unl_clean_df_47[i], 
                    to_html = here::here("Post archivio 2016", str_c("post_",i,".html")), 
                    my_email = email)
  
  Sys.sleep(0.5)
}

# C.

# Now we scrape the main text from all the articles that we have downloaded (363 HTML posts)

# To understand how to compose the function we make a first try just with
# the first article with ALL text/paragraphs

read_html(here::here("Post archivio 2016//post_1.html")) %>% 
  html_elements(css = "p") %>% 
  html_text(trim = TRUE)

# And for ONLY THE FIRST PARAGRAPH
read_html(here::here("Post archivio 2016//post_1.html")) %>% 
  html_elements(css = "p") %>% 
  html_text(trim = TRUE) %>% 
  head(1)    # Head(1) to show use only the first that popup in each HTML post

# They are correct!
# Now we do the same for all the articles we downloaded 

# For ALL text/paragraphs in the posts

library(dplyr)
library(rvest)
library(stringr)

scrape_363 <- list.files(here::here("Post archivio 2016"), pattern="*.html", full.names = TRUE)
main_text = lapply(scrape_363, function(x) {
  read = read_html(x) %>% 
    html_elements(css = "p") %>% 
    html_text(trim = TRUE)
})
# Create a large list with all 363 posts' MAIN TEXTS 

unl_text <- unlist(main_text) # We unlist the large list to get a character string with all the main paragraphs of all 363 posts

df_text = tibble(unl_text) # We put the large character string in a dataframe (tibble)

clean_df_text_all=distinct(df_text) # we clean "df_text" links/rows by removing duplicates and empty spaces


# for only the FIRST PARAGRAPH in each of the 363 posts

library(dplyr)
library(rvest)
library(stringr)

scrape_363 <- list.files(here::here("Post archivio 2016"), pattern="*.html", full.names = TRUE)
main_text_first = lapply(scrape_363, function(x) {
  read = read_html(x) %>% 
    html_elements(css = "p") %>% 
    html_text(trim = TRUE) %>% 
    head(1)
})
# Create a large list with all 363 posts' FIRST paragraph 

unl_text_first <- unlist(main_text_first) # We unlist the large list to get a character string with only the first paragraphs of all 363 posts

df_text_first = tibble(unl_text_first) # We put the character string in a dataframe (tibble)

clean_df_text_first=distinct(df_text_first)  # we clean "df_text_first" links/rows by removing duplicates and empty spaces




