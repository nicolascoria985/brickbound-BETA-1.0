import java.util.ArrayList;

ArrayList<Plataforma> listaPlataformas = new ArrayList<Plataforma>(); 
ArrayList<Enemigo> listaEnemigos = new ArrayList<Enemigo>(); 
ArrayList<Proyectil> listaProyectiles = new ArrayList<Proyectil>();
ArrayList<Moneda> listaMonedas = new ArrayList<Moneda>();

float proximaPlataformaX = 400; 

Jugador heroe;
PImage imgMario;
float gravedad = 0.4;

float camaraX = 0; 
float anchoSuelo = 400;
float anchoNubeBucle = 300;

boolean izquierda = false;
boolean derecha = false;

int estado = 0; 
int monedasRecolectadas = 0;
float camaraMenuNubes = 0;

void setup() {
  size(800, 600);
  imgMario = loadImage("mario sprite.png");
  reiniciarJuego();
  estado = 0; 
}

void draw() {
  background(135, 206, 235); 
  
  if (estado == 0) {
    dibujarMenuInicio();
  } else {
    dibujarJuego();
  }
}

void dibujarMenuInicio() {
  camaraMenuNubes += 0.5;
  int nubeInicio = floor(camaraMenuNubes / anchoNubeBucle);
  int nubesVisibles = ceil(width / anchoNubeBucle) + 1;
  
  pushMatrix();
  translate(-camaraMenuNubes, 0);
  fill(255, 255, 255, 200);
  noStroke();
  for (int i = nubeInicio; i <= nubeInicio + nubesVisibles; i++) {
    float nubeX = i * anchoNubeBucle;
    ellipse(nubeX + 50,  100, 60, 50);
    ellipse(nubeX + 80,  90,  80, 60);
    ellipse(nubeX + 110, 100, 60, 50);
    ellipse(nubeX + 200, 150, 70, 45);
    ellipse(nubeX + 230, 145, 90, 55);
  }
  popMatrix();
  
  fill(34, 139, 34);
  stroke(0);
  strokeWeight(2);
  rect(0, 500, width, 100);
  
  textAlign(CENTER, CENTER);
  
  fill(0, 0, 0, 50);
  textSize(64);
  text("BRICKBOUND", width / 2 + 4, height / 3 + 4);
  
  
  
  strokeWeight(1);
  stroke(0);
  
  if (frameCount % 60 < 40) {
    fill(255);
    textSize(22);
    text("PRESIONA ENTER PARA EMPEZAR", width / 2, height / 2 + 60);
  }
  
  fill(255, 255, 255, 150);
  rect(width / 2 - 180, height / 2 + 120, 360, 90, 10);
  
  fill(50);
  textSize(14);
  text("CONTROLES", width / 2, height / 2 + 135);
  text("A / D o Flechas: Moverse", width / 2, height / 2 + 155);
  text("Espacio o Flecha Arriba: Saltar  |  Z: Disparar", width / 2, height / 2 + 175);
  
  textAlign(LEFT, BASELINE);
}

