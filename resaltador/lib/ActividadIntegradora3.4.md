# Actividad Integradora 3.4
Implementación de métodos computacionales (Gpo 600) 
## Table of contents

- [Integrantes del Equipo](#integrantes-del-equipo)
- [Estructura Léxica](#estructura-lexica)
- [Sintaxis de JSON](#sintaxis-json)
- [Solución Planteada](#solucion-planteada)
- [Complejidad del Algoritmo](#complejidad-del-algoritmo)
- [Conclusión](#conclusión)

## Integrantes del equipo

 - **Iván Díaz Lara** A01365801 
 - **OCtavio Fenollosa** A0


## Estructura Léxica

Para la primer entrega de la actividad integradora decidimos basar nuestro análisis en la estructura léxica de archivos tipo "JSON" los cuales están basados en el lenguaje de programación "JavaScript".

"JavaScript" está compuesto por las siguientes estructuras léxicas: 
- ### Literales
    Son valores que se escriben explícitamente, por ejemplo strings, números y booleanos.
- ### Identificadores
    Es una secuencia de carácteres que sirven para identificar una variable, una función, llaves o un objeto.
- ### Palabras clave reservadas
    Son palabras que no pueden ser usadas como identficadores
    Estos son algunos ejemplos de palabras reservadas:
    
            break
            do
            case
            else
            var
            return
            for
            this
            package
            while
            public
            class
    
- ### Whitespaces" y terminadores de linea
    JavaScript no concidera de manera significativa los espacios y/o cambios de línea como lo haría un lenguaje de programación tal como "Python". 
- ### Comentarios
    Existen 2 tipos de comentarios en JS:

        1.- /* */
        2.- //

    El primero puede cubrir múltiples líneas de código y es necesario cerrarlo para que su funcionamiento sea correcto.
    El segundo comenta absolutamente todo lo que se encuentre a su derecha; abarca solamente una línea de código.

## Sintaxis JSON
Podemos resumir la Sintaxis de los JSONS de la siguiente manera:
- Cada dato se constituye por un par llave/valor.
- Los datos se deben separar usando comas.
- Los objetos son conjuntos de datos, cuyos datos se definen colocándolos entre llaves {}.
- Los valores de dichos objetos pueden contener "arrays", estos se definen al colocar el valor dentro de los corchetes [].

## Solucion planteada

Tras analizar el lenguaje, el léxico y sintaxis determinamos que los siguientes puntos son los más importantes a identificar en un archivo JSON

- Llaves ({})
- Llaves de los objetos (nombre)
- Valores dentro del objeto
    - De tipo string
    - De tipo numérico 
    - De tipo booleano
    - Arrays
- Puntuación 
    - Dos puntos (:)
    - Punto y coma (;)
    - Coma (,)
- Espacios e Indentacion
    - \n
    - \t

Para poder encontrar las diferentes categorias léxicas dentro del archivo JSON implementamos el uso de múltiples Expresiones Regulares (RegEx).
Las expresiones regulares son básicamente una secuencia de carácteres las cuales conforman patrónes de búsqueda.

En esta ocasión usamos el lenguaje de programación funcional "Elixir", y a continuación les explicaré un poco sobre el funcionamiento del código que escribimos.

    def read_file(in_filename, out_filename) do
        
        text =
        in_filename
        |> File.stream!()

La función "read_file" toma el archivo JSON el cual a través del operador pipe (|>) pasa sus valores como atributo a la función "File.stream!()" la cual se encarga de insertar en una lista cada línea del archivo.

      |> Enum.map(&change_object_key/1)

Enseguida usamos la función "Enum.map()" la cual, de misma manera recibe como primer atributo la lista creada por "File.stream!()". 

Enum.map() toma en orden los valores de la lista que le fue transferida y aplica la función del segundo atributo sobre dicho valor. Es decir, a cada línea del archivo JSON le aplicará la función "change_object_key/1".

    defp change_object_key(line) do
        regex = ~r/\"([^\"]*)\"(?=\s*:)/
        Regex.replace(regex, line,
                    "<span class = 'object_key'> \\1 </span>")
    end

La expresión regex detectará **mapachi revisión** un conjunto que se encuentre entre parentesis que tenga delante de el dos puntos ( : ), el "match" de dicho regex no incluirá en la seleccion los parentesis.

La función "Regex.replace()" tiene una aridad de 3, donde tomará como primer atributo a regex, como segundo la linea a analizar (la cual recibe a través de Enum.map()) y cómo tercero el texto por el cual reemplazara los conjuntos detectados por el regex.

## Complejidad del Algoritmo

En esta sección analisaremos las siguientes funciónes, las cuales buscan y alteran el contenido del archivo:
- ### Enum.map()
Tiene una complejidad linear (O(n)) ya que analiza cada elemento de la lista que se le transfiere.
- ### Regex.replace()
La funcion tiene que pasar por cada elemento que coincide con la expresión regular y reemplazarla por el valor indicado en el tercer atributo, por lo tanto podemos llegar a la conclusión de que tiene una complejidad linear (O(n)).

## Conclusión
Debido a que la función que nos regresa el resultado final es basicamente "Enum.map(Regex.replace())", entonces podemos decir que la complejidad sería de O(n * m) donde:
- n: Numero de elementos de una lista 
- m: Conjuntos coincidentes dentro de cada elemento de la lista 
Sin embargo, la lista siempre tendrá un solo elemtento y la función se ejecuta multiples veces, por lo tanto tendremos que multiplicar el resultado pasado por N (numero de veces que se repite).

Finalmente llegamos a la complejidad real del algoritmo, la cual sería de (O(n)) * N.

No es el algorítmo mas eficiente, sin embargo la complejidad que nos regresa tampoco es catastrofica, como lo sería un algoritmo de complejidad O(n^2) por ejemplo.


