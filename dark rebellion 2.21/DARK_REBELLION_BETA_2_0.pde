ArrayList<Plataforma> listaPlataformas = new ArrayList<Plataforma>(); 
ArrayList<Enemigo> listaEnemigos = new ArrayList<Enemigo>(); 
ArrayList<Moneda> listaMonedas = new ArrayList<Moneda>();

float proximaPlataformaX = 400; 
Jugador heroe;

// Texturas precargadas globales para optimizar rendimiento
PImage imgJugadorIdle, imgJugadorJump, imgJugadorRun;
PImage imgEneFuego, imgEneFantasma, imgEneSombra;
PImage imgMoneda;

float gravedad = 0.4;
float camaraX = 0; 
float anchoSuelo = 400;
float anchoNubeBucle = 300;

int estado = 0, monedasRecolectadas = 0;
float camaraMenuNubes = 0;

PFont fuenteTitulo;

void setup() {
  size(800, 600);
  
  // 1. Precarga de assets del Jugador
  imgJugadorIdle = loadImage("centinela.png");
  imgJugadorJump = loadImage("centinela_saltando.png");
  imgJugadorRun  = loadImage("centinela_corriendo.png");
  
  // 2. Precarga de assets de Enemigos y objetos
  imgEneFuego    = loadImage("fantasma de fuego.png");
  imgEneFantasma = loadImage("fantasma.png");
  imgEneSombra   = loadImage("agujasombria.png");
  imgMoneda      = loadImage("puntos reales.png");
  
  fuenteTitulo = createFont("Impact", 64); 
  
  reiniciarJuego();
  estado = 0; 
}

void draw() {
  // El switch aísla por completo las pantallas, garantizando estabilidad absoluta
  switch (estado) {
    case 0:
      dibujarMenuInicio();
      break;
      
    case 1:
      background(135, 206, 235); // Limpieza de fotogramas del nivel
      dibujarJuego();
      break;
      
    case 2:
      background(135, 206, 235);
      dibujarJuego(); // Muestra la pantalla de Game Over encima
      break;
  }
}

void reiniciarJuego() {
  listaPlataformas.clear();
  listaEnemigos.clear();
  listaMonedas.clear();
  
  monedasRecolectadas = 0;
  camaraX = 0;
  proximaPlataformaX = 400; 
  
  heroe = new Jugador(100, 300, imgJugadorIdle, imgJugadorJump, imgJugadorRun); 
  
  // Generamos el mapa inicial de golpe
  crearNuevaPlataforma();
  crearNuevaPlataforma();
  crearNuevaPlataforma();
  
  estado = 1; // Cambia al estado de juego activo de forma segura
}



//Se eliminara cuando haya una imagen del mismo mapa, es redundante.
void dibujarMenuInicio() {
  // FONDO: Degradado vertical
  for (int y = 0; y < height; y++) {
    color colorArriba = color(20, 40, 80);
    color colorAbajo = color(135, 206, 235);
    float inter = map(y, 0, height, 0, 1);
    color c = lerpColor(colorArriba, colorAbajo, inter);
    stroke(c);
    line(0, y, width, y);
  }
  
  // Movimiento de nubes de fondo
  camaraMenuNubes += 0.5;
  dibujarNubesBucle(camaraMenuNubes);
  
 
  // Suelo verde plano original (Corregido para evitar el bug visual) (MAPA NATIVO, BORRAR)
  fill(34, 139, 34);
  stroke(0);
  strokeWeight(2);
  rect(0, 500, width, 100);
  
  textAlign(CENTER, CENTER);
  
  // TITULO
  textFont(fuenteTitulo); 
  fill(0, 0, 0, 150);
  text("DARK REBELLION", width / 2 + 5, height / 4 + 5);
  fill(139, 0, 0); 
  text("DARK REBELLION", width / 2, height / 4);
  
  // Texto intermitente de inicio
  if (frameCount % 60 < 40) {
    fill(255);
    textSize(22);
    text("PRESIONA ENTER PARA EMPEZAR", width / 2, height / 2 - 30);
  }
    
  // Ventana de controles estilizada semi-transparente
  fill(0, 0, 0, 120); 
  stroke(255, 150);   
  rect(width / 2 - 180, height / 2 + 105, 360, 90, 15); 
  
  fill(255); 
  textSize(14);
  text("CONTROLES", width / 2, height / 2 + 120);
  fill(200);
  text("A / D o Flechas: Moverse", width / 2, height / 2 + 140);
  text("Espacio o Flecha Arriba: Saltar  |  Z: Disparar", width / 2, height / 2 + 160);
  
  textAlign(LEFT, BASELINE);
}

