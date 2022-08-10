class Layer{
  Genome genome;
  String layer_type;
  int index;
  ArrayList<Neuron> neurons;
  Layer(Genome genome,String layer_type,int index,int neuron_count){
    this.genome = genome;
    this.layer_type = layer_type;
    this.index = index;
    neurons = new ArrayList<Neuron>();
    for (int i=0;i<neuron_count;i++){
      neurons.add(new Neuron(this,i));
    }
  }
  
  void add_neuron(){
    neurons.add(new Neuron(this,neurons.size()));
  }

  void activate(){
    for (Neuron i : neurons){
      i.activate();
    }
  }

  /*def get_detailed_schema(this):
      schema = [this.layer_type,this.index]
      for neuron in this.neurons:
          schema.append(neuron.get_detailed_schema())
      return schema
  
  def apply_detailed_schema(this,schema):
      this.neurons = []
      for i in range(2,len(schema)):
          neuron = Neuron(this,schema[i][0])
          neuron.bias = schema[i][1]
          neuron.apply_detailed_schema(schema[i][2])
          this.neurons.append(neuron)
  */
}
                

    
