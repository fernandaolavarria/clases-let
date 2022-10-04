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

#VISUALIZACION 2-----
library(readr)
library(dplyr)
library(ggplot2)
library(ggtext) #para editar anotaciones y etiquetas
library(gghighlight) #para destacar valor en graficos

desarrollo = read_csv("datos/datos-desarrollo.csv")

#un subset de nuestros datos: los paises de Sudamerica

sudamerica = filter(desarrollo, pais %in% c("Chile", "Argentina","Paraguay",
                                            "Bolivia", "Perú", "Colombia",
                                            "Venezuela", "Brasil", "Suriname",
                                            "Guayana"))

#Cómo agregar etiquetas a los valores

sudamerica %>% 
  filter(anio == 2020) %>% 
  ggplot(aes(reorder(pais,-esperanza_vida), esperanza_vida)) +
  geom_col(fill = "pink3") + #colors() en consola para ver opciones 
  geom_text(aes(label = esperanza_vida),
            vjust = 1.2, #hjust para barras horizontales
            color = "white",
            fontface = "bold") + 
  labs(title = "Esperanza de vida en 2020",
       subtitle = "Paises de Sudamérica",
       x = NULL,
       y = "Esperanza de vida") +
  

sudamerica %>%#OPCION 2 SOLO RECORDATORIO
  filter(anio == 2020) %>% 
  ggplot(aes(reorder(pais,-esperanza_vida), esperanza_vida, fill = pais)) +
  geom_col() + #colors() en consola para ver opciones 
  labs(title = "Esperanza de vida en 2020",
       subtitle = "Paises de Sudamérica",
       x = NULL,
       y = "Esperanza de vida") 

#Destacar valores dentro de un gráfico

ggplot(sudamerica, aes(anio, pib, color = pais)) + 
  geom_line(size = 1)

ggplot(sudamerica, aes(anio, pib, color = pais)) + 
  geom_line(size = 1) + 
  gghighlight(pais == "Chile", #pais %in% c(pais1, pais2)
              unhighlighted_params = aes(color = "lightgreen") ) + 
  scale_color_manual(values = "darkgreen") +
  labs(title = "Comparación del PIB de Chile con el resto de Sudamérica")+
  theme_bw()

#Cómo anotar nuestros gráficos

desarrollo %>% 
  filter(pais == "Ruanda") %>% 
  ggplot(aes(anio, esperanza_vida)) + 
  geom_line(size = 1, color = "magenta4") +
  geom_label(aes(x = 1995, y = 10, label = "1993: Año del Genocidio \nde la población Tutsi"),
             hjust = -0.01,
             color = "white",
             fill = "magenta4",
             fontface = "bold") + 
  scale_y_continuous(limits = c(0,80)) + 
  scale_x_continuous(breaks = seq(1960,2020, by = 10))+
  labs(title = "Esperanza de vida en Ruanda",
       x = NULL,
       y = NULL) + 
  theme_bw()

#Cómo indicar a qué corresponde cada valor del gráfica (alternativa a la leyenda)

desarrollo %>% 
  filter(pais %in% c("Uruguay", "Argentina")) %>% 
  ggplot(aes(anio, pib, color = pais)) +
  geom_line(size = 1,
            show.legend = FALSE) + 
  scale_color_manual(values = c("Uruguay" = "#0081a7",
                                  "Argentina" = "#f07167")) + 
  labs(title = "Evolución del PIB en <b style=color:'#f07167'>Argentina</b> y <b style=color:'#0081a7'>Uruguay</b>")+
  theme_bw() + 
  theme(plot.title = element_markdown())















