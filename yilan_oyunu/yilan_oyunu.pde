listgovde list = new listgovde(new govde[0]);
net nets = new net(4,4,1);
food yemek = new food();
int yap = 0;
int yer = 2;
void setup(){
  fullScreen(1);
  train();
  
}
void train(){
  list.clear();
  list.append(new govde(1,0,2,1,0));
  list.append(new govde(0,0,2,0,1));
  yemek.create();
    int[][] ins = {
{list.get(0).x,list.get(0).y,list.get(0).x+int(random(1,6)),list.get(0).y},
{list.get(0).x,list.get(0).y,list.get(0).x-int(random(1,6)),list.get(0).y},
{list.get(0).x,list.get(0).y,list.get(0).x,list.get(0).y-int(random(1,6))},
{list.get(0).x,list.get(0).y,list.get(0).x,list.get(0).y+int(random(1,6))}};
  int[][] outs = {{-1,-1,1,-1},{1,-1,-1,-1},{-1,1,-1,-1},{-1,-1,-1,1}};
nets.train(ins,outs,1000);
}
void draw(){
  frameRate(5);
  background(0);
  yap = 1;
  check();
  display();
}

int xhesap(int x){
  return x*50+8;
}
int yhesap(int y){
  return y*50+9;
}
void rectangle(int x1,int y1,int x2,int y2,int r,int g, int b){
  fill(r,g,b);
  stroke(r,g,b);
  beginShape();
  vertex(x1,y1);
  vertex(x2,y1);
  vertex(x2,y2);
  vertex(x1,y2);
  vertex(x1,y1);
  endShape(CLOSE);
}
void check(){
  for (int i=1;i<list.length;i++){
    if (list.get(0).yon==0){
      if (list.get(i).x==list.get(0).x-1 && list.get(i).y==list.get(0).y){
        train();
        break;
      }
    }
    if (list.get(0).yon==1){
      if (list.get(i).x==list.get(0).x && list.get(i).y==list.get(0).y-1){
        train();
        break;
      }
    }
    if (list.get(0).yon==2){
      if (list.get(i).x==list.get(0).x+1 && list.get(i).y==list.get(0).y){
        train();
        break;
      }
    }
    if (list.get(0).yon==3){
      if (list.get(i).x==list.get(0).x && list.get(i).y==list.get(0).y+1){
        train();
        break;
      }
    }
  }
}
