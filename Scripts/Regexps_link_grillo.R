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

df_links_beppe = tibble(beppe_link) #da tutti i link di beppegrillo.it DOBBIAMO SOLO POST NEL SENSO DI ARTICOLI???


#removes all the links that redirect to the main page but not exclusively to posts (???) -- several attempts

blog="^https://beppegrillo.it/.+"
links_post1 = all_link %>% 
  str_subset(blog)
links_post1 %>% 
  str_extract(all_link)

df_BG_posts1 = tibble(links_post1)


blog="^https://beppegrillo.it/.+-.+-.+"
links_post = all_link %>% 
  str_subset(blog)
links_post %>% 
  str_extract(all_link)

df_BG_posts = tibble(links_post)


#final result: removes jpg

blog="^https://beppegrillo\\.it/[^category].+[^jpg]$"
links_post2 = all_link %>% 
  str_subset(blog)
links_post2 %>% 
  str_extract(all_link)

df_BG_posts2 = tibble(links_post2)


#trying using another function

selected_links = str_view_all(all_link, pattern = "^https://beppegrillo\\.it/[^category].+")
sel_links_chr <- unlist(selected_links)



BG_POST <- str_extract_all(sel_links_chr, pattern = "^https://beppegrillo\\.it/[^category].+")

BG_POST <- unlist(all_link)

BG_POST_DF <- as.data.frame(sel_links_chr)


















