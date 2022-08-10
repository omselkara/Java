class conn {
  node from,to;
  float weight,weight_range;
  boolean enabled;
  conn(node from,node to,float weight_range) {
    this.from = from;
    this.to = to;
    weight = random(-weight_range, +weight_range);
    enabled = true;
    this.weight_range = weight_range;
  }
  void mutate() {
    if (random(0, 100)<5) {
      enabled = !this.enabled;
    }
    else if (random(0, 100)<5) {
      weight = random(-this.weight_range, +this.weight_range);
    } 
    else {
      weight += randomGaussian()/50;
    }
  }
  void activate() {
    if (this.enabled) {
      this.to.value += this.from.value*this.weight;
    }
  }
}
