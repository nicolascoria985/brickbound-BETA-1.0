void keyPressed() {
  if (estado == 0) {
    if (keyCode == ENTER || keyCode == RETURN) {
      reiniciarJuego();
    }
    return;
  }

  if (estado == 2) {
    if (key == 'r' || key == 'R') {
      reiniciarJuego();
    }
    return; 
  }

  if (keyCode == LEFT || key == 'a')  izquierda = true;
  if (keyCode == RIGHT || key == 'd') derecha = true;
  if (keyCode == UP || key == ' ')    heroe.saltar();
  
  if (key == 'z' || key == 'Z') {
    heroe.disparar(listaProyectiles);
  }
}

void keyReleased() {
  if (keyCode == LEFT || key == 'a')  izquierda = false;
  if (keyCode == RIGHT || key == 'd') derecha = false;
}
