class Weight{
  Neuron from_neuron,to_neuron;
  float weight;
  Weight(Neuron from_neuron,Neuron to_neuron){
    this.from_neuron = from_neuron;
    this.to_neuron = to_neuron;
    weight = random(-3,+3);
  }

  void activate(){
    to_neuron.value += (from_neuron.value*weight);
  }
}
