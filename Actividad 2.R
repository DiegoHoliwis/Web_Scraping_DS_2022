# Actividad número 2 - Selenium

library(tidyverse)
library(rvest)
library(RSelenium)

# Configuración inicial (siempre la misma)
system("taskkill /im java.exe /f", intern=FALSE, ignore.stdout=FALSE) # Se finalizan los procesos Java

driver <- RSelenium::rsDriver(browser = "chrome", 
                              chromever = "104.0.5112.79")
remote_driver <- driver[["client"]]

# Iniciamos el web scraping :D

# Conectamos a la página web
remote_driver$navigate("https://www.santander.cl/cotizador-web/")

MARCA    = 'JEEP'
MODELO   = 'RENEGADE'
RUT      = '24312997-4'
NOMBRE   = 'Diego Muñoz'
FechaN   = '10/01/1997'
SEXO     = 'Masculino'
EMAIL    = 'correo_generico@gmail.com'
TELEFONO = runif(1,900000000,999999999) %>% round(0) %>% as.character()

# Pagina 1 -----
# Seleccionar Marca

remote_driver$findElement(using = 'xpath',
                          value = '//select[@id = "marcas"]/option[@value = "78"]')$clickElement()









