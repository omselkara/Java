class conn{
  float weigth,bias;
  conn(){
    this.weigth = random(-30,30);
    this.bias = random(-30,30);
  }
  float out(float sayi){
    return sayi*this.weigth+this.bias;
  }
}
