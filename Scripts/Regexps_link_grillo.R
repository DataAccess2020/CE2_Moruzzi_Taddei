# Use the regexp to take the links

library(stringr)
install.packages("XML")
library(dplyr)

str_view_all(all_link, pattern= "https://beppegrillo.it/")

link_beppe = str_view_all(all_link, pattern= "^https://beppegrillo.it/")

links_beppe = str_extract(str_view_all(all_link, pattern= "^https://beppegrillo.it/"))


blog="^https://beppegrillo.it/"
beppe_link = all_link %>% 
  str_subset(blog)
beppe_link %>% 
  str_extract(all_link)

df_links_beppe = tibble(beppe_link) #da tutti i link di beppegrillo.it DOBBIAMO SOLO POST NEL SENSO DI ARTICOLI???
