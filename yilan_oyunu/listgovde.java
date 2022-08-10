public class listgovde{
  private /**/yilan_oyunu.govde[] list;
  public int length;
  listgovde(/**/yilan_oyunu.govde[] list){
    this.list = list;
    this.length = list.length;
  }
  public /**/yilan_oyunu.govde get(int index){
    if (index<this.length){
      return list[index];
    }
    else {
      System.out.println("IndexError: list index out of range");
      return list[0];
    }
  }
  public void set(int index,/**/yilan_oyunu.govde element){
    if (index<this.length){
      list[index] = element;
    }
    else{
      System.out.println("IndexError: list index out of range");
    }
  }
  public void add(int index, /**/yilan_oyunu.govde element){
    if (index<this.length){
      /**/yilan_oyunu.govde[] backup = list;
      list = new /**/yilan_oyunu.govde[this.length+1];
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
  public void append(/**/yilan_oyunu.govde element){
    /**/yilan_oyunu.govde[] backup = list;
    list = new /**/yilan_oyunu.govde[this.length+1];
    for (int i=0;i<this.length;i++){
      list[i] = backup[i];
    }
    list[this.length] = element;
    this.length++;
  }
  public void remove(int index){
    /**/yilan_oyunu.govde[] backup = list;
    list = new /**/yilan_oyunu.govde[this.length-1];
    for (int i=0;i<index;i++){
      list[i] = backup[i];
    }
    for (int i=index+1;i<this.length;i++){
      list[i-1] = backup[i];      
    }
    this.length--;
  }
  public void clear(){
    list = new /**/yilan_oyunu.govde[0];
    this.length=0;
  }
  public int index(/**/yilan_oyunu.govde element){
    for (int i=0;i<this.length;i++){
      if (list[i]==element){
        return i;
      }
    }
    return 0;
  }
}
