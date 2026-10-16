class Proyectil {
  float x, y;
  float velX;
  float radio;
  String bando; // "jugador" o "enemigo"
  color colorProyectil;

  // Constructor
  Proyectil(float xInicial, float yInicial, float dir, String bandoOrigen) {
    this.x = xInicial;
    this.y = yInicial;
    this.bando = bandoOrigen;
    this.radio = 6; // Tamaño del proyectil

    // Si va a la derecha dir es 1, si va a la izquierda es -1
    // Ajustamos la velocidad según quién dispara (ej: el jugador dispara más rápido)
    if (this.bando.equals("jugador")) {
      this.velX = dir * 10; 
      this.colorProyectil = color(255, 69, 0); // Fuego naranja para Mario
    } else {
      this.velX = dir * 4; 
      this.colorProyectil = color(150, 0, 255); // Morado oscuro para los enemigos
    }
  }

  // Actualiza la posición del proyectil
  void actualizar() {
    x += velX;
  }

  // Dibuja el proyectil en el mapa
  void dibujar() {
    pushStyle();
    noStroke();
    
    // Efecto de brillo/aura sutil
    fill(colorProyectil, 100);
    ellipse(x, y, radio * 2.5, radio * 2.5);
    
    // Centro del proyectil
    fill(colorProyectil);
    ellipse(x, y, radio * 2, radio * 2);
    
    popStyle();
  }
}
