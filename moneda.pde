class Moneda {
  float x, y;
  float radio;
  float anguloGiro;

  Moneda(float xInicial, float yInicial) {
    this.x = xInicial;
    this.y = yInicial;
    this.radio = 10;
    this.anguloGiro = random(TWO_PI); 
  }

  void actualizar() {
    anguloGiro += 0.08; 
  }

  void dibujar() {
    pushStyle();
    ellipseMode(CENTER);
    noStroke();
    
    float escalaAncho = sin(anguloGiro);
    float anchoActual = radio * 2 * abs(escalaAncho);
    
    if (anchoActual < 2) anchoActual = 2;

    fill(218, 165, 32);
    ellipse(x, y, anchoActual + 4, radio * 2 + 4);

    fill(255, 223, 0);
    ellipse(x, y, anchoActual, radio * 2);

    fill(255, 255, 255, 200);
    ellipse(x - (anchoActual * 0.2), y - (radio * 0.4), anchoActual * 0.3, radio * 0.4);
    
    popStyle();
  }
}
