class Body{
  int x,y;
  int[] face;
  ArrayList<int[]> moves;
  Game game;
  
  Body(int x,int y,int[] face,Game game){
    
    this.x = x;
    this.y = y;
    this.face = face;
    this.game = game;
    if (x>=0 && x< col && y>=0 && y< row){
      game.map[y][x] = 1;
    }
    moves = new ArrayList<int[]>();
  }
  
  void undo(){
    game.map[y][x] = 0;
    x -= face[0];
    y -= face[1];
    game.map[y][x] = 1;
  }
  
  void move(){
    if (x>=0 && x< col && y>=0 && y< row){
      game.map[y][x] = 0;
    }
    if (!moves.isEmpty()){
      int[] move = moves.get(0);
      if (move[0]==x && move[1]==y){
        face[0] = move[2];
        face[1] = move[3];
        moves.remove(move);
      }
    }
    x += face[0];
    y += face[1];
    if (x==game.head.x && y==game.head.y){
      game.dead = true;
    }
    else{
      game.map[y][x] = 1;
    }
  }
  
  void show(){
    strokeWeight(1);
    stroke(0);
    fill(9,131,1);
    rect(x*game.dx,y*game.dy,game.dx,game.dy);
  }
}
