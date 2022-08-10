int col = 25;
int row = 25;
int starter = 200;

class Game{
  int[][] map;
  float dx,dy;
  Head head;
  boolean dead,pressed;
  int foodx,foody,life;
  
  Game(){
    life = starter;
    pressed = false;
    dead = false;
    dx = width/col;
    dy = height/row;
    map = new int[row][col];
    for (int y=0;y<row;y++){
      for (int x=0;x<col;x++){
        map[y][x] = 0;
      }
    } 
    head = new Head(this);
    generate_food();
  }
  
  float[] inputs(){
    float[] ins = new float[] {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    int index = 0;
    for (int vely=-1;vely<2;vely++){
      for (int velx=-1;velx<2;velx++){
        if (!(velx==0 && vely==0)){
          int x = head.x+velx;
          int y = head.y+vely;
          int dist = 1;
          while (true){
            if (x<0 || x>=col || y<0 || y>=row){
              ins[index] = dist;
              break;
            }
            if (map[y][x]==1){
              ins[index+8] = dist;
            }
            if (x==foodx && y==foody && ins[index+8]==0){
              ins[index+16] = dist;
            }
            x += velx;
            y += vely;
            dist++;
          }
          index++;
        }
      }
    }
    return ins;
  }
  
  void generate_food(){
    ArrayList<int[]> areas = new ArrayList<int[]>();
    for (int y=0;y<row;y++){
      for (int x=0;x<col;x++){
        if (map[y][x]==0){
          areas.add(new int[] {x,y});
        }
      }
    }
    if (areas.isEmpty()){
      game.dead = true;
    }
    else{
      int index = (int) random(0,areas.size());
      int[] selected = areas.get(index);
      foodx = selected[0];
      foody = selected[1];
      life = starter+10*head.body.size();
    }
  }
  
  void show(){
    /*strokeWeight(1);
    for (int y=0;y<row;y++){
      line(0,y*dy,width,y*dy);
    }
    for (int x=0;x<row;x++){
      line(x*dx,0,x*dx,height);
    }*/
    strokeWeight(1);
    fill(255,0,0);
    rect(foodx*dx,foody*dy,dx,dy);
    head.show();
  }
  
  void move(){
    if (!dead){
      life--;
      head.move();
      pressed = false;
      if (life<=0){
        dead = true;
      }
    }
  }
  
  void press(char name){
    if (!pressed){
      head.press(name);
    }
  }
}
