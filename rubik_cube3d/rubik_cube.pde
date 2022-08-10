//F,!F,R,!R,U,!U,B,!B,L,!L,D,!D
int[][] yerler = {{-2,+0,-2,+2,-2,+2,-1,+0,+0},{-2,+0,-2,+2,-2,+2,+1,+0,+0},
                  {-2,+2,-2,+2,+0,+2,+0,+0,+1},{-2,+2,-2,+2,+0,+2,+0,+0,-1},
                  {-2,+2,-2,+0,-2,+2,+0,-1,+0},{-2,+2,-2,+0,-2,+2,+0,+1,+0},
                  {+0,+2,-2,+2,-2,+2,+1,+0,+0},{+0,+2,-2,+2,-2,+2,-1,+0,+0},
                  {-2,+2,-2,+2,-2,+0,+0,+0,-1},{-2,+2,-2,+2,-2,+0,+0,+0,+1},
                  {-2,+2,+0,+2,-2,+2,+0,+1,+0},{-2,+2,+0,+2,-2,+2,+0,-1,+0}};
int[][][] dothis = {{{2,1},{5,0,1,0,3,0,0},{1,0,1,0,3,0,2},{4,2,3,0,3,0,2},{0,0,1,0,3,0,0},{5,0,1,0,3,0,0}},{{2,0},{5,0,1,0,3,0,0},{0,0,1,0,3,0,0},{4,2,3,0,3,0,2},{1,0,1,0,3,0,2},{5,0,1,0,3,0,0}},
                    {{5,1},{0,0,3,2,3,0,0},{3,0,1,0,3,0,0},{1,0,3,2,3,2,0},{2,2,3,0,3,0,2},{0,0,3,2,3,0,0}},{{5,0},{0,0,3,2,3,0,0},{2,2,3,0,3,0,2},{1,0,3,2,3,2,0},{3,0,1,0,3,0,0},{0,0,3,2,3,0,0}},
                    {{0,1},{5,0,3,0,1,0,0},{2,0,3,0,1,0,0},{4,0,3,0,1,0,0},{3,0,3,0,1,0,0},{5,0,3,0,1,0,0}},{{0,0},{5,0,3,0,1,0,0},{3,0,3,0,1,0,0},{4,0,3,0,1,0,0},{2,0,3,0,1,0,0},{5,0,3,0,1,0,0}},
                    {{3,1},{5,2,3,0,3,0,0},{0,2,3,0,3,0,0},{4,0,1,0,3,0,2},{1,2,3,0,3,0,2},{5,2,3,0,3,0,0}},{{3,0},{5,2,3,0,3,0,0},{1,2,3,0,3,0,2},{4,0,1,0,3,0,2},{0,2,3,0,3,0,0},{5,2,3,0,3,0,0}},
                    {{4,1},{3,2,3,0,3,0,0},{0,0,3,0,1,0,0},{2,0,1,0,3,0,2},{1,0,3,0,1,2,0},{3,2,3,0,3,0,0}},{{4,0},{3,2,3,0,3,0,0},{1,0,3,0,1,2,0},{2,0,1,0,3,0,2},{0,0,3,0,1,0,0},{3,2,3,0,3,0,0}},
                    {{1,0},{5,0,3,2,3,0,0},{3,0,3,2,3,0,0},{4,0,3,2,3,0,0},{2,0,3,2,3,0,0},{5,0,3,2,3,0,0}},{{1,1},{5,0,3,2,3,0,0},{2,0,3,2,3,0,0},{4,0,3,2,3,0,0},{3,0,3,2,3,0,0},{5,0,3,2,3,0,0}},};
