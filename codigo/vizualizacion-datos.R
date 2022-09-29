# paquetes----
library(readr)
library(dplyr)
library(ggplot2)
library(forcats) #para variables de tipo factor (tipo caracter que
                 #yo defino ciertas categorias fijas)

# importar datos----

desarrollo = read_csv("datos/datos-desarrollo.csv")

#Gráfico 1 :  PIB de Chile----

desarrollo %>% 
  filter(pais == "Chile", anio >= 2000) %>% 
  ggplot(aes(x = anio, y = pib)) + 
  geom_line(color = "#79d0cc", size = 1) + 
  geom_point(color = "20b2aa", size = 2) +
  scale_y_continuous(limits = c(0,14000),
                     labels = scales::dollar) +
  labs(title = "Producto Interno Bruto (PIB) de Chile",
       subtitle = "período entre 2000 y 2020",
       y = "PIB en dólares",
       x = NULL,
       caption = "Elaboración propia a partir de los datos del Banco Mundial")+
  theme_bw()

# Guardar el gráfico con un comando

#guarda el último gráfico que está en plots

ggsave("figura/linea-pib-chile.png")

#Gráfico 2: Vamos a agregar más paises y miraremos otra variable----

colores_paises = c("Chile" = "green",
                   "Argentina" = "orange",
                   "Uruguay" = "red")
desarrollo %>% 
  filter(pais %in% c("Chile", "Argentina", "Uruguay")) %>% 
  ggplot(aes(x = anio, y = esperanza_vida, 
             color = fct_reorder2(pais, anio, esperanza_vida))) + 
  geom_line(size = 1) + 
  scale_y_continuous(limits = c(0, 85)) + 
  scale_x_continuous(breaks = seq(1960, 2020, 10)) + 
  scale_color_manual(values = colores_paises) + 
  labs(title = "Evolución de la esperanza de vida en Chile, Argentina
       y Uruguay",
       subtitle = "(1960-2020)",
       x = NULL,
       y = "Esperanza de vida",
       color = NULL) + #color hace referencia a la leyenda 
  theme_bw() + 
  theme(legend.position = "bottom")







