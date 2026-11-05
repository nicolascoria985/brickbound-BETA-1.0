class Jugador {
  PVector pos;
  PVector vel;
  float ancho, alto;
  
  int vidas;
  boolean invencible;
  int tiempoInvencible;
  
  float velocidadMaxima = 6;
  float aceleracion = 0.5;
  float friccion = 0.85;
  float impulsoSalto = -11.5;
  boolean enElSuelo;
  
  int direccion = 1; 
  
  boolean teclaIzquierda = false;
  boolean teclaDerecha = false;
  
  int cooldownDisparo = 0;      
  int cadenciaDisparo = 20;     
  
  // Animaciones eficientes (Asignadas por referencia)
  PImage imgIdle;
  PImage imgJump;
  PImage imgRunSprite; 
  int totalFotogramasCorrer = 3; 
  float frameActual = 0;
  float velocidadAnimacion = 0.2; 

  // Nuevo constructor optimizado
  Jugador(float xInicial, float yInicial, PImage idle, PImage jump, PImage run) {
    pos = new PVector(xInicial, yInicial);
    vel = new PVector(0, 0);
    ancho = 55;
    alto = 75;
    enElSuelo = false;
    
    vidas = 3;
    invencible = false;
    tiempoInvencible = 0;
    
    // Almacenamos las referencias de las imágenes ya cargadas
    imgIdle = idle;
    imgJump = jump;
    imgRunSprite = run; 
  }
  
  void actualizar(float gravedad) {
    if (teclaIzquierda) {
      vel.x -= aceleracion;
      direccion = -1; 
    } else if (teclaDerecha) {
      vel.x += aceleracion;
      direccion = 1;  
    } else {
      vel.x *= friccion; 
    }
    
    vel.x = constrain(vel.x, -velocidadMaxima, velocidadMaxima);
    pos.x += vel.x;
    
    if (pos.x < 0) { pos.x = 0; vel.x = 0; }
    
    vel.y += gravedad;
    vel.y = constrain(vel.y, -20, 15); 
    pos.y += vel.y;
    
    if (invencible) {
      tiempoInvencible--;
      if (tiempoInvencible <= 0) {
        invencible = false;
      }
    }
    
    if (cooldownDisparo > 0) {
      cooldownDisparo--;
    }
    
    if (enElSuelo && abs(vel.x) > 0.2) {
      frameActual += velocidadAnimacion;
      if (frameActual >= totalFotogramasCorrer) {
        frameActual = 0; 
      }
    } else {
      frameActual = 0; 
    }
  }
  
  // Limpieza: quitamos el parámetro fantasma que no se usaba
  void dibujar() {
    if (invencible && frameCount % 6 < 3) {
      return; 
    }
    
    PImage spriteActual = imgIdle; 
    
    if (!enElSuelo) {
      spriteActual = imgJump; 
    } else if (abs(vel.x) > 0.2) {
      spriteActual = imgRunSprite; // Usa el sprite de correr precargado
    }
    
    pushMatrix();
    
    if (spriteActual != null) {
      if (direccion == -1) {
        translate(pos.x + ancho, pos.y);
        scale(-1, 1);
        image(spriteActual, 0, 0, ancho, alto);
      } else {
        translate(pos.x, pos.y);
        image(spriteActual, 0, 0, ancho, alto);
      }
    } else {
      translate(pos.x, pos.y);
      fill(220, 50, 50); 
      stroke(0);
      strokeWeight(2);
      rect(0, 0, ancho, alto, 4);
    }
    
    popMatrix();
  }
  
  void saltar() {
    if (enElSuelo) {
      vel.y = impulsoSalto;
      enElSuelo = false;
    }
  }
  
  void verificarColisionSuelo(float sueloX, float sueloY, float sueloAncho) {
    if (pos.x + ancho > sueloX && pos.x < sueloX + sueloAncho) {
      if (vel.y >= 0 && pos.y + alto >= sueloY && pos.y + alto <= sueloY + vel.y + 4) {
        pos.y = sueloY - alto; 
        vel.y = 0;
        enElSuelo = true;
      }
    }
  }
  
  void recibirDano() {
    if (!invencible) {
      vidas--;
      invencible = true;
      tiempoInvencible = 60; 
      vel.y = -6; 
    }
  }
  
}
