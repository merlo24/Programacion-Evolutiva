Programación Evolutiva
================
Jorge Merlo
6/6/2021

Los métodos de búsqueda u optimización global utilizan procesos
aleatorios para generar modelos dentro del espacio de búsqueda completo.
Estos modelos son evaluados por medio de una función objetivo para
determinar su calidad como solución al problema.

Al tener la posibilidad de explorar cualquier punto del espacio de
búsqueda, reducen la tendencia de converger a un mínimo local y aumentan
la probabilidad de que la solución final corresponda a la solución
global del problema.

Dentro de los métodos de optimización global se encuentran los
algoritmos evolutivos que simulan los principios evolutivos de la
naturaleza para guiar su búsqueda hasta la solución óptima. La técnica
utilizada en el presente estudio para resolver el problema de
optimización se llama Programación Evolutiva (PE), cuyo diagrama de
flujo es presentado en la siguiente imagen

``` r
knitr::include_graphics("PE.PNG")
```

![](PE.PNG)<!-- -->

El propósito en este documento es implementar la PE para dar solución a
problemas de optimización. Se proporcionan funciones listas para ser
usadas y que pueden ser modificadas con facilidad. Para ello en la
siguiente sección definimos y encontramos el mínimo de la función de
Michalewicz.

## Óptimo de la función de Michalewickz

Definimos la función de Michalewickz en 2-D como función objetivo, de
esta manera el problema consiste en encontrar dentro del rango \[0, 3\]
los valores *x*<sub>1</sub> y *x*<sub>2</sub> tal que minimizen:

<!-- $f(x_1,x_2)= -(sin(x_1) \cdot (\frac{sin(x_1^2)}{\pi})^{2m} -(sin(x_2) \cdot (\frac{sin(x_2^2)}{\pi})^{2m})$ -->

``` r
knitr::include_graphics("Michalewicz.PNG")
```

![](Michalewicz.PNG)<!-- -->

que tiene un mínimo *f*(*x*<sub>1</sub>, *x*<sub>2</sub>) =  − 1.8013 en
(*x*<sub>1</sub>, *x*<sub>2</sub>) = (2.20, 1.57). Se utilizó una
población de 100 individuos y 100 generaciones para alcanzar el mínimo
global. La búsqueda de generación en generación para alcanzar el mínimo
global se resume en la siguiente animacion,

![Alt Text](mich_pe_animation.gif)
