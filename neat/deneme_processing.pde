int col = 32, row = 32;
game board;
network net;
boolean show = true;
genome gen;
float best = 0;
void setup() {
  size(1200, 800);
  randomSeed(10);
  board = new game(true, millis());
  board.dead = true;
  frameRate(Float.POSITIVE_INFINITY);
  net = new network(10, 4, 10000, 30);
}
void draw() {
  background(255);
  if (board.dead || !show) {
    float thisbest = -1;
    float seed = 0;
    int best_gen = -1;
    for (int i=0; i<net.pop; i++) {
      board = new game(true, millis());
      while (!board.dead) {
        float[] inputs = board.inputs();
        float[] out = net.genomes[i].activate(inputs);
        if (out[0]>0.5) {
          board.press(faces.up);
        } else if (out[1]>0.5) {
          board.press(faces.right);
        } else if (out[2]>0.5) {
          board.press(faces.down);
        } else if (out[3]>0.5) {
          board.press(faces.left);
        }
        board.move();
      }
      net.genomes[i].fitness = pow(2, board.bodies.size()-3)*100+(500-board.count)/10;
      if (board.bodies.size()-3>best) {
        best = board.bodies.size()-3;
      }
      if (board.bodies.size()-3>best_gen) {
        best_gen = board.bodies.size()-3;
      }
      if (net.genomes[i].fitness>thisbest) {
        thisbest = net.genomes[i].fitness;
        seed = board.seed;
      }
    }
    gen = net.select();
    board = new game(true, seed);
    startlimit += artis;
    println(best_gen);
  }
  if (show) {
    float[] inputs = board.inputs();
    float[] out = gen.activate(inputs);
    if (out[0]>0.5) {
      board.press(faces.up);
    } else if (out[1]>0.5) {
      board.press(faces.right);
    } else if (out[2]>0.5) {
      board.press(faces.down);
    } else if (out[3]>0.5) {
      board.press(faces.left);
    }
    board.show(0, 0, 800, 800);
    gen.show_genome(800, 0, 400, 800, 10);
    textAlign(LEFT, CENTER);
    textSize(50);
    fill(0);
    text("Score:"+str(board.bodies.size()-3), 0, 750);
  } else {
    gen.show_genome(0, 0, width, height, 10);
  }
  textAlign(LEFT, CENTER);
  textSize(50);
  fill(0);
  text("Generation:"+str(net.gen), 0, 650);
  text("Best:"+str(best), 0, 700);
}
void keyPressed() {
  //board.press(key);
  if (key==' ') {
    show = !show;
  }
}
