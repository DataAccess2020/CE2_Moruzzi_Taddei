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
