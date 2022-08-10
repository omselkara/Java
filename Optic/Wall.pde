/*
m = tan(angle)
y - y1 = m * (x - x1)
0 = mx - y - mx1 + y1
a = m
b = -1
c = -mx1 + y1
dist = |ax + by + c|/sqrt(a**2+b**2)
*/

float QUARTER = PI/2;
float TWOQUARTER = QUARTER*2;
float THREEQUARTER = QUARTER*3;
float FOURQUARTER = QUARTER*4;

class Wall{
  float x1,y1,x2,y2,angle,normal1,normal2,m,a,b,c;
  Wall(float x1,float y1,float x2,float y2){
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    angle = get_actual_angle(atan2(y2-y1,x2-x1));
    normal1 = get_actual_angle(angle-QUARTER);
    normal2 = get_actual_angle(angle+QUARTER);
    m = tan(angle);
    a = m;
    b = -1;
    c = -m*x1+y1;
  }
  
  void show(){
    stroke(0);
    strokeWeight(2);
    line(x1,y1,x2,y2);
  }
  
  boolean coliding(Ball ball){
    float distance = abs(a*(ball.x+ball.velx)+b*(ball.y+ball.vely)+c)/sqrt(a*a+b*b);
    return (distance<=ball.size && (((ball.x>=x1 && ball.x<=x2) || (ball.x<=x1 && ball.x>=x2)) || ((ball.y>=y1 && ball.y<=y2) || (ball.y<=y1 && ball.y>=y2))));
  }
}

float rad_to_angle(float x){
  return x*180/PI;
}

float get_actual_angle(float x){
  while (x<=0){
    x += FOURQUARTER;
  }
  while (x>FOURQUARTER){
    x -= FOURQUARTER;
  }
  return x;
}
