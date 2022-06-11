# Resaltador

## Uso correcto

Para poder ejecutar correctamente el programa es necesario ingresar la funcion en el iex dentro de la carpeta de "/lib" con los siguientes comandos:


```elixir
1.- 
c("resaltador.ex")
2.-
#Leer un archivo en especifico
 Resaltador.read_file("<nombre_del_archivo_json_dentro_de_la_carpeta_SimpleTest>")

 #Leer multiples archivos dentro de la carpeta "SimpleTests"
 Resaltador.read_multi_file()

 #Leer multiples archivos en paralelo dentro de la carpeta "SimpleTests"
 Resaltador.read_multi_file_parallel()

 #Obtener el tiempo de ejecución 
 Resaltador.timer(fn -> Resaltador.read_multi_file_parallel)
```
