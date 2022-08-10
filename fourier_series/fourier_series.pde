float pi=1.5;
int n=100;
circle liste[] = new circle[n];
PGraphics pg;
void setup() {
  size(600, 400);
  pg = createGraphics(600, 400);
  liste[0] = new circle(100,300,200,0.01);
  for (int i=1;i<n;i++){
    liste[i] = new circle(liste[i-1].radius/pi,liste[i-1].newx,liste[i-1].newy,liste[i-1].velocity*pi);
  }
}
void draw() {
  //frameRate(60);
  background(0);
  int i=0;
  float eskix,eskiy;
  eskix = liste[liste.length-1].newx;
  eskiy = liste[liste.length-1].newy;
  liste[0].display();
  for (circle s : liste){
    if (i!=0){
      s.cx = liste[i-1].newx;
      s.cy = liste[i-1].newy;
      s.display();
    }
    i++;
  }
  pg.beginDraw();
  pg.stroke(255,0,0);
  pg.fill(255,0,0);
  pg.line(eskix,eskiy,liste[liste.length-1].newx,liste[liste.length-1].newy);
  pg.endDraw();
  image(pg,0,0);
}
