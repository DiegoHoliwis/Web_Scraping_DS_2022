# Actividad número 2 - Selenium

library(tidyverse)
library(rvest)
library(RSelenium)

system("taskkill /im java.exe /f", intern=FALSE, ignore.stdout=FALSE) # Se finalizan los procesos Java

driver <- RSelenium::rsDriver(browser = "chrome", 
                              chromever = "104.0.5112.79")
remote_driver <- driver[["client"]]
