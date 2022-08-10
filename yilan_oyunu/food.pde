class food{
  int x,y;
  void create(){
    this.x = int(random(0,26));
    this.y = int(random(0,14));
  }
  void display(){
    check();
    rectangle(xhesap(this.x)+20,yhesap(this.y),xhesap(this.x)+30,yhesap(this.y)+20,34,177,76);
    rectangle(xhesap(this.x)+20,yhesap(this.y)+30,xhesap(this.x)+30,yhesap(this.y)+50,34,177,76);
    rectangle(xhesap(this.x),yhesap(this.y)+20,xhesap(this.x)+20,yhesap(this.y)+30,34,177,76);
    rectangle(xhesap(this.x)+30,yhesap(this.y)+20,xhesap(this.x)+50,yhesap(this.y)+30,34,177,76);
  }
  private void check(){
    if (list.get(0).x == this.x && list.get(0).y == this.y){
      create();
      int x = list.get(list.length-1).x,y = list.get(list.length-1).y,yon = list.get(list.length-1).yon;
      if (list.get(list.length-1).yon == 0){
        x++;
      }
      if (list.get(list.length-1).yon == 1){
        y++;
      }
      if (list.get(list.length-1).yon == 2){
        x--;
      }
      if (list.get(list.length-1).yon == 3){
        y--;
      }
      list.append(new govde(x,y,yon,0,yer));
      for (int i=0;i<list.get(list.length-2).yapilcak.length;i++){
        list.get(list.length-1).yapilcak.append(list.get(list.length-2).yapilcak.get(i));
      }
      yer++;
    }
  }
}