void dibujarNubesBucle(float camaraOffset) {
  int nubeInicio = floor(camaraOffset / anchoNubeBucle);
  int nubesVisibles = ceil(width / anchoNubeBucle) + 1;
  
  pushMatrix();
  translate(-camaraOffset, 0);
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
}

void dibujarJuego() {
  if (estado == 1) {
    heroe.actualizar(gravedad);
   
    if (heroe.pos.x > width / 2) camaraX = heroe.pos.x - width / 2;
    if (heroe.pos.y > height + 100) heroe.vidas = 0; 
    if (heroe.vidas <= 0) estado = 2;
  } else {
    heroe.teclaIzquierda = false;
    heroe.teclaDerecha = false;
  }
 
  dibujarNubesBucle(camaraX * 0.3);
  stroke(0);
  heroe.enElSuelo = false; 
  
  int bloqueInicio = floor(camaraX / anchoSuelo);
  int bloquesVisibles = ceil(width / anchoSuelo) + 1;
  
  pushMatrix();
  translate(-camaraX, 0);
  
  fill(34, 139, 34); 
  for (int i = bloqueInicio; i <= bloqueInicio + bloquesVisibles; i++) {
    float sueloX = i * anchoSuelo;
    rect(sueloX, 500, anchoSuelo, 100);
    heroe.verificarColisionSuelo(sueloX, 500, anchoSuelo);
  }
  
  for (int i = listaPlataformas.size() - 1; i >= 0; i--) {
    Plataforma plat = listaPlataformas.get(i);
    plat.mostrar(); 
    heroe.verificarColisionSuelo(plat.pos.x, plat.pos.y, plat.ancho);
    if (estado == 1 && plat.pos.x < camaraX - 200) listaPlataformas.remove(i);
  }
  
  float heroeCentroX = heroe.pos.x + (heroe.ancho / 2);
  float heroeCentroY = heroe.pos.y + (heroe.alto / 2);
  float radioHeroe = heroe.ancho / 2;
  
  for (int i = listaEnemigos.size() - 1; i >= 0; i--) {
    Enemigo ene = listaEnemigos.get(i);
    if (estado == 1) ene.actualizar();
    ene.dibujar();
    
    if (estado == 1) {
      float distancia = dist(heroeCentroX, heroeCentroY, ene.pos.x, ene.pos.y);
      if (distancia < (radioHeroe + ene.radio)) {
        if (heroe.vel.y > 0 && (heroe.pos.y + heroe.alto) < ene.pos.y + 10) {
          listaEnemigos.remove(i); 
          heroe.vel.y = -9;         
          heroe.enElSuelo = false;
        } else {
          heroe.recibirDano(); 
        }
      } else if (ene.pos.x < camaraX - 200) {
        listaEnemigos.remove(i);
      }
    }
  }
  
  for (int i = listaMonedas.size() - 1; i >= 0; i--) {
    Moneda m = listaMonedas.get(i);
    if (estado == 1) m.actualizar();
    m.dibujar();
    
    if (estado == 1) {
      if (dist(heroeCentroX, heroeCentroY, m.pos.x, m.pos.y) < (radioHeroe + m.radio)) {
        monedasRecolectadas++;
        listaMonedas.remove(i);
      } else if (m.pos.x < camaraX - 200) {
        listaMonedas.remove(i);
      }
    }
  }

  if (estado == 1 && proximaPlataformaX < camaraX + width + 400) crearNuevaPlataforma();
  
  heroe.dibujar(); 
  popMatrix();
  
  // ==================================================================================================================================================
  // --- HUD: SISTEMA DE SALUD ESTILO HOLLOW KNIGHT (MÁSCARAS AUTOMÁTICAS) --- (El sistema no lo borramos, Si el hacer las mascaras en Processing)
  // ==================================================================================================================================================
  int vidasMaximas = 3; 
  if (heroe.vidas > vidasMaximas) vidasMaximas = heroe.vidas; 

  pushStyle();
  strokeWeight(2);
  
  for (int i = 0; i < vidasMaximas; i++) {
    float mascaraX = 35 + (i * 35); 
    float mascaraY = 35;            
    
    // EFECTO DINÁMICO: Si el héroe acaba de recibir daño (está invencible), la interfaz vibra
    if (heroe.invencible && estado == 1) {
      mascaraX += random(-2, 2);
      mascaraY += random(-2, 2);
    }
    
    // 1. Sombra proyectada de la máscara
    fill(0, 0, 0, 100);
    noStroke();
    rect(mascaraX - 11, mascaraY - 13, 24, 28, 5);
    
    // 2. Determinar estado de la máscara
    if (i < heroe.vidas) {
      // MÁSCARA LLENA (Salud activa)
      stroke(30, 30, 45);
      fill(245, 247, 250); 
      rect(mascaraX - 12, mascaraY - 15, 24, 28, 6); 
      
      fill(245, 247, 250);
      triangle(mascaraX - 12, mascaraY - 15, mascaraX - 6, mascaraY - 23, mascaraX - 3, mascaraY - 15);
      triangle(mascaraX + 12, mascaraY - 15, mascaraX + 6, mascaraY - 23, mascaraX + 3, mascaraY - 15);
      
      fill(25, 25, 35);
      noStroke();
      ellipse(mascaraX - 5, mascaraY - 2, 6, 9);
      ellipse(mascaraX + 5, mascaraY - 2, 6, 9);
    } else {
      // MÁSCARA ROTA (Salud perdida)
      stroke(50, 40, 50, 180);
      fill(15, 10, 20, 160); 
      rect(mascaraX - 12, mascaraY - 15, 24, 28, 6);
      
      // Detalles de grieta fijos
      stroke(70, 40, 60);
      line(mascaraX - 2, mascaraY - 10, mascaraX + 3, mascaraY + 5);
      line(mascaraX + 3, mascaraY + 5, mascaraX - 4, mascaraY + 10);
      
      // EFECTO DE PARTÍCULAS: Si se acaba de romper, desprende chispas blancas
      if (heroe.invencible && heroe.tiempoInvencible > 45 && estado == 1) {
        fill(255, 255, 255, 200);
        noStroke();
        ellipse(mascaraX + random(-15, 15), mascaraY + random(-15, 15), random(2, 5), random(2, 5));
      }
    }
  }
  popStyle();
  // =========================================================================

  // CORREGIDO: Bloque único del HUD de monedas
  textAlign(RIGHT, BASELINE); 
  textSize(24); 
  fill(255, 215, 0); 
  stroke(0); 
  strokeWeight(4);
  text("MONEDAS: " + monedasRecolectadas, width - 20, 40);
  textAlign(LEFT, BASELINE); 
  
  // CORREGIDO: Bloque único de la interfaz de Game Over
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
      listaMonedas.add(new Moneda(nuevaPlat.pos.x + (i * espacio), nuevaPlat.pos.y - 40, imgMoneda));
    }
  } else if (random(100) < 70) {
    float tipoEnemigo = random(100);
    
  if (tipoEnemigo < 40) {
  listaEnemigos.add(new Enemigo(nuevaPlat, 20, imgEneFuego));
} else if (tipoEnemigo < 75) {
  listaEnemigos.add(new EnemigoVolador(nuevaPlat, 20, imgEneFantasma));
} else {
  listaEnemigos.add(new EnemigoDisparador(nuevaPlat, 20, imgEneSombra));
}
  }
  proximaPlataformaX += nuevaPlat.ancho + random(100, 250);
}
