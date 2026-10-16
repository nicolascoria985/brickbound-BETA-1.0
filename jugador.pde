class Jugador {
  float x, y;
  float ancho, alto;
  float velX, velY;
  int vidas;
  boolean invencible;
  int tiempoInvencible; 
  
  // --- PROPIEDADES DE ATAQUE ---
  int cooldownDisparo = 0;      // Contador para regular la velocidad de disparo
  int cadenciaDisparo = 20;     // Cuántos fotogramas hay que esperar entre disparos (aprox. 1/3 de segundo)

  float velocidadMaxima = 6;
  float aceleracion = 0.5;
  float friccion = 0.85;
  float impulsoSalto = -11.5;
  boolean enElSuelo;
  

  int direccion = 1; 
  

  boolean teclaIzquierda = false;
  boolean teclaDerecha = false;
  

  Jugador(float xInicial, float yInicial) {
    x = xInicial;
    y = yInicial;
    

    ancho = 40;
    alto = 55;
    
    velX = 0;
    velY = 0;
    enElSuelo = false;
    

    this.vidas = 3;
    this.invencible = false;
    this.tiempoInvencible = 0;
  }
  

  void actualizar(float gravedad) {
    if (teclaIzquierda) {
      velX -= aceleracion;
      direccion = -1; 
    } else if (teclaDerecha) {
      velX += aceleracion;
      direccion = 1; 
    } else {
      velX *= friccion; 
    }
    
    velX = constrain(velX, -velocidadMaxima, velocidadMaxima);
    x += velX;
    
    if (x < 0) {
      x = 0;
      velX = 0;
    }
    
    velY += gravedad;
    velY = constrain(velY, -20, 15); 
    y += velY;
    
    if (invencible) {
      tiempoInvencible--;
      if (tiempoInvencible <= 0) {
        invencible = false;
      }
    }
        // Reducir el tiempo de espera del disparo si está activo
    if (cooldownDisparo > 0) {
      cooldownDisparo--;
    }

  }
  

  void dibujar(PImage img) {
    if (invencible && frameCount % 6 < 3) {
      return; 
    }
    
    pushMatrix();
    
    if (img != null) {
      if (direccion == -1) {
        translate(x + ancho, y);
        scale(-1, 1);
        image(img, 0, 0, ancho, alto);
      } else {
        translate(x, y);
        image(img, 0, 0, ancho, alto);
      }
    } else {
      translate(x, y);
      fill(220, 50, 50); 
      stroke(0);
      strokeWeight(2);
      rect(0, 0, ancho, alto, 4);
    }
    
    popMatrix();
  }
  
  void saltar() {
    if (enElSuelo) {
      velY = impulsoSalto;
      enElSuelo = false;
    }
  }
  

  void verificarColisionSuelo(float sueloX, float sueloY, float sueloAncho) {
    if (x + ancho > sueloX && x < sueloX + sueloAncho) {
      if (velY >= 0 && y + alto >= sueloY && y + alto <= sueloY + velY + 4) {
        y = sueloY - alto; 
        velY = 0;
        enElSuelo = true;
      }
    }
  }
  
  void recibirDano() {
    if (!invencible) {
      vidas--;
      invencible = true;
      tiempoInvencible = 60; 
      velY = -6; 
    }
  }
  
    // Método para crear un proyectil y meterlo al ecosistema del juego
  void disparar(ArrayList<Proyectil> lista) {
    // Solo dispara si ya pasó el tiempo de espera (cooldown)
    if (cooldownDisparo == 0) {
      // El proyectil nace a la altura de las manos de Mario (y + alto/2)
      // Usamos la variable 'direccion' (1 o -1) para saber hacia dónde va
      float origenX = (direccion == 1) ? (x + ancho) : x;
      float origenY = y + (alto / 2);
      
      // Creamos el proyectil indicando que pertenece al bando del jugador
      Proyectil nuevoProyectil = new Proyectil(origenX, origenY, direccion, "jugador");
      lista.add(nuevoProyectil);
      
      // Activamos el cooldown para bloquear el próximo disparo temporalmente
      cooldownDisparo = cadenciaDisparo;
    }
  }

}
