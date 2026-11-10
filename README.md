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

6/11: DARK REBELLION BETA 3.0, ahora el peronaje principal puede atacar a los enemigos (con un nuevo metodo atacar)
-se agrego un doble salto
-ahora el personaje NO puede matar a los enemigos saltando sobre ellos, si lo hace pierde una vida
-se mejoro drasticamente la pantalla de inicio, agregando por fin un boton de ayuda al usuario 

7/11: DARK REBELLION BETA 3.5, se implemento una pantalla de pausa donde se puede reanudar la partida, reiniciar la misma o volver al menu principal
-ahora el personaje puede hacer un dash, que lo hace inmune a los enemigos mientras este activado 

-Inicios del mapa: se importo el mapa a processing correctamente (aun sin que el jugador colisione con el mismo)

8/11: DARK REBELLION BETA 4.0, se mejoro drasticamente a los enemigos del juego, ahora persiguen al jugador al entrar en su campo de vision O dependiendo del enemigo se alejan para disparar proyectiles desde una distancia segura 
OTROS CAMBIOS MINIMOS
-musica de fondo (se esta intentando que suene solo en el menu principal
-mejora de animaciones del personaje principal 

9/11: DARK REBELLION BETA 4.5, se solucionaron algunos errores:
-uno que hacia que la musica de menu de inicio tambien suene en plena partida
-algunos comportamientos extraños en los enemigos 
se agrego un soundtrack especial para el nivel 1, se tiene pensado añadirle un soundtrack a cada nivel
se mejoraron los sprites de los enemigos, ahora no estan tan duros y cambian su sprite al atacar
se ajusto el golpe del personje principal para que tenga menos alcanze, esto evita abusos de alcanze 
-aguja sombria ahora lanza proyectiles, se alejara cuando el jugador se acerque a el manteniendo una "distancia segura", en este punto explico que corregi, especificamente que antes aguja sombria no hacia nada, ahora tiene este comportamiento de franco tirador aparte de la inclusion de los proyectiles 
