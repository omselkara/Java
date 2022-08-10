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

float g = 1.6/6.;

class Ball{
  float x,y,velx,vely,size,m;
  boolean locked,colide;
  
  Ball(float x,float y,float velx,float vely,float m,float size,boolean colide){
    this.x = x;
    this.y = y;
    this.velx = velx;
    this.vely = vely;
    this.m = m;
    this.size = size;
    this.colide = colide;
    locked = false;
  }
  
  Ball(float x,float y,float velx,float vely,float m,float size,boolean colide,boolean locked){
    this.x = x;
    this.y = y;
    this.velx = velx;
    this.vely = vely;
    this.m = m;
    this.size = size;
    this.colide = colide;
    this.locked = locked;
  }
  
  void show(){
    strokeWeight(0);
    fill(0);
    circle(x,y,size*2);
  }
  
  void check(ArrayList<Wall> walls,ArrayList<Ball> balls){
    if (!locked && colide){
      for (Ball i : balls){
        if (i!=this && i.colide){
          float d = dist(x,y,i.x,i.y);
          if (d<size+i.size){
            float dx = (x-i.x)/d;
            float dy = (y-i.y)/d;
            x = i.x+dx*(size+i.size);
            y = i.y+dy*(size+i.size);
            if (!i.locked){
              dx = (i.x-x)/d;
              dy = (i.y-y)/d;
              i.x = x+dx*(size+i.size);
              i.y = y+dy*(size+i.size);
            }
            float v2 = (2*m*velx + i.m*i.velx - m*i.velx)/(m+i.m);
            float v1 = i.velx + v2 - velx;
            velx = v1;
            i.velx = v2;
            v2 = (2*m*vely + i.m*i.vely - m*i.vely)/(m+i.m);
            v1 = i.vely + v2 - vely;
            vely = v1;
            i.vely = v2;
            i.check(walls,balls);
          }
        }
      }
      for (Wall i : walls){
        if (i.coliding(this)){
          this.bounce(i);
        }
      }
    }    
  }
  
  void move(){
    if (!locked){
      vely += g;
      x += velx;
      y += vely;
    }
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
/*
float cx = abs(x+i.x)/2;
            float cy = abs(y+i.y)/2;
            float d = dist(cx,cy,x,y);
            float dx = abs(x-cx)/d;
            float dy = abs(y-cy)/d;
            float length = dist(x,y,i.x,i.y);
            if (x>cx){
              x = cx+dx*(length/2);
            }
            else{
              x = cx-dx*(length/2);
            }
            if (y>cy){
              y = cy+dy*(length/2);
            }
            else{
              y = cy-dy*(length/2);
            }
            if (!i.locked){
              d = dist(cx,cy,i.x,i.y);
              dx = abs(i.x-cx)/d;
              dy = abs(i.y-cy)/d;
              if (i.x>cx){
                i.x = cx+dx*(length/2);
              }
              else{
                i.x = cx-dx*(length/2);
              }
              if (i.y>cy){
                i.y = cy+dy*(length/2);
              }
              else{
                i.y = cy-dy*(length/2);
              }
            }
*/
