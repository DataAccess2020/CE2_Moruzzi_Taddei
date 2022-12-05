### TASK 5 ###

# meaning of "crawl"

## to crawl in the field of computer science means to collect data from the Internet

# meaning of "web spider"

# web spiders, or web crawlers, are programs that collect large amounts 
# of data from the internet at the same time through hyperlinks methodically and 
# automatically by browsing and downloading web pages. when a web crawler is used 
# to simultaneously download web pages and extract data from them it is called a web scraper

# differences between web spider and scraping done in task 4

# In task 4 to scrape the beppegrillo.it blog we used web scraping tools inside of
# R, to do that we had to use specific R packages. the main difference is that we did 
# all the work inside the R environment. Another difference is that we had to 
# collect the URLs we needed manually, and then parse and extract data from those URLs. 
# Instead, incorporating the crawling process into R through the package Rcrawler 
# we could have automatically parsed and crawled all the URLs in a specific domain.


# functions to build a spider scraper + which arguments

install.packages("Rcrawler")
library (Rcrawler)

Rcrawler(Website = "https://beppegrillo.it/",
         DIR  = "C:\Users\chiar\Desktop\Università\DAPS&CO\DATA_ACCESS\CE2_Moruzzi_Taddei", 
         RequestsDelay = 1,       # similar to Sys.sleep()
         Obeyrobots = TRUE,       # follows the instructions given by the robots.txt (allowed/not allowed parts of the website to scrape)
         Useragent,               # gives information about the user
         use_proxy = NULL, 
         Encod,                   # detects the language used to program the website
         Timeout = 5,             # stops if the response doesn't come in the time specified (in this case 5 seconds)
         URLlenlimit = 255,       # sets maximum number of characters inside the URL (255 = default number)
         dataUrlfilter = "pattern",     # filters the parts to scrape using regular expressions
         crawlUrlfilter,                # filters the parts to crawl other URLs using regular expressions
         crawlZoneCSSPat = "p",         # works like SelectorGadget (with CSS)
         crawlZoneXPath = "pattern",         # works like SelectorGadget (with XPath)
         ignoreUrlParams,         # doesn't consider duplicates with same content but different URLs
         KeywordsFilter = c("keyword"),      # scrapes only pages which contain the keywords (must be a vector)
         KeywordsAccuracy,                   #  accuracy value is calculated using the number of matched keywords and their occurence
         FUNPageFilter,                 # filters the pages to scrape according to a specific function
         ExcludeXpathPat,               # excludes specific parts of the extracted content (using Xpath)
         ExcludeCSSPat,                 # excludes specific parts of the extracted content (using CSS)
         ExtractAsText = TRUE,          # removes HTML tags 
         ManyPerPattern = TRUE,         # if true, extracts all the parts which match the pattern; if false, just the first one
         saveOnDisk = TRUE,             # if true stores downloaded contents in a specific folder
         NetworkData = FALSE,           # if true, maps the hyperlinks in the website
         statslinks = FALSE,            # counts the number of input and output links of each crawled web page
         )

# this function contains all the steps for parsing and scraping a website:
# - get request
# - download HTML
# - scrape (extract contents through regular expressions)









































