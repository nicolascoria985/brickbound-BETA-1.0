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

  // Controles de juego activo (Solo se ejecutan si estado == 1)
  if (estado == 1) {
    if (keyCode == LEFT  || key == 'a' || key == 'A') heroe.teclaIzquierda = true;
    if (keyCode == RIGHT || key == 'd' || key == 'D') heroe.teclaDerecha = true;
    if (keyCode == UP    || key == 'w' || key == 'W' || key == ' ') heroe.saltar();
    
  }
}

void keyReleased() {
  if (estado == 1) {
    if (keyCode == LEFT  || key == 'a' || key == 'A') heroe.teclaIzquierda = false;
    if (keyCode == RIGHT || key == 'd' || key == 'D') heroe.teclaDerecha = false;
  }
}
