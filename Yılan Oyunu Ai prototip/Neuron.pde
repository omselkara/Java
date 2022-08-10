class Neuron{
  float bias,value;
  Layer layer;
  int index;
  ArrayList<Weight> weights;
  Neuron (Layer layer,int index){
    bias = random(-3,+3);
    this.layer = layer;
    this.index = index;
    value = 0;
    weights = new ArrayList<Weight>();
  }

  void connect(Neuron to_neuron){
    to_neuron.weights.add(new Weight(this,to_neuron));
  }

  void activate(){
    value = bias;
    for (Weight i : weights){
      i.activate();
    }
    value = tanh(value/sqrt(max(1,weights.size()+1)));
  }

  /*def get_detailed_schema(this):
      schema = [this.index,this.bias,[]]
      for weight in this.weights:
          schema[-1].append([[weight.from_neuron.layer.layer_type,weight.from_neuron.layer.index,weight.from_neuron.index],#[weight.to_neuron.layer.layer_type,weight.to_neuron.layer.index,weight.to_neuron.index]
          weight.weight])
      return schema
  
  def apply_detailed_schema(this,schema):
      this.weights = []
      for i in range(len(schema)):
          if schema[i][0][0]=="Inputs":
              from_neuron = this.layer.genome.layers["Inputs"].neurons[schema[i][0][2]]
          else:
              from_neuron = this.layer.genome.layers["Hiddens"][schema[i][0][1]].neurons[schema[i][0][2]]
          weight = Weight(from_neuron,this)
          weight.weight = schema[i][1]
          this.weights.append(weight)
  */
}
