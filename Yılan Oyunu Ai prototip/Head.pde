class Head{
  int x,y;
  int[] face;
  Game game;
  ArrayList<Body> body;
  
  Head(Game game){
    this.game = game;
    x = 2;
    y = 0;
    face = new int[] {+1,+0};
    game.map[y][x] = 1;
    body = new ArrayList<Body>();
    body.add(new Body(1,0,new int[] {+1,+0},game));
    body.add(new Body(0,0,new int[] {+1,+0},game));
  }
  
  void press(char name){
    if (name=='a'){
      if (face[1]!=0){
        changeface(-1,0);
      }
    }
    else if (name=='d'){
      if (face[1]!=0){
        changeface(+1,0);
      }
    }
    else if (name=='w'){
      if (face[0]!=0){
        changeface(0,-1);
      }
    }
    else if (name=='s'){
      if (face[0]!=0){
        changeface(0,+1);
      }
    }
  }
  
  void changeface(int x,int y){
    face[0] = x;
    face[1] = y;
    for (Body i : body){
      i.moves.add(new int[] {this.x,this.y,x,y});
    }
    game.pressed = true;
  }
  
  void undo(){
    x -= face[0];
    y -= face[1];
    game.map[y][x] = 1;
  }
  
  void show(){
    strokeWeight(1);
    stroke(0);
    fill(9,210,1);
    rect(x*game.dx,y*game.dy,game.dx,game.dy);
    for (Body i : body){
      i.show();
    }
  }
  
  void move(){
    game.map[y][x] = 0;
    x += face[0];
    y += face[1];
    if (x<0 || x>=col || y<0 || y>=row){
      game.dead = true;
      undo();
    }
    else{
      game.map[y][x] = 1;
      if (game.foodx==x && game.foody==y){
        Body last = body.get(body.size()-1);
        Body newbody = new Body(last.x-last.face[0],last.y-last.face[1],new int[] {last.face[0],last.face[1]},game);
        for (int[] i : last.moves){
          newbody.moves.add(new int[] {i[0],i[1],i[2],i[3]});
        }
        body.add(newbody);
        game.generate_food();
      }
      int index = 0;
      for (Body i : body){
        i.move();
        if (game.dead){
          break;
        }
        index++;
      }
      if (game.dead){
        for (int i=0;i<=index;i++){
          body.get(i).undo();
        }
        game.map[y][x] = 0;
        undo();
      }
      
    }
  }
}
