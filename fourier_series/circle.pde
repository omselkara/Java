class circle{
  float radius,cx,cy,newx,newy;
  float angle,velocity;
  circle(float radius,float cx,float cy,float velocity){
    this.angle=random(0,360);
    newx = (radius*(cos(angle)))+cx;
    newy = (radius*(sin(angle)))+cy;
    this.radius = radius;
    this.cx = cx;
    this.cy = cy;
    this.velocity = velocity;
  }
  void display(){
    fill(255);
    stroke(255);
    newx = (radius*(cos(angle)))+cx;
    newy = (radius*(sin(angle)))+cy;
    line(cx,cy,newx,newy);
    noFill();
    ellipseMode(CENTER);
    ellipse(cx,cy,radius*2,radius*2);
    angle += velocity;
    if (angle>360){
      angle -= 360;
    }
  }
  void simulate(){
    newx = (radius*(cos(angle)))+cx;
    newy = (radius*(sin(angle)))+cy;
    angle += velocity;
    if (angle>360){
      angle -= 360;
    }
  }
}
