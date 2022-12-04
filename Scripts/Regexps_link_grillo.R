# Use the regexp to take the links

library(stringr)
library (XML)
library(tidyverse)

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

# Clean the df removing duplicates

clean_df_BG = distinct(df_BG_posts)

















