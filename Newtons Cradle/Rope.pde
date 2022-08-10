class Rope{
  float length;
  Ball ball1,ball2;
  
  Rope(Ball ball1,Ball ball2){
    this.ball1 = ball1;
    this.ball2 = ball2;
    length = dist(ball1.x,ball1.y,ball2.x,ball2.y);
  }
  
  void move(){    
    float cx = abs(ball2.x+ball1.x)/2;
    float cy = abs(ball2.y+ball1.y)/2;
    if (!ball1.locked){
      float px = ball1.x;
      float py = ball1.y;
      float d = dist(cx,cy,ball1.x,ball1.y);
      float dx = abs(ball1.x-cx)/d;
      float dy = abs(ball1.y-cy)/d;
      if (ball1.x>cx){
        ball1.x = cx+dx*(length/2);
      }
      else{
        ball1.x = cx-dx*(length/2);
      }
      if (ball1.y>cy){
        ball1.y = cy+dy*(length/2);
      }
      else{
        ball1.y = cy-dy*(length/2);
      }
      ball1.velx += ball1.x-px;
      ball1.vely += ball1.y-py;
    }
    if (!ball2.locked){
      float px = ball2.x;
      float py = ball2.y;
      float d = dist(cx,cy,ball2.x,ball2.y);
      float dx = abs(ball2.x-cx)/d;
      float dy = abs(ball2.y-cy)/d;
      if (ball2.x>cx){
        ball2.x = cx+dx*(length/2);
      }
      else{
        ball2.x = cx-dx*(length/2);
      }
      if (ball2.y>cy){
        ball2.y = cy+dy*(length/2);
      }
      else{
        ball2.y = cy-dy*(length/2);
      }
      ball2.velx += ball2.x-px;
      ball2.vely += ball2.y-py;
    }
  }
  
  void show(){
    stroke(0);
    strokeWeight(2);
    line(ball1.x,ball1.y,ball2.x,ball2.y);
  }
}
