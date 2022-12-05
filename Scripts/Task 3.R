### TASK 3 ###

#Get all links CODING
library(XML)
library(stringr)
library(tidyverse)
library(dplyr)

#To get all the link in the HTML that we download
url
all_link = XML::getHTMLLinks(web_page, externalOnly = T)

all_link

#Now we makle a data frame to collect all the links
df_links = tibble(all_link)

# Use the regexp to take the links

str_view_all(all_link, pattern= "https://beppegrillo.it/")

link_beppe = str_view_all(all_link, pattern = "^https://beppegrillo.it/")

links_beppe = str_extract(all_link, pattern = "^https://beppegrillo.it/")

blog="^https://beppegrillo.it/"
beppe_link = all_link %>% 
  str_subset(blog)
beppe_link %>% 
  str_extract(all_link)

df_links_beppe = tibble(beppe_link)

#removes all the links that redirect to the main page, categories and jpg

blog="^https://beppegrillo\\.it/[^category].+[^jpg]$"
links_post = all_link %>% 
  str_subset(blog)
links_post %>% 
  str_extract(all_link)

df_BG_posts = tibble(links_post)

# Clean the dataframe removing duplicates

clean_df_BG = distinct(df_BG_posts)

















