float carpx,carpy;
int[][] board;
int[] heights;
boolean redtomove,win;
int redstone,yellowstone;
void drawboard(){
  strokeWeight(0);
  for (int y=0;y<6;y++){
    for (int x=0;x<7;x++){
      if (board[y][x]==0){
        fill(255);
      }
      else{
        if (board[y][x]==-1){
          fill(231,226,0);
        }
        else{
          fill(230,0,0);
        }
      }
      ellipse(x*carpx+carpx/2,y*carpy+carpy/2,carpx/3*2.5,carpy/3*2.5);
    }
  }
}
void createboard(){
  board = new int[6][7];
  for (int y=0;y<6;y++){
    board[y] = new int[7];
  }
  heights = new int[7];
  redtomove = true;
  win = false;
  redstone = 0;
  yellowstone = 0;
}
void click(int x){
  if (heights[x]!=6){
    int y=5-heights[x];
    int index = x+y*7;
    if (redtomove){
      redstone++;
    }
    else{
      yellowstone++;
    }
    board[y][x] = redtomove ? 1:-1;
    heights[x]++;
    redtomove = !redtomove;
  }
}
void undo(int x){
  heights[x]--;
  int y = 5-heights[x];
  int index = x+y*7;
  board[y][x] = 0;
  if (!redtomove){
    redstone--;
  }
  else{
    yellowstone--;
  }
  redtomove = !redtomove;  
}
int checkboard(int x){
  int y=5-(heights[x]-1);
  //if (y<0 || y>5 || board[y][x]==0){
  //  return 0;
  //}
  if (y<3 && board[y][x]==board[y+1][x] && board[y][x]==board[y+2][x] && board[y][x]==board[y+3][x]){
    return 1;
  }
  for (int i=0;i<4;i++){
    boolean value1 = true,value2 = true,value3 = true;
    for (int a=-i;a<-i+4;a++){
      if (value1){
        if (y+a>=0 && y+a<6 && x+a>=0 && x+a<7){
          if (board[y+a][x+a]!=board[y][x]){
            value1 = false;
          }
        }
        else{
          value1 = false;
        }
      }
      if (value2){
        if (x+a>=0 && x+a<7){
          if (board[y][x+a]!=board[y][x]){
            value2 = false;
          }
        }
        else{
          value2 = false;
        }
      }
      if (value3){
        if (x+a>=0 && x+a<7 && y-a>=0 && y-a<6){
          if (board[y-a][x+a]!=board[y][x]){
            value3 = false;
          }
        }
        else{
          value3 = false;
        }
      }
      if (!value1 && !value2 && !value3){
        break;
      }
    }
    if (value1 || value2 || value3){
      return 1;
    }
  }
  for (int i : heights){
    if (i!=6){
      return 0;
    }
  }
  return -1;
}
