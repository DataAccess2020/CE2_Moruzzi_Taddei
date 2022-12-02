## PROVA RCURL ##

library(RCurl)

url <- "https://beppegrillo.it/un-mare-di-plastica-ci-sommergera/"
email <- "icotaddei@gmail.com"
agent <- R.Version()$version.string
user_id <- c(From = email, `User-Agent` = agent)
  
web_page <- RCurl::getURL(url=url, httpheader= (user_id))

#it wasn't working like you write before, now I put url=... and httpheader= userid and closed with ")"
