class Network{
  int input,hidden,output,pop,generation;
  Genome[] genomes;
  Network(int input,int hidden,int output,int pop){
    this.input = input;
    this.hidden = hidden;
    this.output = output;
    this.pop = pop;
    this.generation = 0;
    genomes = new Genome[pop];
    for (int i=0;i<pop;i++){
      genomes[i] = new Genome(input,hidden,output,false);
    }
  }

  // show_best = true 
  Genome select(boolean show_best){
    float[][] probs = calc_probability(genomes);
    Genome[] newgenomes = new Genome[pop];
    Genome best = genomes[0];
    float rate = (pop/100.)*5.;
    for (int i=0;i<pop;i++){
      Genome gen = genomes[i];
      if (gen.score>best.score || (gen.score==best.score && random(0,1)<0.25)){
        best = gen;
      }
      int index = selector(probs);
      Genome parent1 = genomes[index];
      index = selector(probs);
      Genome parent2 = genomes[index];
      Genome newgenome = parent1.generate_baby(parent2,0);
      newgenome.mutate(1,false);
      newgenomes[i] = newgenome;
    }
    if (show_best){
      println("Generation:",generation,"   Best Score:",best.score);//,"   Schema:",best.get_schema());
    }
    generation += 1;
    best.score = 0;
    newgenomes[0] = best;
    genomes = newgenomes;
    return best;
  }
  
  /*def save(this,name="save.npz"):
      schema = [this.genereation,[]]
      for gen in this.genomes:
          schema[1].append(gen.get_detailed_schema())
      schema = np.array(schema,dtype=object)
      file = open(name,"wb")
      np.save(file,schema,allow_pickle=True)
  
  def load(this,name="save.npz"):
      file = open(name,"rb")
      schema = np.load(file,allow_pickle=True)
      this.genereation = schema[0]
      for i in range(this.pop):
          print(f"Loading Genome:{i}")
          this.genomes[i].apply_detailed_schema(schema[1][i])
  */
}
