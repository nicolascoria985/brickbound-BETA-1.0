class Enemigo {
  PVector pos;
  PVector vel;
  float radio;
  PImage imgSprite;
  float limiteIzquierdo;
  float limiteDerecho;

  Enemigo(Plataforma plat, float radio, PImage img) {
    this.radio = radio;
    imgSprite = img;
    pos = new PVector(plat.pos.x + plat.ancho / 2, plat.pos.y);
    vel = new PVector(1.5, 0);
    limiteIzquierdo = plat.pos.x + radio;
    limiteDerecho = plat.pos.x + plat.ancho - radio;
  }

  void actualizar() {
    pos.add(vel);

    if (pos.x <= limiteIzquierdo) {
      pos.x = limiteIzquierdo;
      vel.x *= -1;
    }
    if (pos.x >= limiteDerecho) {
      pos.x = limiteDerecho;
      vel.x *= -1;
    }
  }

  void dibujar() {
    image(imgSprite, pos.x - radio, pos.y - radio * 2, radio * 2, radio * 2);
  }
}

class EnemigoVolador extends Enemigo {
  float anguloFlotar = 0;
  float yOriginal;

  EnemigoVolador(Plataforma plat, float radio, PImage img) {
    super(plat, radio, img);
    pos.y -= 40;
    yOriginal = pos.y;
    vel.x = 2.0;
  }

  void actualizar() {
    super.actualizar();
    anguloFlotar += 0.05;
    pos.y = yOriginal + sin(anguloFlotar) * 30;
  }
}

class EnemigoDisparador extends Enemigo {
  int cronometroDisparo = 0;
  int tiempoEntreDisparos = 120;

  EnemigoDisparador(Plataforma plat, float radio, PImage img) {
    super(plat, radio, img);
    vel.x = 1.0;
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
    float dirDisparo = (vel.x > 0) ? 1 : -1;
    float origenX = pos.x + (dirDisparo * radio);
    float origenY = pos.y - radio;
    // Acá iría: listaProyectiles.add(new Proyectil(...));
  }
}
