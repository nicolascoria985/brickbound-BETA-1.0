class Plataforma {
  PVector pos;
  float ancho;
  float alto;
  color colorBase;
  color colorBorde;


  Plataforma(float x, float y) {
    this.pos = new PVector(x, y);
    

    this.ancho = random(80, 150);  
    this.alto = random(20, 40);    
    

    this.colorBase = color(180, 85, 40);  
    this.colorBorde = color(100, 40, 15);
  }

  void mostrar() {

    noStroke();
    fill(0, 0, 0, 40); 
    rect(pos.x + 5, pos.y + 7, ancho, alto, 6);

 
    stroke(colorBorde);
    strokeWeight(3); 
    fill(colorBase);
    rect(pos.x, pos.y, ancho, alto, 6); 


    noStroke();
    fill(255, 255, 255, 60); 
    rect(pos.x + 3, pos.y + 3, ancho - 6, 5, 2);
    
    strokeWeight(1); 
  }
}
