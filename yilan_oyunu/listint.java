public class listint{
  private /**/int[][] list;
  public int length;
  listint(/**/int[][] list){
    this.list = list;
    this.length = list.length;
  }
  public /**/int[] get(int index){
    if (index<this.length){
      return list[index];
    }
    else {
      System.out.println("IndexError: list index out of range");
      return list[0];
    }
  }
  public void set(int index,/**/int[] element){
    if (index<this.length){
      list[index] = element;
    }
    else{
      System.out.println("IndexError: list index out of range");
    }
  }
  public void add(int index, /**/int[] element){
    if (index<this.length){
      /**/int[][] backup = list;
      list = new /**/int[this.length+1][3];
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
  public void append(/**/int[] element){
    /**/int[][] backup = list;
    list = new /**/int[this.length+1][3];
    for (int i=0;i<this.length;i++){
      list[i] = backup[i];
    }
    list[this.length] = element;
    this.length++;
  }
  public void remove(int index){
    /**/int[][] backup = list;
    list = new /**/int[this.length-1][3];
    for (int i=0;i<index;i++){
      list[i] = backup[i];
    }
    for (int i=index+1;i<this.length;i++){
      list[i-1] = backup[i];      
    }
    this.length--;
  }
  public void clear(){
    list = new /**/int[0][3];
    this.length=0;
  }
  public int index(/**/int[] element){
    for (int i=0;i<this.length;i++){
      if (list[i]==element){
        return i;
      }
    }
    return 0;
  }
}