void dibujarJuego() {
  if (estado == 1) {
    heroe.teclaIzquierda = izquierda;
    heroe.teclaDerecha = derecha;
    heroe.actualizar(gravedad);
   
    if (heroe.x > width / 2) {
      camaraX = heroe.x - width / 2;
    }
    
    if (heroe.y > height + 100) {
      heroe.vidas = 0; 
    }
    
    if (heroe.vidas <= 0) {
      estado = 2;
    }
  } else {
    heroe.teclaIzquierda = false;
    heroe.teclaDerecha = false;
  }
  
  float camaraNubes = camaraX * 0.3;
  int nubeInicio = floor(camaraNubes / anchoNubeBucle);
  int nubesVisibles = ceil(width / anchoNubeBucle) + 1;
  
  pushMatrix();
  translate(-camaraNubes, 0);
  fill(255, 255, 255, 200);
  noStroke();
  for (int i = nubeInicio; i <= nubeInicio + nubesVisibles; i++) {
    float nubeX = i * anchoNubeBucle;
    ellipse(nubeX + 50,  100, 60, 50);
    ellipse(nubeX + 80,  90,  80, 60);
    ellipse(nubeX + 110, 100, 60, 50);
    ellipse(nubeX + 200, 150, 70, 45);
    ellipse(nubeX + 230, 145, 90, 55);
  }
  popMatrix();
  stroke(0);
  
  heroe.enElSuelo = false; 
  int bloqueInicio = floor(camaraX / anchoSuelo);
  int bloquesVisibles = ceil(width / anchoSuelo) + 1;
  
  pushMatrix();
  translate(-camaraX, 0);
  
  fill(34, 139, 34); 
  for (int i = bloqueInicio; i <= bloqueInicio + bloquesVisibles; i++) {
    float sueloX = i * anchoSuelo;
    float sueloY = 500;
    float sueloAlto = 100;
    
    rect(sueloX, sueloY, anchoSuelo, sueloAlto);
    heroe.verificarColisionSuelo(sueloX, sueloY, anchoSuelo);
  }
  
  for (int i = listaPlataformas.size() - 1; i >= 0; i--) {
    Plataforma plat = listaPlataformas.get(i);
    plat.mostrar(); 
    
    heroe.verificarColisionSuelo(plat.pos.x, plat.pos.y, plat.ancho);
    
    if (estado == 1 && plat.pos.x < camaraX - 200) {
      listaPlataformas.remove(i);
    }
  }
  
  for (int i = listaEnemigos.size() - 1; i >= 0; i--) {
    Enemigo ene = listaEnemigos.get(i);
    
    if (estado == 1) {
      ene.actualizar();
    }
    ene.dibujar();
    
    if (estado == 1) {
      float marioCentroX = heroe.x + (heroe.ancho / 2);
      float marioCentroY = heroe.y + (heroe.alto / 2);
      
      float distancia = dist(marioCentroX, marioCentroY, ene.x, ene.y);
      float radioMario = heroe.ancho / 2; 
      
      if (distancia < (radioMario + ene.radio)) {
        if (heroe.velY > 0 && (heroe.y + heroe.alto) < ene.y + 10) {
          listaEnemigos.remove(i); 
          heroe.velY = -9;         
          heroe.enElSuelo = false;
        } else {
          heroe.recibirDano(); 
        }
      }
      else if (ene.x < camaraX - 200) {
        listaEnemigos.remove(i);
      }
    }
  }
  
  for (int i = listaProyectiles.size() - 1; i >= 0; i--) {
    Proyectil p = listaProyectiles.get(i);
    
    if (estado == 1) {
      p.actualizar();
    }
    p.dibujar();
    
    if (p.bando.equals("jugador")) {
      for (int j = listaEnemigos.size() - 1; j >= 0; j--) {
        Enemigo ene = listaEnemigos.get(j);
        
        float distBalaEnemigo = dist(p.x, p.y, ene.x, ene.y);
        if (distBalaEnemigo < (p.radio + ene.radio)) {
          listaEnemigos.remove(j);     
          listaProyectiles.remove(i);  
          break;                       
        }
      }
    } 
    else if (p.bando.equals("enemigo") && estado == 1) {
      float marioCentroX = heroe.x + (heroe.ancho / 2);
      float marioCentroY = heroe.y + (heroe.alto / 2);
      float distBalaMario = dist(p.x, p.y, marioCentroX, marioCentroY);
      
      if (distBalaMario < (p.radio + (heroe.ancho / 2))) {
        heroe.recibirDano();         
        listaProyectiles.remove(i);  
        continue;                    
      }
    }
    
    if (i < listaProyectiles.size()) { 
      if (p.x < camaraX - 100 || p.x > camaraX + width + 100) {
        listaProyectiles.remove(i);
      }
    }
  }

  for (int i = listaMonedas.size() - 1; i >= 0; i--) {
    Moneda m = listaMonedas.get(i);
    
    if (estado == 1) {
      m.actualizar();
    }
    m.dibujar();
    
    if (estado == 1) {
      float marioCentroX = heroe.x + (heroe.ancho / 2);
      float marioCentroY = heroe.y + (heroe.alto / 2);
      float distMarioMoneda = dist(marioCentroX, marioCentroY, m.x, m.y);
      float radioMario = heroe.ancho / 2;
      
      if (distMarioMoneda < (radioMario + m.radio)) {
        monedasRecolectadas++;
        listaMonedas.remove(i);
      }
      else if (m.x < camaraX - 200) {
        listaMonedas.remove(i);
      }
    }
  }

  if (estado == 1 && proximaPlataformaX < camaraX + width + 400) {
    crearNuevaPlataforma();
  }
  
  heroe.dibujar(imgMario);
  
  popMatrix();
  
  textSize(24);
  fill(255);
  stroke(0);
  strokeWeight(4);
  text("VIDAS: " + (heroe.vidas < 0 ? 0 : heroe.vidas), 20, 40);
  
  textAlign(RIGHT, BASELINE);
  fill(255, 215, 0); 
  text("MONEDAS: " + monedasRecolectadas, width - 20, 40);
  textAlign(LEFT, BASELINE); 
  
  if (estado == 2) {
    fill(0, 0, 0, 180); 
    rect(0, 0, width, height);
    
    fill(255, 50, 50);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width / 2, height / 2 - 20);
    
    fill(255);
    textSize(20);
    text("Presiona 'R' para volver a jugar", width / 2, height / 2 + 40);
    textAlign(LEFT, BASELINE); 
  }
}

