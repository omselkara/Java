int iteration = 1000000000;
int res = 20000;
float space = res/8;
color white = color(255);
PVector[] triangle = {new PVector(space,res-space),new PVector(res/2,space),new PVector(res-space,res-space)};
PVector point;
void setup(){
  size(600,600);
  float an = millis();
  PImage img = createImage(res, res, RGB);
  while (true){
    point = new PVector(random(0,res),random(0,res));
    if (PointInTriangle(point,triangle[0],triangle[1],triangle[2])){
        break;
    }
  }
  img.set((int)point.x,(int)point.y,white);
  println("firstPoint");
  int mod = iteration/100;
  int percent = 0;
  for (int i=0;i<iteration;i++){
    if (i%mod==0){
      percent++;
      println("%"+percent);
    }
    int secilenyer = (int) random(0,3);
    PVector secilen = triangle[secilenyer];
    float x = (point.x+(secilen.x-point.x)/2);
    float y = (point.y+(secilen.y-point.y)/2);
    point = new PVector(x,y);
    img.set((int)point.x,(int)point.y,white);
  }
  img.save("../a.png");
  println("it took:"+str((millis()-an)/1000));
  exit();
}
