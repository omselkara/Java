float derecex = 0;
float derecey = 0;
int n = 50;  
//////maximum 90
int speed = 15;
boolean solve = false;
rubik_cube rubik;
void setup() {
  size(600, 600, P3D);
  frameRate(60);
  rubik = new rubik_cube();
  //rubik.scramble();
}
void draw() {
  background(127.5);
  if (solve) {
    if (!rubik.moved) {
      if (rubik.moves.size()==0) {
        solve = false;
        rubik.mult = speed;
      } else {
        if (rubik.moves.get(rubik.moves.size()-1)%2==0) {
          rubik.move(rubik.moves.get(rubik.moves.size()-1)+1, false);
        } else {
          rubik.move(rubik.moves.get(rubik.moves.size()-1)-1, false);
        }
        rubik.moves.remove(rubik.moves.size()-1);
      }
    }
  }
  rubik.show(derecex, derecey, true);
}
void mouseDragged() {
  derecey += (mouseX-pmouseX)*0.01;
  derecex -= (mouseY-pmouseY)*0.01;
}
void keyPressed() {
  int type=-1;
  if (key=='q') {
    type=0;
  }
  if (key=='w') {
    type=2;
  }
  if (key=='e') {
    type=4;
  }
  if (key=='r') {
    type=6;
  }
  if (key=='t') {
    type=8;
  }
  if (key=='y') {
    type=10;
  }
  if (key=='a') {
    type=1;
  }
  if (key=='s') {
    type=3;
  }
  if (key=='d') {
    type=5;
  }
  if (key=='f') {
    type=7;
  }
  if (key=='g') {
    type=9;
  }
  if (key=='h') {
    type=11;
  }
  if (type!=-1) {
    rubik.move(type, true);
  }
  if (key==' ') {
    rubik.mult = (rubik.moves.size()/10)&90;
    if (rubik.mult<speed) {
      rubik.mult = speed;
    }
    rubik.mult += 90%rubik.mult;
    solve = !solve;
  }
  if (key=='-' && !solve && !rubik.moved) {
    rubik.scramble();
  }
}
