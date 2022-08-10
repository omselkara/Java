class genome{
  int input,outputs,last,yer,fitness;
  float sayi;
  listconn cons;
  genome(int input,int output,int yer){
    this.cons = new listconn(new conn[0][]);
    this.input = input;
    this.outputs = output;
    this.sayi = 1;
    this.last = 0;
    this.fitness = 0;
    this.yer = yer;
    for (int i=0;i<this.outputs;i++){
      this.cons.append(new conn[input]);
      for (int a=0;a<this.input;a++){
        this.cons.append(new conn[this.input]);
      }
    }
  }
  float[] output(float[] inputs){
    float[] list = new float[this.outputs];
    for (int i=0;i<this.outputs;i++){
      float sum=0;
      for (int a=0;a<this.input;a++){
        sum += this.cons.get(i)[a].out(inputs[a]);
      }
      list[i] = tanh(sum);
    }
    return list;
  }
}
