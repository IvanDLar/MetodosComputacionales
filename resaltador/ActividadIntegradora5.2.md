# Actividad Integradora 5.3
Implementación de métodos computacionales (Gpo 600)
## Tabla de contenidos

- [Integrantes del Equipo](#integrantes-del-equipo)
- [Paralelismo vs Secuencial](#paralelismo-vs-secuencial)
- [Complejidad del Algoritmo](#complejidad-del-algoritmo)
- [Conclusión](#conclusión)

## Integrantes del equipo

 - **Iván Díaz Lara** A01365801 
 - **OCtavio Fenollosa** A01781042


## Paralelismo vs Secuencial

Para esta segunda entre del resaltador de sintaxis, tuvimos que implementar una nueva funcionalidad, poder leer multiples archivos JSON encontrados dentro de una misma carpeta en una sola ejecucción.

Inicialmente implementamos nuestra solución de manera secuencial, es decir, el programa leia cada archivo de manera individual y lo procesaba uno por uno, lo cual hacía nuestro proyecto un tanto ineficiente.

Por lo tanto decidimos cambiar esta solución por una más eficiente, el paralelismo. Una vez implementando el algoritmo usando paralelismo pudimos ver resultados impresionantes, ya que en lugar de leer archivo por archivo, el programa tuvo acceso al poder de todos los threads disponibles del ordenador para asignar cada uno a un nuevo archivo, y así procesar multiples archivos al mismo tiempo.

Para comprobar la funcionalidad correcta de la nueva solución, hicimos algunas pruebas varíando el tamaño de los archivos jsons y también la cantidad de archivos dentro de la carpeta indicada.

### Large JSON files | 6 samples:
![](TestPictures\ParallelvsSecuencial_6Big_FileSearch.png)
### Small JSON files | 6 samples:
![](TestPictures\ParallelvsSecuencial_6Small_FileSearch.png)
### Large and Small JSON files | 6 small and 3 large samples:

## Complejidad del Algoritmo

En esta sección analisaremos las siguientes funciónes, las cuales buscan y alteran el contenido del archivo:
- ### Enum.map()
Tiene una complejidad linear (O(n)) ya que analiza cada elemento de la lista que se le transfiere.
- ### Regex.replace()
La funcion tiene que pasar por cada elemento que coincide con la expresión regular y reemplazarla por el valor indicado en el tercer atributo, por lo tanto podemos llegar a la conclusión de que tiene una complejidad linear (O(n)).

## Conclusión
Debido a que la función que nos regresa el resultado final es basicamente "Enum.map(Regex.replace())", podemos decir que la complejidad sería de O(n * m) donde:
- n: Numero de elementos de una lista 
- m: Conjuntos coincidentes dentro de cada elemento de la lista 
Sin embargo, la lista siempre tendrá un solo elemtento y la función se ejecuta multiples veces, por lo tanto tendremos que multiplicar el resultado pasado por N (numero de veces que se repite).

Finalmente llegamos a la complejidad real del algoritmo, la cual sería de (O(n)) * N.

No es el algorítmo mas eficiente, sin embargo la complejidad que nos regresa tampoco es catastrofica, como lo sería un algoritmo de complejidad O(n^2) por ejemplo.


