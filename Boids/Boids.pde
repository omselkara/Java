boid[] boids;
int nofboid = 500;
void setup(){
  size(700,600);
  boids = new boid[nofboid];
  for (int i=0;i<nofboid;i++){
    boids[i] = new boid(new PVector(random(0,width),random(0,height)));
  }
  frameRate(60);
}
void draw(){
  background(239);
  for (boid i : boids){
    i.show();
  }
}
