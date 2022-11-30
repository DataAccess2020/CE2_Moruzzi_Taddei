## PROVA RCURL ##

library(RCurl)

url <- "https://beppegrillo.it/un-mare-di-plastica-ci-sommergera/"
email <- "chiaramoruzzi@gmail.com"
agent <- R.Version()$version.string
user_id <- c(From = email, `User-Agent` = agent)
  
web_page <- RCurl::getURL(url, httpHEAD(user_id)













