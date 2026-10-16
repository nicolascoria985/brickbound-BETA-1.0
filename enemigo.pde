class Enemigo {
  float x, y;
  float radio = 40;
  float velocidadX;
  PImage sprite;
  float limiteIzquierdo;
  float limiteDerecho;

  Enemigo(float xInicial, float yInicial, float radioInicial, float inicioPlat, float anchoPlat) {
    this.x = xInicial;
    this.y = yInicial;
    this.radio = radioInicial;
    this.velocidadX = 1.5; 
    this.limiteIzquierdo = inicioPlat + radio;
    this.limiteDerecho = inicioPlat + anchoPlat - radio;
    this.sprite = loadImage("enemigo(2).png");
  }
  
  void actualizar() {
    x += velocidadX;
    if (x <= limiteIzquierdo) {
      x = limiteIzquierdo;
      velocidadX *= -1;
    }
    if (x >= limiteDerecho) {
      x = limiteDerecho;
      velocidadX *= -1;
    }
  }
  
  void dibujar() {
    if (sprite != null) {
      pushStyle();
      imageMode(CORNER); 
      image(sprite, x - radio, y - radio * 2, radio * 2, radio * 2);
      popStyle();
    } else {
      fill(150, 0, 255);
      ellipse(x, y - radio, radio * 2, radio * 2);
    }
  }
}

class EnemigoVolador extends Enemigo {
  float anguloFlotar = 0;
  float yOriginal;

  EnemigoVolador(float xInicial, float yInicial, float radioInicial, float inicioPlat, float anchoPlat) {
    super(xInicial, yInicial - 40, radioInicial, inicioPlat, anchoPlat); 
    this.yOriginal = yInicial - 40;
    this.velocidadX = 2.0; 
    this.sprite = loadImage("fantasma.png");
  }

  void actualizar() {
    super.actualizar(); 
    anguloFlotar += 0.05;
    y = yOriginal + sin(anguloFlotar) * 30; 
  }

  void dibujar() {
    if (sprite != null) {
      pushStyle();
      imageMode(CORNER); 
      image(sprite, x - radio, y - radio * 2, radio * 2, radio * 2);
      popStyle();
    } else {
      pushStyle();
      fill(255, 0, 255);
      ellipse(x, y - radio, radio * 2, radio * 2);
      fill(255);
      ellipse(x - radio, y - radio - 5, 10, 10);
      ellipse(x + radio, y - radio - 5, 10, 10);
      popStyle();
    }
  }
}

class EnemigoDisparador extends Enemigo {
  int cronometroDisparo = 0;
  int tiempoEntreDisparos = 120; 

  EnemigoDisparador(float xInicial, float yInicial, float radioInicial, float inicioPlat, float anchoPlat) {
    super(xInicial, yInicial, radioInicial, inicioPlat, anchoPlat);
    this.velocidadX = 1.0; 
    this.sprite = loadImage("agujasombria.png");
  }

  void actualizar() {
    super.actualizar();
    cronometroDisparo++;
    if (cronometroDisparo >= tiempoEntreDisparos) {
      dispararProyectil();
      cronometroDisparo = 0;
    }
  }

  void dispararProyectil() {
    float dirDisparo = (velocidadX > 0) ? 1 : -1;
    float origenX = x + (dirDisparo * radio);
    float origenY = y - radio;
    listaProyectiles.add(new Proyectil(origenX, origenY, dirDisparo, "enemigo"));
  }

  void dibujar() {
    if (sprite != null) {
      pushStyle();
      imageMode(CORNER); 
      image(sprite, x - radio, y - radio * 2, radio * 2, radio * 2);
      popStyle();
    } else {
      pushStyle();
      fill(200, 50, 0);
      ellipse(x, y - radio, radio * 2, radio * 2);
      fill(50);
      float dirBoca = (velocidadX > 0) ? 8 : -8;
      rect(x + (dirBoca > 0 ? 0 : dirBoca), y - radio - 4, 8, 8);
      popStyle();
    }
  }
}
