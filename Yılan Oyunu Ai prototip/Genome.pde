Genome fake_genome = new Genome(1,1,1,true);
Layer fake_layer = new Layer(fake_genome,"a",0,0);
Neuron fake_neuron = new Neuron(fake_layer,0);
Weight fake_weight = new Weight(fake_neuron,fake_neuron);

int choice(int min,int max){ // dahil değil
  return (int) random(min,max);
}

class Genome{
  float score;
  int input,output;
  Layer Inputs,Outputs;
  ArrayList<Layer> Hiddens;
  // baby = false
  Genome(int input,int hidden,int output,boolean baby){
    score = 0;
    this.input = input;
    this.output = output;
    Inputs = new Layer(this,"Inputs",0,input);
    Hiddens = new ArrayList<Layer>();
    Hiddens.add(new Layer(this,"Hiddens",0,hidden));
    Outputs = new Layer(this,"Outputs",0,this.output);
    if (!baby){
      mutate(hidden+input+output,true);
    }
  }
  // connect = false
  //repeat = 1
  void mutate(int repeat,boolean connect){
    for (int i=0;i<repeat;i++){
      //add neuron
      if (random(0,1)<=0.01){
        if (random(0,1)<0.1/Hiddens.size()){
          Hiddens.add(new Layer(this,"Hiddens",Hiddens.size(),1));
        }
        else{
          int layer = choice(0,Hiddens.size());
          Hiddens.get(layer).add_neuron();
        }
      }
      //connect neurons
      if ((random(0,1)<=0.2 && !connect) || (random(0,1)<0.75 && connect)){
        int layer_index1 = (int) random(0,Hiddens.size()+1);
        int layer_index2 = layer_index1+((int) random(0,Hiddens.size()-layer_index1));
        Layer layer1;
        Layer layer2;
        if (layer_index1==0){
          layer1 = Inputs;
        }
        else{
          layer1 = Hiddens.get(layer_index1-1);
        }
        if (layer_index2==Hiddens.size()){
          layer2 = Outputs;
        }
        else{
          layer2 = Hiddens.get(layer_index2);
        }
        Neuron neuron1 = layer1.neurons.get(choice(0,layer1.neurons.size()));
        Neuron neuron2 = layer2.neurons.get(choice(0,layer2.neurons.size()));
        neuron1.connect(neuron2);
      }
      //cut connect neurons
      if (random(0,1)<=0.05){
        int layer_index = (int) random(0,Hiddens.size()+1);
        Layer layer;
        if (layer_index==Hiddens.size()){
          layer = Outputs;
        }
        else{
          layer = Hiddens.get(layer_index);
        }
        Neuron neuron = layer.neurons.get(choice(0,layer.neurons.size()));
        if (neuron.weights.size()>0){
          int index = (int)random(0,neuron.weights.size());
          neuron.weights.remove(neuron.weights.get(index));
        }
      }
      //bias mutate    
      if (random(0, 1)<0.15){
        int layer_index = (int)random(0,Hiddens.size()+1);
        Layer layer;
        if (layer_index==Hiddens.size()){
          layer = Outputs;
        }
        else{
          layer = Hiddens.get(layer_index);
        }
        Neuron neuron = layer.neurons.get(choice(0,layer.neurons.size()));
        neuron.bias += random(-0.5,+0.5);
      }
      //bias mutate
      else if (random(0, 1)<0.1){
        int layer_index = (int) random(0,Hiddens.size()+1);
        Layer layer;
        if (layer_index==Hiddens.size()){
          layer = Outputs;
        }
        else{
          layer = Hiddens.get(layer_index);
        }
        Neuron neuron = layer.neurons.get(choice(0,layer.neurons.size()));
        neuron.bias = random(-3,+3);
      }
      //bias mutate
      else if (random(0, 1)<0.05){
        int layer_index = (int) random(0,Hiddens.size()+1);
        Layer layer;
        if (layer_index==Hiddens.size()){
          layer = Outputs;
        }
        else{
          layer = Hiddens.get(layer_index);
        }
        Neuron neuron = layer.neurons.get(choice(0,layer.neurons.size()));
        neuron.bias = 0;
      }
      //weight mutation
      if (random(0, 1)<0.15){
        int layer_index = (int) random(0,Hiddens.size()+1);
        Layer layer;
        if (layer_index==Hiddens.size()){
          layer = Outputs;
        }
        else{
          layer = Hiddens.get(layer_index);
        }
        Neuron neuron = layer.neurons.get(choice(0,layer.neurons.size()));
        if (neuron.weights.size()>0){
          Weight weight = neuron.weights.get(choice(0,neuron.weights.size()));
          weight.weight += random(-0.5,+0.5);
        }
      }
      //weight mutation
      else if (random(0, 1)<0.15){
        int layer_index = (int) random(0,Hiddens.size()+1);
        Layer layer;
        if (layer_index==Hiddens.size()){
          layer = Outputs;
        }
        else{
          layer = Hiddens.get(layer_index);
        }
        Neuron neuron = layer.neurons.get(choice(0,layer.neurons.size()));
        if (neuron.weights.size()>0){
          Weight weight = neuron.weights.get(choice(0,neuron.weights.size()));
          weight.weight += random(-0.5,+0.5);
        }
      }
      //weight mutation
      else if (random(0, 1)<0.15){
        int layer_index = (int) random(0,Hiddens.size()+1);
        Layer layer;
        if (layer_index==Hiddens.size()){
          layer = Outputs;
        }
        else{
          layer = Hiddens.get(layer_index);
        }
        Neuron neuron = layer.neurons.get(choice(0,layer.neurons.size()));
        if (neuron.weights.size()>0){
          Weight weight = neuron.weights.get(choice(0,neuron.weights.size()));
          weight.weight += random(-0.5,+0.5);
        }
      }
    }
  }
  
