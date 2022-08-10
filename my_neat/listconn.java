public class listconn{
  private /**/my_neat.conn[][] list;
  public int length;
  listconn(/**/my_neat.conn[][] list){
    this.list = list;
    this.length = list.length;
  }
  public /**/my_neat.conn[] get(int index){
    if (index<this.length){
      return list[index];
    }
    else {
      System.out.println("IndexError: list index out of range");
      return list[0];
    }
  }
  public void set(int index,/**/my_neat.conn[] element){
    if (index<this.length){
      list[index] = element;
    }
    else{
      System.out.println("IndexError: list index out of range");
    }
  }
  public void add(int index, /**/my_neat.conn[] element){
    if (index<this.length){
      /**/my_neat.conn[][] backup = list;
      list = new /**/my_neat.conn[this.length+1][100000];
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
  public void append(/**/my_neat.conn[] element){
    /**/my_neat.conn[][] backup = list;
    list = new /**/my_neat.conn[this.length+1][100000];
    for (int i=0;i<this.length;i++){
      list[i] = backup[i];
    }
    list[this.length] = element;
    this.length++;
  }
  public void remove(int index){
    /**/my_neat.conn[][] backup = list;
    list = new /**/my_neat.conn[this.length-1][100000];
    for (int i=0;i<index;i++){
      list[i] = backup[i];
    }
    for (int i=index+1;i<this.length;i++){
      list[i-1] = backup[i];      
    }
    this.length--;
  }
  public void clear(){
    list = new /**/my_neat.conn[0][100000];
    this.length=0;
  }
  public int index(/**/my_neat.conn[] element){
    for (int i=0;i<this.length;i++){
      if (list[i]==element){
        return i;
      }
    }
    return 0;
  }
}
