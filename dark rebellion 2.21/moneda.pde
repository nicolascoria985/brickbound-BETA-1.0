class Moneda {
  PVector pos;
  float radio;
  float anguloGiro;
  PImage moneda;

  // Cambiado: Ahora el constructor recibe el sprite pre-cargado como parámetro
  Moneda(float xInicial, float yInicial, PImage spriteCargado) {
    pos = new PVector(xInicial, yInicial);
    radio = 12; 
    anguloGiro = random(TWO_PI); 
    moneda = spriteCargado; // Asignación directa desde la memoria RAM sin tirones
  }

  void actualizar() {
    anguloGiro += 0.08; 
  }

  void dibujar() {
    if (moneda != null) {
      pushStyle();
      imageMode(CENTER); 
      
      float escalaAncho = sin(anguloGiro);
      float anchoActual = radio * 2 * abs(escalaAncho);
      
      if (anchoActual < 2) anchoActual = 2; 
      
      image(moneda, pos.x, pos.y, anchoActual, radio * 2);
      popStyle();
    } else {
      pushStyle();
      ellipseMode(CENTER);
      noStroke();
      float escalaAncho = sin(anguloGiro);
      float anchoActual = radio * 2 * abs(escalaAncho);
      if (anchoActual < 2) anchoActual = 2;
      fill(218, 165, 32);
      ellipse(pos.x, pos.y, anchoActual + 4, radio * 2 + 4);
      fill(255, 223, 0);
      ellipse(pos.x, pos.y, anchoActual, radio * 2);
      popStyle();
    }
  }
}
