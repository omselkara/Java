float depth = 12;
boolean player;
int[] calculated;
int sumcalc;
int minmax(int step,int x,int a,int b){
  if (step==0){
    player = redtomove;
  }
  else{
    int value = checkboard(x);
    if (value!=0){
      int stone = redtomove ? yellowstone : redstone;
      if (redtomove==player){
        return (stone)-22;
      }
      return 22-(stone);
    }
  }
  if (step>=floor(depth)){
    return 0;
  }
  boolean ismax = step%2==0;
  int best = int(Float.POSITIVE_INFINITY);
  int yer = 0;
  if (ismax){
    best = -best;
  }
  for (int i=0;i<7;i++){
    if (heights[i]!=6){
      calculated[step]++;
      click(i);
      int score = minmax(step+1,i,a,b);
      if (ismax){
        if (score>best){
          best = score;
          yer = i;
          if (score>a){
            a = score;
          }
        }
      }
      else{
        if (score<best){
          best = score;
          yer = i;
          if (score<b){
            b = score;
          }
        }
      }
      undo(i);
      if (a>=b){
        break;
      }
    }
  }
  if (step==0){
    return yer;
  }
  return best;
}
void ai(){
  cursor(WAIT);
  float an = millis();
  calculated = new int[int(depth)];
  sumcalc = 0;
  int x = minmax(0,0,int(Float.NEGATIVE_INFINITY),int(Float.POSITIVE_INFINITY));
  click(x);
  win = checkboard(x)!=0;
  draw = checkboard(x)==-1;
  println(calculated);
  println((millis()-an)/1000);
  cursor(ARROW);
}
