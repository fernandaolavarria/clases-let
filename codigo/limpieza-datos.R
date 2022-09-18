# activacion paquetes----

library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)

# activacion datos----

#nos interesa solo la hoja que está en español

datos_paises = read_excel("datos/datos-sin-procesar/datos-paises.xlsx",
                          sheet = "ES")

#los demás archivos en las primeras 4 filas no tienen información, así que se
#empieza a leer desde la fila 5

esperanza_vida = read_csv("datos/datos-sin-procesar/esperanza-de-vida.csv",
                          skip = 4)
pib = read_csv("datos/datos-sin-procesar/pib.csv",
               skip = 4)
poblacion = read_csv("datos/datos-sin-procesar/poblacion.csv",
                     skip = 4)


# limpiar y ordenar los datos----

#Queremos transponer nuestras variables para comprimirlas en 3

names(esperanza_vida)
esperanza_vida = esperanza_vida %>% 
  pivot_longer(cols = "1960":"2020", 
               names_to = "anio",
               values_to = "esperanza_vida",
               names_transform = list(anio = as.integer))

pib = pib %>% 
  pivot_longer(cols = "1960":"2020", 
               names_to = "anio",
               values_to = "pib",
               names_transform = list(anio = as.integer))

poblacion = poblacion %>% 
  pivot_longer(cols = "1960":"2020", 
               names_to = "anio",
               values_to = "poblacion",
               names_transform = list(anio = as.integer)) %>% 
  mutate(poblacion = case_when(
    str_detect(poblacion, "M") ~ as.numeric(str_remove(poblacion, "M"))*1000000,
    str_detect(poblacion, "k") ~ as.numeric(str_remove(poblacion, "k"))*1000,
    str_detect(poblacion, "B") ~ as.numeric(str_remove(poblacion, "B"))*1000000000,
    TRUE ~ as.numeric(poblacion) #true es como decir "todo lo demas"
  ))

sum(is.na(poblacion)) #para ver si hay valores faltantes

# consolidar set de datos----

datos_desarrollo = esperanza_vida %>% 
  left_join(pib) %>% 
  left_join(poblacion) %>% 
  left_join(datos_paises)

# guardar los datos----

write_csv(datos_desarrollo,"datos/datos-desarrollo.csv")
