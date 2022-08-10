ArrayList<Wall> walls = new ArrayList<Wall>();
ArrayList<Ball> balls = new ArrayList<Ball>();
ArrayList<Rope> ropes = new ArrayList<Rope>();

Ball fakeball = new Ball(0,0,0,0,0,0,false,false);
Rope fakerope = new Rope(fakeball,fakeball);

Ball clicked = fakeball;
Rope rope = fakerope;

int iter = 10;
boolean stopped = false;

void setup(){
  size(600,600);
  frameRate(300);
  balls.add(new Ball(200,200,0,0,1,1,false,true));
  balls.add(new Ball(250,200,0,0,1,1,false,true));
  balls.add(new Ball(300,200,0,0,1,1,false,true));
  balls.add(new Ball(350,200,0,0,1,1,false,true));
  balls.add(new Ball(400,200,0,0,1,1,false,true));
  balls.add(new Ball(200,400,0,0,1,25,true));
  balls.add(new Ball(250,400,0,0,1,25,true));  
  balls.add(new Ball(300,400,0,0,1,25,true));
  balls.add(new Ball(350,400,0,0,1,25,true));
  balls.add(new Ball(600,200,0,0,1,25,true));
  
  ropes.add(new Rope(balls.get(0),balls.get(5)));
  ropes.add(new Rope(balls.get(1),balls.get(6)));
  ropes.add(new Rope(balls.get(2),balls.get(7)));
  ropes.add(new Rope(balls.get(3),balls.get(8)));
  ropes.add(new Rope(balls.get(4),balls.get(9)));
}

void draw(){
  background(127);
  for (Wall i : walls){
    i.show();
  }
  if (!stopped){
    for (int i=0;i<iter;i++){
      for (Ball ball : balls){
        ball.check(walls,balls);
      }
    }
  }
  for (Ball ball : balls){
    if (!stopped){
      if (ball!=clicked){
        ball.move();
      }
    }
    ball.show();
  }
  for (Rope i : ropes){
    if (!stopped){
      i.move();
    }
    i.show();
  }
}

void mousePressed(){
  for (Ball ball : balls){
    if (dist(mouseX,mouseY,ball.x,ball.y)<ball.size){
      clicked = ball;
      for (Rope i : ropes){
        if (i.ball1==clicked || i.ball2==clicked){
          rope = i;
          break;
        }
      }
      break;
    }
  }
}

void mouseReleased(){
  clicked = fakeball;
  rope = fakerope;
}

void mouseDragged(){
  if (clicked!=fakeball){
    clicked.x = mouseX;
    clicked.y = mouseY;
    rope.move();
  }
}

void keyPressed(){
  if (key==' '){
    stopped = !stopped;
  }
}
