class boid{
  PVector pos;
  float angle;
  PVector[] points;
  float[] distances;
  float[] angles;
  boid(PVector pos){
    this.pos = pos; 
    this.angle = random(0,560);
    this.points = new PVector[] {
    new PVector(-5   ,-5),
    new PVector(+12.5,+0),
    new PVector(-5   ,+5)};
    distances = new float[3];
    angles = new float[3];
    for (int i=0;i<3;i++){
      distances[i] = dist(0,0,this.points[i].x,this.points[i].y);
      angles[i] = 180/3.14*atan2(this.points[i].x,this.points[i].y);
    }
  }
  void move(){
    int left = 0,right=0;
    float alignment = 0;
    float cohesionx = this.pos.x,cohesiony=this.pos.y;
    for (int i=0;i<boids.length;i++){
      if (boids[i]!=this && dist(this.pos.x,this.pos.y,boids[i].pos.x,boids[i].pos.y)<30){
        float angleofboid = 180/3.14*atan2(boids[i].pos.x-this.pos.x,boids[i].pos.y-this.pos.y);
        if (angleofboid>this.angle+this.angles[1] && angleofboid<this.angle+this.angles[1]+180){
          right++;
        }
        else{
          left++;
        }
        alignment += boids[i].angle+this.angles[1];
        cohesionx += boids[i].pos.x;
        cohesiony += boids[i].pos.y;
      }
    }
    alignment = alignment/(left+right);
    if (right>left){
      this.angle-=5;
    }
    else if (left>right){
      this.angle+=5;
    }
    if (alignment>this.angle+this.angles[1] && alignment<this.angle+this.angles[1]+180){
      this.angle+=5;
    }
    else if (alignment!=this.angle+this.angles[1] && alignment!=this.angle+this.angles[1]+180){
      this.angle-=5;
    }
    cohesionx = cohesionx/(left+right);
    cohesiony = cohesiony/(left+right);
    float angleofcohesion = 180/3.14*atan2(cohesionx-this.pos.x,cohesiony-this.pos.y);
    if (angleofcohesion>this.angle+this.angles[1] && angleofcohesion<this.angle+this.angles[1]+180){
      this.angle+=5;
    }
    else if (angleofcohesion!=this.angle+this.angles[1] && angleofcohesion!=this.angle+this.angles[1]+180){
      this.angle-=5;
    }
    this.pos = this.rotatepoint(this.pos.x,this.pos.y,this.angle+this.angles[1],2);
    if (this.pos.x>width){
      this.pos.x = 0;
    }
    else if (this.pos.x<0){
      this.pos.x = width;
    }
    if (this.pos.y>height){
      this.pos.y = 0;
    }
    else if (this.pos.y<0){
      this.pos.y = height;
    }
  }
  void show(){
    move();
    beginShape();
    strokeWeight(1);
    stroke(0,0,239);
    for (int i=0;i<3;i++){
      PVector position = this.rotatepoint(this.pos.x,this.pos.y,this.angle+this.angles[i],distances[i]);
      vertex(position.x,position.y);
    }
    PVector position = this.rotatepoint(this.pos.x,this.pos.y,this.angle+this.angles[0],distances[0]);
    vertex(position.x,position.y);
    endShape();
  }
  PVector rotatepoint(float x,float y,float angle,float radius){
    float x2 = cos(radians(angle))*radius;
    float y2 = sin(radians(angle))*radius;
    return new PVector(x+x2,y+y2);
  }
}
