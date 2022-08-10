class net{
  listgenome genomes;
  int input,output,sayi;
  net(int input,int output,int pop){
    this.genomes = new listgenome(new genome[0]);
    this.input = input;
    this.output = output;
    this.sayi = pop+1;
    for (int i=0;i<pop;i++){
      this.genomes.append(new genome(this.input,this.output,i));
      this.sayi++;
    }
  }
  void newgenome(int index){
    this.genomes.append(new genome(this.input,this.output,index));
    this.sayi++;
  }
  void train(float[][] inputs,float[][] outputs,int step){
    for (int i=0;i<this.genomes.length;i++){
      this.genomes.get(i).sayi = 1;
      this.genomes.get(i).last = 0;
      this.genomes.get(i).fitness = 0;
    }
    int s=0;
    for (int _=0;_<step;_++){
      for (int i=0;i<this.genomes.length;i++){
        float loss=0;
        for (int ad=0;ad<inputs.length;ad++){
          float[] output;
          output = this.genomes.get(i).output(inputs[ad]);
          for (s=0;s<outputs.length;s++){
            loss += outputs[ad][s]-output[s];
          }
        }
        if (loss>0){
          if (this.genomes.get(i).last == -1){
            this.genomes.get(i).sayi = (this.genomes.get(i).sayi*3)/random(3,6);
          }
          this.genomes.get(i).last = 1;
          for (int d=0;d<this.input;d++){
            this.genomes.get(i).cons.get(s)[d].weigth += this.genomes.get(i).sayi;
            this.genomes.get(i).cons.get(s)[d].bias += this.genomes.get(i).sayi;
          }
        }
        if (loss<0){
          if (this.genomes.get(i).last == -1){
            this.genomes.get(i).sayi = (this.genomes.get(i).sayi*3)/random(3,6);
          }
          this.genomes.get(i).last = 1;
          for (int d=0;d<this.input;d++){
            this.genomes.get(i).cons.get(s)[d].weigth -= this.genomes.get(i).sayi;
            this.genomes.get(i).cons.get(s)[d].bias -= this.genomes.get(i).sayi;
          }
        }
      }
    }
  }
  void kill(){
    int[] genom= new int[this.genomes.length];
    int a=0;
    while (genom.length!=this.genomes.length){
      int fitness = 1000000000;
      int yer = 0;
      for (int i=0;i<this.genomes.length;i++){
        if (this.genomes.get(i).fitness<fitness){
          yer = this.genomes.get(i).yer;
        }
      }
      genom[a] = yer;
      a++;
    }
    for (int i=0;i<int(this.genomes.length/10);i++){
      newgenome(genom[i]);
    }
  }
}
