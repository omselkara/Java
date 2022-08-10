public class listgenome{
  private /**/my_neat.genome[] list;
  public int length;
  listgenome(/**/my_neat.genome[] list){
    this.list = list;
    this.length = list.length;
  }
  public /**/my_neat.genome get(int index){
    if (index<this.length){
      return list[index];
    }
    else {
      System.out.println("IndexError: list index out of range");
      return list[0];
    }
  }
  public void set(int index,/**/my_neat.genome element){
    if (index<this.length){
      list[index] = element;
    }
    else{
      System.out.println("IndexError: list index out of range");
    }
  }
  public void add(int index, /**/my_neat.genome element){
    if (index<this.length){
      /**/my_neat.genome[] backup = list;
      list = new /**/my_neat.genome[this.length+1];
      for (int i=0;i<index;i++){
        list[i] = backup[i];
      }
      list[index] = element;
      for (int i=index;i<this.length;i++){
        list[i+1] = backup[i];
      }
      this.length++;
    }
    else{
      System.out.println("IndexError: list index out of range");
    }
  }
  public void append(/**/my_neat.genome element){
    /**/my_neat.genome[] backup = list;
    list = new /**/my_neat.genome[this.length+1];
    for (int i=0;i<this.length;i++){
      list[i] = backup[i];
    }
    list[this.length] = element;
    this.length++;
  }
  public void remove(int index){
    /**/my_neat.genome[] backup = list;
    list = new /**/my_neat.genome[this.length-1];
    for (int i=0;i<index;i++){
      list[i] = backup[i];
    }
    for (int i=index+1;i<this.length;i++){
      list[i-1] = backup[i];      
    }
    this.length--;
  }
  public void clear(){
    list = new /**/my_neat.genome[0];
    this.length=0;
  }
  public int index(/**/my_neat.genome element){
    for (int i=0;i<this.length;i++){
      if (list[i]==element){
        return i;
      }
    }
    return 0;
  }
}
