genome randomizer(genome[] selectfrom, float[][] probs) {
  float number = random(1);
  for (int i=0; i<probs.length; i++) {
    if (number>=probs[i][0] && number<probs[i][1]) {
      return selectfrom[i];
    }
  }
  return selectfrom[selectfrom.length-1];
}
float sum(float[] list) {
  float value = 0;
  for (float i : list) {
    value += i;
  }
  return value;
}
float[][] calc_probs(float[] list) {
  float[][] probs = new float[list.length][];
  float value = sum(list);
  float lastmax = 0;
  for (int i=0; i<list.length; i++) {
    float newmax = list[i]/value;
    probs[i] = new float[] {lastmax, lastmax+newmax};
    lastmax += newmax;
  }
  return probs;
}
int argmax(float[] list) {
  float maxim = list[0];
  int yer = 0;
  for (int i=1; i<list.length; i++) {
    if (list[i]>maxim) {
      maxim = list[i];
      yer = i;
    }
  }
  return yer;
}
class network {
  int input, output, pop, gen;
  genome[] genomes;
  float weight_range;
  network(int input, int output, int pop, float weight_range) {
    this.input = input;
    this.output = output;
    this.pop = pop;
    genomes = new genome[pop];
    this.weight_range = weight_range;
    for (int i=0; i<pop; i++) {
      genomes[i] = new genome(input, output, weight_range, false);
    }
    gen = 0;
  }
  genome select() {
    float[] prob = new float[pop];
    float best = Float.NEGATIVE_INFINITY;
    int yer = 0;
    int sayi = 0;
    for (genome i : genomes) {
      prob[sayi] = i.fitness*100;
      if (best<i.fitness) {
        best = i.fitness;
        yer = sayi;
      }
      i.fitness = 0;
      sayi++;
    }
    float[][] probs = calc_probs(prob);
    genome[] newgenomes = new genome[pop];
    for (int i=0; i<pop; i++) {
      if (i!=yer) {
        genome select;
        if (random(0, 100)<10) {
          select = new genome(input, output, weight_range, false);
          for (int a=0; a<gen; a++) {
            select.mutate();
          }
        } else {
          select = randomizer(genomes, probs);
          //select = this.genomes[i].cross_over(select);
          select = select.get_clone();
        }
        for (int a=0; a<10; a++) {
          select.mutate();
        }
        newgenomes[i] = select;
      } else {
        newgenomes[i] = genomes[yer];
      }
    }
    genome best_genome = genomes[yer];
    this.genomes = newgenomes;
    println("Gen:"+str(this.gen)+"  Best:"+str(best));
    this.gen++;
    return best_genome;
  }
}
