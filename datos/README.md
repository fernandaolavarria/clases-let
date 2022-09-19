#Datos

En esta carpeta se guardarán los datos que usemos en clases.

## datos-desarrollo.csv

Este set de datos contiene 7 variables:

| Variable         | Tipo     | Descripción                                                                                         |
|------------------|----------|-----------------------------------------------------------------------------------------------------|
| `pais`           | Caracter | Nombre del país                                                                                     |
| `anio`           | Numérica | Año de la observación (1960 a 2020)                                                                 |
| `esperanza_vida` | Numérica | Esperanza de vida al nacer en años                                                                  |
| `pib`            | Numérica | PIB per cápita en dólares (ajustados a dólares del 2015)                                            |
| `poblacion`      | Numérica | Población                                                                                           |
| `iso3`           | Caracter | Código ISO de 3 caracteres                                                                          |
| `continente`     | Caracter | El continente en que se encuentra el país. América del Norte, Centro y Sur aparecen como "Américas" |

Los datos fueron obtenidos del sitio del Banco Mundial en el caso de la variable `pib` y de la página del proyecto Gapminder en el caso de las variables `esperanza_vida` y `poblacion` . Los archivos utilizados se encuentran en la carpeta `/datos/datos-sin-procesar`.

El código utilizado para crear este set de datos se encuentra disponible en `/codigo/limpieza-datos.R`.
