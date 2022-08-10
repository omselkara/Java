final int[][] all_faces = new int[][] {{-1,-1},{+0,-1},{+1,-1},{+1,+0},{+1,+1},{+0,+1},{-1,+1},{-1,+0}};
int startlimit = 100;
int artis = 1;
class game{
  float[][] map;
  ArrayList<body> bodies;
  boolean dead,pressed,ate,limit;
  PVector food;
  float[][] where;
  int frame,until,count;
  int seed;
  body head;
  game(boolean limit){
    seed = millis();
    randomSeed(seed);
    this.limit = limit;
    frame = 0;
    until = startlimit;
    map = new float[row][col];
    bodies = new ArrayList<body>();
    bodies.add(new body(2,0,faces.right,true,this));
    bodies.add(new body(1,0,faces.right,false,this));
    bodies.add(new body(0,0,faces.right,false,this));
    dead = false;
    pressed = false;
    head = bodies.get(0);
    create_food();
    ate = false;
    count = 0;
  }
  game(boolean limit,float seed){
    this.seed = (int) seed;
    randomSeed(this.seed);
    this.limit = limit;
    frame = 0;
    until = startlimit;
    map = new float[row][col];
    bodies = new ArrayList<body>();
    bodies.add(new body(2,0,faces.right,true,this));
    bodies.add(new body(1,0,faces.right,false,this));
    bodies.add(new body(0,0,faces.right,false,this));
    dead = false;
    pressed = false;
    head = bodies.get(0);
    create_food();
    ate = false;
    count = 0;
  }
  void create_food(){
    ArrayList<int[]> probs = new ArrayList<int[]>();
    for (int y=0;y<row;y++){
      for (int x=0;x<col;x++){
        if (map[y][x]==0){
          probs.add(new int[] {x,y});
        }
      }
    }
    int[] select = probs.get(floor(random(probs.size())));
    food = new PVector(select[0],select[1]);
    map[select[1]][select[0]] = 1;
  }
  void eat_food(){
    ate = false;
    body parent = bodies.get(bodies.size()-1);
    body child;
    if (parent.face==faces.up){
      child = new body(parent.x,parent.y+1,faces.up,false,this);
    }
    else if (parent.face==faces.right){
      child = new body(parent.x-1,parent.y,faces.right,false,this);
    }
    else if (parent.face==faces.down){
      child = new body(parent.x,parent.y-1,faces.down,false,this);
    }
    else{ //left
      child = new body(parent.x+1,parent.y,faces.left,false,this);
    }
    for (int i=0;i<parent.moves.size();i++){
      int[] move = parent.moves.get(i);
      child.moves.add(new int[] {move[0],move[1],move[2]});
    }
    bodies.add(child);
    create_food();
    frame -= 100;
  }
  void move(){
    if (!dead){
      count++;
      where = new float[row][col];
      map = new float[row][col];
      map[(int)food.y][(int)food.x] = 1;
      pressed = false;
      for (body i : bodies){
        i.move();
      }
      if (ate){
        eat_food();
      }
      if (!dead && where[head.y][head.x]>1){
        dead = true;
      }
      if (limit){
        frame++;
        if (frame>=until){
          dead = true;
        }
      }
    }
  }
  void show(float x1,float y1,float w,float h){
    move();
    strokeWeight(1);
    stroke(0);
    float xr = w/col;
    float yr = h/row;
    for (int y=0;y<row;y++){
      for (int x=0;x<col;x++){
        fill(255);
        if (map[y][x]!=0){
          if (map[y][x]<0){
            if (map[y][x]==-10){
              fill(0,200,0);
            }
            else{
              fill(0,100,0);
            }
          }
          else{
            fill(255,0,0);
          }
        }
        rect(x*xr+x1,y*yr+y1,xr,yr);
      }
    }
  }
  float[] inputs(){
    float[] input = new float[16];
    for (int i=0;i<8;i++){
      int cx = head.x;
      int cy = head.y;
      int x = head.x;
      int y = head.y;
      int sayi = 1;
      while (true){
        x += all_faces[i][0];
        y += all_faces[i][1];
        if (x<0 || x>=col || y<0 || y>= row){
          if (input[i+8]==0){
            input[i+8] = dist(cx,cy,x,y);
          }
          break;
        }
        if (input[i]!=0 && input[i+8]!=0){
          break;
        }
        if (input[i]==0 && map[y][x]==1){
          input[i] = dist(cx,cy,x,y);
        }
        if (input[i+8]==8 && map[y][x]<0){
          input[i+8] = dist(cx,cy,x,y);
        }
        sayi++;
      }
    }
    return input;
  }
  void press(int face){
    if (!pressed){
      boolean ok = false;
      if (face==faces.up){
        if (head.face!=faces.down){
          ok = true;
        }
      }
      else if (face==faces.right){
        if (head.face!=faces.left){
          ok = true;
        }
      }
      else if (face==faces.down){
        if (head.face!=faces.up){
          ok = true;
        }
      }
      else if (face==faces.left){
        if (head.face!=faces.right){
          ok = true;
        }
      }
      if (ok){
        pressed = true;
        head.face = face;
        for (int i=1;i<bodies.size();i++){
          body a = bodies.get(i);
          a.moves.add(new int[] {head.x,head.y,face});
        }
      }
    }
  }
}
class body{
  int x,y,face;
  boolean ishead;
  ArrayList<int[]> moves;
  game parent;
  body(int x,int y,int face,boolean ishead,game parent){
    this.x = x;
    this.y = y;
    this.face = face;
    this.ishead = ishead;
    this.parent = parent;
    parent.map[y][x] = ishead ? -10:-1;
    moves = new ArrayList<int[]>();
  }
  void move(){
    if (!ishead && moves.size()!=0){
      int[] move = moves.get(0);
      if (move[0]==x && move[1]==y){
        face = move[2];
        moves.remove(0);
      }
    }
    if (face==faces.up){
      y--;
    }
    else if (face==faces.right){
      x++;
    }
    else if (face==faces.down){
      y++;
    }
    else if (face==faces.left){
      x--;
    }
    if (x<0 || x>=col || y<0 || y>=row){
      parent.dead = true;
      return;
    }
    if (ishead && parent.map[y][x]==1){
      parent.ate = true;
    }
    parent.where[y][x]++;
    parent.map[y][x] = ishead ? -10:-1;
  }
}
static class faces{
  static final int up = 0;
  static final int right = 1;
  static final int left = 2;
  static final int down = 3;
}