color[] cubecolors = new color[] {color(255,255,255),color(255,255,0),color(88,213,104),color(28,95,254),color(255,175,28),color(237,48,48),color(0,0,0)};
class rubik_cube{
  int[][][] map;int[][] requires;int anglex=0;int angley = 0;int anglez = 0;boolean moved=false;int type=0;float mult;ArrayList<Integer> moves;
  rubik_cube(){
    this.map = new int[][][] {{{0,0,0},{0,0,0},{0,0,0}},
                              {{1,1,1},{1,1,1},{1,1,1}},
                              {{2,2,2},{2,2,2},{2,2,2}},
                              {{3,3,3},{3,3,3},{3,3,3}},
                              {{4,4,4},{4,4,4},{4,4,4}},
                              {{5,5,5},{5,5,5},{5,5,5}}};
    this.requires = new int[][] {{-2,+2,-2,+0,-2,+2,1,0,1},{-2,+2,+0,+2,-2,+2,1,0,1},{-2,+0,-2,+2,-2,+2,0,1,1},{+0,+2,-2,+2,-2,+2,0,1,1},{-2,+2,-2,+2,-2,+0,1,1,0},{-2,+2,-2,+2,+0,+2,1,1,0}};
    this.mult = speed;
    this.moves = new ArrayList<Integer>();
  }
  void show(float derecex,float derecey,boolean show){
    if (show){
      for (int y=-1;y<2;y++){
        for (int x=-1;x<2;x++){
          for (int z=-1;z<2;z++){
            int[] colors = new int[6];
            for (int i=0;i<6;i++){
              if (x>this.requires[i][0] && x<this.requires[i][1] && y>this.requires[i][2] && y<this.requires[i][3] && z>this.requires[i][4] && z<this.requires[i][5]){
                if (this.requires[i][6]==0){
                  if (i==2){
                    colors[i] = this.map[i][y+1][z+1];
                  }
                  else{
                    colors[i] = this.map[i][y+1][2-(z+1)];
                  }
                }
                else if (this.requires[i][7]==0){
                  colors[i] = this.map[i][z+1][x+1];
                }
                else {
                  if (i==5){
                    colors[i] = this.map[i][y+1][x+1];
                  }
                  else{
                    colors[i] = this.map[i][y+1][2-(x+1)];
                  }
                }
              }
              else{
                colors[i] = 6;
              }
            }
            int x2=0,y2=0,z2=0;
            if (moved){
              if (x>yerler[type][0] && x<yerler[type][1] && y>yerler[type][2] && y<yerler[type][3] && z>yerler[type][4] && z<yerler[type][5]){
                x2 = this.anglex+yerler[type][6];
                y2 = this.angley+yerler[type][7];
                z2 = this.anglez+yerler[type][8];
              }
            }
            cube((x-0.5)*n,(y-0.5)*n,(z-0.5)*n,(x+0.5)*n,(y+0.5)*n,(z+0.5)*n,derecex,derecey,0,x2,y2,z2,colors,new int[0][0],new int[] {5,5,5,5,5,5});
          }
        }
      }
    }
    if (moved){
      if (yerler[type][6]!=0){
        if (this.anglex == yerler[type][6]*90){
          moved = false;
        }
      }
      else if (yerler[type][7]!=0){
        if (this.angley == yerler[type][7]*90){
          moved = false;
        }
      }
      else if (yerler[type][8]!=0){
        if (this.anglez == yerler[type][8]*90){
          moved = false;
        }
      }
      if (!show){
        moved = false;
      }
      if (moved){
        this.anglex += yerler[type][6]*this.mult;
        this.angley += yerler[type][7]*this.mult; 
        this.anglez += yerler[type][8]*this.mult;
      }
      else{
        int[][][] newfaces = new int[6][3][3];
        for (int i=0;i<6;i++){
          for (int y=0;y<3;y++){
            for (int x=0;x<3;x++){
              newfaces[i][y][x] = this.map[i][y][x];
            }
          }
        }
        if (dothis[type][0][1]==0){
          newfaces[dothis[type][0][0]][0][0] = this.map[dothis[type][0][0]][0][2];
          newfaces[dothis[type][0][0]][0][1] = this.map[dothis[type][0][0]][1][2];
          newfaces[dothis[type][0][0]][0][2] = this.map[dothis[type][0][0]][2][2];
          newfaces[dothis[type][0][0]][1][0] = this.map[dothis[type][0][0]][0][1];
          newfaces[dothis[type][0][0]][1][1] = this.map[dothis[type][0][0]][1][1];
          newfaces[dothis[type][0][0]][1][2] = this.map[dothis[type][0][0]][2][1];
          newfaces[dothis[type][0][0]][2][0] = this.map[dothis[type][0][0]][0][0];
          newfaces[dothis[type][0][0]][2][1] = this.map[dothis[type][0][0]][1][0];
          newfaces[dothis[type][0][0]][2][2] = this.map[dothis[type][0][0]][2][0];
        }
        else{
          newfaces[dothis[type][0][0]][0][0] = this.map[dothis[type][0][0]][2][0];
          newfaces[dothis[type][0][0]][0][1] = this.map[dothis[type][0][0]][1][0];
          newfaces[dothis[type][0][0]][0][2] = this.map[dothis[type][0][0]][0][0];
          newfaces[dothis[type][0][0]][1][0] = this.map[dothis[type][0][0]][2][1];
          newfaces[dothis[type][0][0]][1][1] = this.map[dothis[type][0][0]][1][1];
          newfaces[dothis[type][0][0]][1][2] = this.map[dothis[type][0][0]][0][1];
          newfaces[dothis[type][0][0]][2][0] = this.map[dothis[type][0][0]][2][2];
          newfaces[dothis[type][0][0]][2][1] = this.map[dothis[type][0][0]][1][2];
          newfaces[dothis[type][0][0]][2][2] = this.map[dothis[type][0][0]][0][2];
        }
        int[] face = new int[3];
        int yer = 0;
        for (int x=dothis[type][1][1];x<dothis[type][1][2];x++){
          for (int y=dothis[type][1][3];y<dothis[type][1][4];y++){
            int x2 = x;
            int y2 = y;
            if (dothis[type][1][5]==2){
              x2 = 2-x;
            }
            if (dothis[type][1][6]==2){
              y2 = 2-y;
            }
            face[yer] = this.map[dothis[type][1][0]][y2][x2];
            yer++;
          }
        }
        for (int i=2;i<6;i++){
          int[] newface = new int[3];
          yer = 0;
          for (int x=dothis[type][i][1];x<dothis[type][i][2];x++){
            for (int y=dothis[type][i][3];y<dothis[type][i][4];y++){
              int x2 = x;
              int y2 = y;
              if (dothis[type][i][5]==2){
                x2 = 2-x;
              }
              if (dothis[type][i][6]==2){
                y2 = 2-y;
              }
              newface[yer] = this.map[dothis[type][i][0]][y2][x2];
              newfaces[dothis[type][i][0]][y2][x2] = face[yer];
              yer++;
            }
          } 
          face = newface;
        }
        this.map = newfaces;
        this.anglex = 0;
        this.angley = 0;
        this.anglez = 0;
      }
    }
  }
  void move(int type,boolean addmoves){
    if (!this.moved){
      this.moved = true;
      this.type = type;
      if (addmoves){
        if (this.moves.size()==0){
          this.moves.add(type);
        }
        else{
          if (type%2==0){
            if (this.moves.get(this.moves.size()-1)==type+1){
              this.moves.remove(this.moves.size()-1);
            }
            else{
              this.moves.add(type);
            }
          }
          else{
            if (this.moves.get(this.moves.size()-1)==type-1){
              this.moves.remove(this.moves.size()-1);
            }
            else{
              this.moves.add(type);
            }
          }
        }
      }
    }
  }
  int getscore(){
    int score = 0;
    for (int i=0;i<6;i++){
      for (int y=0;y<3;y++){
        for (int x=0;x<3;x++){
          if (this.map[i][y][x]==i){
            score++;
          }
        }
      }
    }
    return score;
  }
  void scramble(){
    for (int i=0;i<100;i++){
      this.move(parseInt(random(0,12)),true);
      this.show(0,0,false);;
    }
  }
}
void cube(float x1,float y1,float z1,float x2,float y2,float z2,float anglex,float angley,float anglez,int anglex1,int angley1,int anglez1,int[] colorsoffaces,int[][] strokesoffaces,int[] weightsoffaces){
    float[][][] points = {{{x1,y1,z1},{x2,y1,z1},{x2,y1,z2},{x1,y1,z2}},
                          {{x1,y2,z1},{x2,y2,z1},{x2,y2,z2},{x1,y2,z2}},
                          {{x1,y1,z1},{x1,y1,z2},{x1,y2,z2},{x1,y2,z1}},
                          {{x2,y1,z1},{x2,y1,z2},{x2,y2,z2},{x2,y2,z1}},
                          {{x1,y1,z1},{x2,y1,z1},{x2,y2,z1},{x1,y2,z1}},
                          {{x1,y1,z2},{x2,y1,z2},{x2,y2,z2},{x1,y2,z2}}};
    push();
    translate(width/2,height/2);
    rotateX(anglex);
    rotateY(angley);
    rotateZ(anglez);
    for (int i=0;i<6;i++){
        fill(255);
        stroke(0);
        strokeWeight(1);
        if (colorsoffaces.length==6){
          fill(cubecolors[colorsoffaces[i]]);
        }
        if (strokesoffaces.length==6){
          stroke(strokesoffaces[i][0],strokesoffaces[i][1],strokesoffaces[i][2]);
        }
        if (weightsoffaces.length==6){
          strokeWeight(weightsoffaces[i]);
        }
        beginShape();
        for (int a=0;a<4;a++){
          double[] xyz;
          //if (anglex2!=0 || anglez2!=0){
          //  xyz = rotatez(points[i][a][0],points[i][a][1],points[i][a][2],anglez+anglez1);
          //  xyz = rotatex(xyz[0],xyz[1],xyz[2],anglex+anglex1);
          //  xyz = rotatey(xyz[0],xyz[1],xyz[2],angley+angley1);
          //}
          ////else if(anglez2!=0){
          ////  xyz = rotatez(points[i][a][0],points[i][a][1],points[i][a][2],anglez+anglez1);
          ////  xyz = rotatex(xyz[0],xyz[1],xyz[2],anglex+anglex1);
          ////  xyz = rotatey(xyz[0],xyz[1],xyz[2],angley+angley1);
          ////}
          //else if(angley!=0){
          //  xyz = rotatez(points[i][a][0],points[i][a][1],points[i][a][2],anglez+anglez1);
          //  xyz = rotatey(xyz[0],xyz[1],xyz[2],angley+angley1);
          //  xyz = rotatex(xyz[0],xyz[1],xyz[2],anglex+anglex1);
          //}
          //else{
            xyz = rotatex(points[i][a][0],points[i][a][1],points[i][a][2],anglex1);
            xyz = rotatey(xyz[0],xyz[1],xyz[2],angley1);
            xyz = rotatez(xyz[0],xyz[1],xyz[2],anglez1);
          vertex(parseFloat(xyz[0]+""),parseFloat(xyz[1]+""),parseFloat(xyz[2]+""));
        }
        endShape(CLOSE);
    }
    pop();
}
