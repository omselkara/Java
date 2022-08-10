Game game;

int fps = 60;
int wait = 60/fps;

boolean show = true;

Network net;

void setup(){
  size(600,600,P2D);
  game = new Game();
  net = new Network(24,1,4,1000);
}

void draw(){
  background(0);
  if (!game.dead && show){
    if (frameCount%wait==0){
      float[] ins = game.inputs();
      float[] outs = net.genomes[0].activate(ins);
      if (outs[0]>=0.5){
        game.press('a');
      }
      else if (outs[1]>=0.5){
        game.press('w');
      }
      else if (outs[2]>=0.5){
        game.press('d');
      }
      else if (outs[3]>=0.5){
        game.press('s');
      }
      game.move();
    }
    game.show();
  }
  else{
    for (Genome gen : net.genomes){
      game = new Game();
      while (!game.dead){
        float[] ins = game.inputs();
        float[] outs = gen.activate(ins);
        if (outs[0]>=0.5){
          game.press('a');
        }
        else if (outs[1]>=0.5){
          game.press('w');
        }
        else if (outs[2]>=0.5){
          game.press('d');
        }
        else if (outs[3]>=0.5){
          game.press('s');
        }
        game.move();
      }
      gen.score = pow(game.head.body.size(),2);
    }
    net.select(true);
    game = new Game();
  }
}

void keyPressed(){
  //game.press(key);
  if (key==' '){
    show = !show;
  }
}
