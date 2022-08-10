/*
m1*v1 + m2*v2 = m1*v1' + m2*v2'
v1 + v1' = v2 + v2'
v1' = v2 + v2' - v1
m1*v1 + m2*v2 = m1*(v2 + v2' - v1) + m2*v2'
m1*v1 + m2*v2 = m1*v2 + m1*v2' - m1*v1 + m2*v2'
2*m1*v1 + m2*v2 - m1*v2 = m1*v2' + m2*v2'
2*m1*v1 + m2*v2 - m1*v2 = v2'*(m1+m2)
v2' = (2*m1*v1 + m2*v2 - m1*v2)/(m1+m2)
v1' = v2 + v2' - v1
*/

float g = 1/6.;

class Ball{
  float x,y,velx,vely,size,m;
  Ball(float x,float y,float velx,float vely,float m,float size){
    this.x = x;
    this.y = y;
    this.velx = velx;
    this.vely = vely;
    this.m = m;
    this.size = size;
  }
  
  void show(){
    strokeWeight(0);
    fill(0);
    circle(x,y,size*2);
  }
  
  void move(ArrayList<Wall> walls,ArrayList<Ball> balls){
    for (Ball i : balls){
      if (i!=this){
        if (dist(x,y,i.x,i.y)<size+i.size){
          x -= velx;
          y -= vely;
          i.x -= i.velx;
          i.y -= i.vely;
          float v2 = (2*m*velx + i.m*i.velx - m*i.velx)/(m+i.m);
          float v1 = i.velx + v2 - velx;
          velx = v1;
          i.velx = v2;
          v2 = (2*m*vely + i.m*i.vely - m*i.vely)/(m+i.m);
          v1 = i.vely + v2 - vely;
          vely = v1;
          i.vely = v2;
        }
      }
    }
    for (Wall i : walls){
      if (i.coliding(this)){
        this.bounce(i);
      }
    }
    vely += g;
    x += velx;
    y += vely;
  }
  
  void bounce(Wall wall){
    x -= velx;
    y -= vely;
    float angle = get_actual_angle(atan2(this.vely,this.velx));
    if (angle>0 && angle<QUARTER){
      if (get_sign(this.velx)<0 && get_sign(this.vely)<0) angle += TWOQUARTER; 
    }
    else if (angle>THREEQUARTER && angle<FOURQUARTER){
      if (get_sign(this.velx)<0 && get_sign(this.vely)>0) angle += TWOQUARTER;
    }
    float normal1 = wall.normal1;
    float normal2 = wall.normal2;
    if (angle>0 && angle<=TWOQUARTER){
      angle = normal1+normal1-angle-TWOQUARTER;
    }
    else if (angle>TWOQUARTER && angle<=FOURQUARTER){
      angle = normal2+normal2-angle+TWOQUARTER;
    }
    float mul = sqrt(velx*velx+vely*vely);
    velx = cos(angle)*mul;
    vely = sin(angle)*mul;
  }
}

float get_sign(float x){
  return x/abs(x);
}
