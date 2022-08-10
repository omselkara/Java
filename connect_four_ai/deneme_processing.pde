int frame = 0;
boolean draw;
void setup(){
  size(700,600);
  carpx = width/7;
  carpy = height/6;
  createboard();
}
void draw(){
  background(0,116,179);
  drawboard();
  if (!win && !redtomove && frameCount>=frame+30){
    ai();
  }
  if (win){
    textAlign(CENTER);
    textSize(30);
    fill(0);
    if (!redtomove){
      text("You Win",width/2,100);
    }
    else if (!draw){
      text("You Lose",width/2,100);
    }
    else{
      text("Draw",width/2,100);
    }
  }
}
void mousePressed(){
  int x = floor(mouseX/carpx);
  if (x>=0 && x<7 && !win){
    click(x);
    win = checkboard(x)!=0;
    frame = frameCount;
    draw = checkboard(x)==-1;
  }
}
