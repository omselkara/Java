float[][] calc_probability(Genome[] genomes){
  float[] scores = new float[genomes.length];
  for (int i=0;i<genomes.length;i++){
    scores[i] = genomes[i].score;
  }
  float min_score = min(scores);
  float add = 0.000001;
  if (min_score<0){
    add -= min_score;
  }
  float sum_scores = sum(scores)+scores.length*add;
  float prev = 0;
  float[][] probabilities = new float[scores.length][2];
  int index = 0;
  for (float i : scores){
    float now = prev+(i+add)/sum_scores;
    probabilities[index] = new float[] {prev,now};
    prev = now;
    index++;
  }
  probabilities[probabilities.length-1][1] = 1.;
  return probabilities;
}

int selector(float[][] probabilities){
  float value = random(0,1);
  for (int i=0;i<probabilities.length;i++){
      if (value>=probabilities[i][0] && value<probabilities[i][1]){
        return i;
      }
  }
  return probabilities.length-1;
}
    
float sum(float[] scores){
  float value = 0;
  for (float i : scores){
    value += i;
  }
  return value;
}
