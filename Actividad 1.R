# Workshop web scraping diplomado DS 2022 ' Secciones online
# Diego Muñoz

library(tidyverse)
library(rvest)

pagina <- read_html('https://www.mercadolibre.cl/ofertas?promotion_type=deal_of_the_day&container_id=MLC779365-1&page=1')

# Obtener el número de páginas de ofertas
N_pagina <- pagina %>% 
  html_element(xpath = '//ul[@class = "andes-pagination"]') %>% 
  html_children() %>% 
  html_text2() %>% 
  as.numeric() %>% 
  max(na.rm = TRUE) %>% 
  suppressWarnings()


# Obetner el titulo del producto
# Forma 1: solo obtiene el primer producto....
pagina %>% 
  html_element(xpath = '//p[@class = "promotion-item__title"]') %>% 
  html_text2()


# Forma 2: Complicada, obtiene todo...

1:48 %>% 
  map_chr(.f = function(x){
    pagina %>% 
      html_element(xpath = paste0('//ol[@class = "items_container"]/li[',x,']//p[@class = "promotion-item__title"]')) %>% 
      html_text2()
  } )

# Forma fácil
Nombre <- pagina %>% 
  html_elements(xpath = '//p[@class = "promotion-item__title"]') %>% 
  html_text2()

# Precio sin descuento

precio_old <- pagina %>% 
  html_elements(xpath = '//span[@class = "promotion-item__oldprice"]') %>% 
  html_text2() %>% 
  str_remove_all('\\$ ') %>% 
  str_remove_all('\\.') %>% 
  as.numeric()

# Precio con descuento

precio_nuevo <- pagina %>% 
  html_elements(xpath = '//span[@class = "promotion-item__price"]') %>% 
  html_text2() %>% 
  str_remove_all('\\$ ') %>% 
  str_remove_all('\\.') %>% 
  as.numeric()


# Envio gratis
# Intento 1 fallido

pagina %>%
  html_elements(xpath = ('//span[@class = "promotion-item__shipping"]')) %>%
  html_text2()

# Intento 2
Envio <- 1:length(Nombre) %>% 
  map_chr(.f = function(x){
    pagina %>% 
      html_element(xpath = paste0('//ol[@class = "items_container"]/li[',x,']//span[@class = "promotion-item__shipping"]')) %>% 
      html_text2() %>% 
      if_else(is.na(.),'Sin envio gratis',.)
  })




