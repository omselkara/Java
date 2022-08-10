ArrayList<Wall> walls = new ArrayList<Wall>();
ArrayList<Ball> balls = new ArrayList<Ball>();

void setup(){
  size(600,600);
  frameRate(60);
  walls.add(new Wall(0,0,width,0));
  walls.add(new Wall(width,0,width,height));
  walls.add(new Wall(width,height,0,height));
  walls.add(new Wall(0,height,0,0));
  for (int i=0;i<360;i+=15){
    balls.add(new Ball(width/2+cos(radians(i))*100,height/2+sin(radians(i))*100,cos(radians(i))*3,sin(radians(i))*3,1,10));
  }
}

void draw(){
  background(127);
  for (Wall i : walls){
    i.show();
  }
  for (Ball i : balls){
    i.move(walls,balls);
    i.show();
  }
}
