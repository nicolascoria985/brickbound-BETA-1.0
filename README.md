15/10: se añadio una pantalla de inicio al juego, se cambio el nombre a "dark rebellion", se añadieron monedas (que por ahora no hacen nada)
nuevos enemigos como los aguja sombria y los fantasmas de fuego tambien se cargaron imagenes png para el personaje principal y los enemigos 
los enemigos ahora atacan 

17/10: se añadieron animaciones para el personaje principal (correr y saltar) y ahora las monedas tienen su propia textura (imagen png)

21/10 Commits realizados: se eliminaron varios archivos del repositorio, esto para evitar tener redundancias innecesarias y un mayor orden sobre los archivos, dejando unicamente los 2 Zip (el 1.0 siendo la version anterior, dejandola como registro)

27/10 Commit Realizado: Se actualiza "DARK_REBELLION_BETA-2-0.zip", dentro de ella, precisamente en el archivo general y en la clase jugador se ajustaron los atributos para una mejor optimizacion

30/10 se han detectado posibles optimizaciones sobre el codigo: 

-Pvector pos y vel (en todas las clases)
-Arreglar los this.
-Adaptar cualquier Metodo a los cambios hechos con Pvector

2/11 se agrego una tienda la cual es accesible desde la pantalla de inicio, la cual aun no tiene nada
- se cambio el sistema de vidas, pasamos de un texto monotono (vidas: 3) a un sistema que registra corazones en la pantalla y por cada golpe desaparece un corazon
- el personaje principal ya no puede disparar proyectiles
- -se optimizo el codigo, ahora no hay microcortes

5/11 Commit Realizado: Se optimizo la clase Enemigo, se aprovecha mucho mejor el concepto de herencia ahora. y se ha decidido modificar ciertas cosas dentro del programa general:
Consiste en borrar toda realizacion de diseño o imagen de forma nativa en Processing, y se propone a su vez reemplazarlo por carga de Imagenes del mismo, Ya sea menu, vida, Mapa, Etc.
