class node {
  int type,name,layer,index,connected;
  float weight_range,x,y,value;
  ArrayList<conn> conns;
  ArrayList<Integer> conn_indexes;
  node(int type,int name,float weight_range) {
    this.type = type;
    this.name = name;
    x = 0;
    y = 0;
    conns = new ArrayList<conn>();
    conn_indexes = new ArrayList<Integer>();
    value = 0;
    this.weight_range = weight_range;
    if (type==types.bias) {
      value = random(-weight_range, +weight_range);
    }
    layer = 0;
    index = 0;
    connected = 0;
  }
  float activate() {
    if (type==types.output) {
      value = activation(value);
    }
    else {
      for (conn i : conns) {
        i.activate();
      }
    }
    return value;
  }
  void mutate() {
    if (type==types.bias) {
      if (type!=types.input && type!=types.bias){
        value = activation(this.value);
      }
      if (type!=types.output){
        value = random(-this.weight_range, +this.weight_range);
      } 
      else {
        value += randomGaussian()/50;
      }
    }
  }
}
static class types{
  static final int input = 0;
  static final int bias = 1;
  static final int hidden = 2;
  static final int output = 3;
}