  float[] activate(float[] inputs){
    for (int i=0;i<Inputs.neurons.size();i++){
      Inputs.neurons.get(i).value = inputs[i];
    }
    for (Layer i : Hiddens){
      i.activate();
    }
    float[] outputs = new float[output];
    int index = 0;
    for (Neuron i : Outputs.neurons){
      i.activate();
      outputs[index] = i.value;
      index++;
    }
    return outputs;
  }
  //a=0
  Genome generate_baby(Genome parent,int a){
    Genome bestparent,otherparent;
    if (score>parent.score){
      bestparent = this;
      otherparent = parent;
    }
    else{
      bestparent = parent;
      otherparent = this;
    }
    float score1 = bestparent.score;
    float score2 = otherparent.score;
    if (score2<0){
      float add = abs(score1)+abs(score2);
      score1 += add;
      score2 += add;
    }
    score1 += 0.000001;
    score2 += 0.000001;
    //selecting best probability
    float probability = 1.-(score1/(score1+score2));
    Genome baby = new Genome(this.input,0,this.output,true);
    baby.Hiddens = new ArrayList<Layer>();
    for (int layer_index=0;layer_index<bestparent.Hiddens.size();layer_index++){
      Layer layerbest = bestparent.Hiddens.get(layer_index);
      Layer layerbaby = new Layer(baby,"Hiddens",layer_index,0);
      baby.Hiddens.add(layerbaby);
      Boolean islayerother = false;
      Layer layerother = fake_layer;
      if (otherparent.Hiddens.size()>layer_index){
        islayerother = true;
        layerother = otherparent.Hiddens.get(layer_index);
      }
      for (int neuron_index=0;neuron_index<layerbest.neurons.size();neuron_index++){
        Neuron neuronbest = layerbest.neurons.get(neuron_index);
        Neuron neuronbaby = new Neuron(layerbaby,neuron_index);
        layerbaby.neurons.add(neuronbaby);
        boolean isneuronother = false;
        Neuron neuronother = fake_neuron;
        if (islayerother && layerother.neurons.size()>neuron_index){
          isneuronother = true;
          neuronother = layerother.neurons.get(neuron_index);
        }
        if (!isneuronother){
          neuronbaby.bias = neuronbest.bias;
        }
        else{
          neuronbaby.bias = neuronbest.bias+(neuronother.bias-neuronbest.bias)*probability*0.1;
        }
        for (int weight_index=0;weight_index<neuronbest.weights.size();weight_index++){
          Weight weightbest = neuronbest.weights.get(weight_index);
          boolean isweightother = false;
          Weight weightother = fake_weight;
          if (isneuronother && neuronother.weights.size()>weight_index){
            isweightother = true;
            weightother = neuronother.weights.get(weight_index);
          }
          if (!isweightother || weightother.from_neuron.layer.index>=bestparent.Hiddens.size() ||
          (weightother.from_neuron.layer.layer_type=="Hiddens" && weightother.from_neuron.index>=bestparent.Hiddens.get(weightother.from_neuron.layer.index).neurons.size()) ||
          (weightother.from_neuron.layer.layer_type=="Inputs" && weightother.from_neuron.index>=bestparent.Inputs.neurons.size())){
            Neuron from_neuron;
            if (weightbest.from_neuron.layer.layer_type=="Hiddens"){
              from_neuron = baby.Hiddens.get(weightbest.from_neuron.layer.index).neurons.get(weightbest.from_neuron.index);
            }
            else{
              from_neuron = baby.Inputs.neurons.get(weightbest.from_neuron.index);
            }
            from_neuron.connect(neuronbaby);
            neuronbaby.weights.get(neuronbaby.weights.size()-1).weight = weightbest.weight;
          }
          else{
            Neuron from_neuron;
            if (weightother.from_neuron.layer.layer_type=="Hiddens"){
              from_neuron = baby.Hiddens.get(weightother.from_neuron.layer.index).neurons.get(weightother.from_neuron.index);
            }
            else{
              from_neuron = baby.Inputs.neurons.get(weightother.from_neuron.index);
            }
            from_neuron.connect(neuronbaby);
            neuronbaby.weights.get(neuronbaby.weights.size()-1).weight = weightbest.weight+(weightother.weight-weightbest.weight)*probability*0.1;
          }
        }
      }
    }
    for (int neuron_index=0;neuron_index<output;neuron_index++){
      Neuron neuronbest = bestparent.Outputs.neurons.get(neuron_index);
      Neuron neuronother = otherparent.Outputs.neurons.get(neuron_index);
      Neuron neuronbaby = baby.Outputs.neurons.get(neuron_index);
      neuronbaby.bias = neuronbest.bias+(neuronother.bias-neuronbest.bias)*probability*0.1;
      for (int weight_index=0;weight_index<neuronbest.weights.size();weight_index++){
        Weight weightbest = neuronbest.weights.get(weight_index);
        boolean isweightother = false;
        Weight weightother = fake_weight;
        if (weight_index<neuronother.weights.size()){
          weightother = neuronother.weights.get(weight_index);
        }
        if (!isweightother || weightother.from_neuron.layer.index>=bestparent.Hiddens.size() ||
        (weightother.from_neuron.layer.layer_type=="Hiddens" && weightother.from_neuron.index>=bestparent.Hiddens.get(weightother.from_neuron.layer.index).neurons.size()) ||
        (weightother.from_neuron.layer.layer_type=="Inputs" && weightother.from_neuron.index>=bestparent.Inputs.neurons.size())){
          Neuron from_neuron;
          if (weightbest.from_neuron.layer.layer_type=="Hiddens"){
            from_neuron = baby.Hiddens.get(weightbest.from_neuron.layer.index).neurons.get(weightbest.from_neuron.index);
          }
          else{
            from_neuron = baby.Inputs.neurons.get(weightbest.from_neuron.index);
          }
          from_neuron.connect(neuronbaby);
          neuronbaby.weights.get(neuronbaby.weights.size()-1).weight = weightbest.weight;
        }
        else{
          Neuron from_neuron;
          if (weightother.from_neuron.layer.layer_type=="Hiddens"){
            from_neuron = baby.Hiddens.get(weightother.from_neuron.layer.index).neurons.get(weightother.from_neuron.index);
          }
          else{
            from_neuron = baby.Inputs.neurons.get(weightother.from_neuron.index);
          }
          from_neuron.connect(neuronbaby);
          neuronbaby.weights.get(neuronbaby.weights.size()-1).weight = weightbest.weight+(weightother.weight-weightbest.weight)*probability*0.1;
        }
      }
    }
    return baby;
  }

  /*def get_schema(this):
      layers = [this.input]
      for i in this.layers["Hiddens"]:
          layers.append(len(i.neurons))
      layers.append(this.output)
      return layers

  def get_detailed_schema(this):
      schema = []
      schema.append(this.layers["Inputs"].get_detailed_schema())
      schema.append([])
      for layer in this.layers["Hiddens"]:
          schema[1].append(layer.get_detailed_schema())
      schema.append(this.layers["Outputs"].get_detailed_schema())
      return schema
  
  def apply_detailed_schema(this,schema):
      this.layers["Hiddens"] = []
      this.layers["Inputs"].apply_detailed_schema(schema[0])
      for i in range(len(schema[1])):
          layer = Layer(this,schema[1][i][0],schema[1][i][1],0)
          layer.apply_detailed_schema(schema[1][i])
          this.layers["Hiddens"].append(layer)
      this.layers["Outputs"].apply_detailed_schema(schema[2])
  */
}