void crearNuevaPlataforma() {
  float aleatorioY = random(300, 450); 
  Plataforma nuevaPlat = new Plataforma(proximaPlataformaX, aleatorioY);
  listaPlataformas.add(nuevaPlat);
  
  if (random(100) < 60) {
    int cantidadMonedas = (int)random(2, 5); 
    float espacio = nuevaPlat.ancho / (cantidadMonedas + 1);
    for (int i = 1; i <= cantidadMonedas; i++) {
      float monedaX = nuevaPlat.pos.x + (i * espacio);
      float monedaY = nuevaPlat.pos.y - 40; 
      listaMonedas.add(new Moneda(monedaX, monedaY));
    }
  } 
  else if (random(100) < 70) {z
    float puntoMedioX = nuevaPlat.pos.x + (nuevaPlat.ancho / 2);
    float radioEnemigo = 25;
    
    // Elegimos el tipo de enemigo al azar usando rangos numéricos
    float tipoAleatorio = random(100);
    
    if (tipoAleatorio < 40) {
      // 40% de probabilidad: Enemigo Terrestre Clásico
      listaEnemigos.add(new Enemigo(puntoMedioX, nuevaPlat.pos.y, radioEnemigo, nuevaPlat.pos.x, nuevaPlat.ancho));
    } 
    else if (tipoAleatorio < 75) {
      // 35% de probabilidad: NUEVO Enemigo Volador
      listaEnemigos.add(new EnemigoVolador(puntoMedioX, nuevaPlat.pos.y, radioEnemigo, nuevaPlat.pos.x, nuevaPlat.ancho));
    } 
    else {
      // 25% de probabilidad: NUEVO Enemigo Disparador
      listaEnemigos.add(new EnemigoDisparador(puntoMedioX, nuevaPlat.pos.y, radioEnemigo, nuevaPlat.pos.x, nuevaPlat.ancho));
    }
  }
  
  proximaPlataformaX += random(250, 350); 
}


void reiniciarJuego() {
  listaPlataformas.clear();
  listaEnemigos.clear();
  listaProyectiles.clear(); 
  listaMonedas.clear();
  proximaPlataformaX = 400;
  camaraX = 0;
  izquierda = false;
  derecha = false;
  estado = 1; 
  monedasRecolectadas = 0;
  
  heroe = new Jugador(100, 300); 
  
  for(int i = 0; i < 5; i++) {
    crearNuevaPlataforma();
  }
}
