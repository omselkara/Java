float sinh(float z){
  float e;
  e = 2.7169239322355936;
  return (pow(e,z)-pow(e,-z))/2;
}
float cosh(float z){
  float e;
  e = 2.7169239322355936;
  return (pow(e,z)+pow(e,-z))/2;
}
float tanh(float z){
  return sinh(z)/cosh(z);
}
