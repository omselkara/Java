class govde{
  int x,y,yon,kafa,yer,last;
  listint yapilcak;
  govde(int x,int y,int yon,int kafa,int yer){
    this.yer = yer;
    this.x = x;
    this.y = y;
    this.last = yon;
    this.yon = yon;
    this.yapilcak = new listint(new int[0][3]);
    this.kafa = kafa;
  }
  void hareket(){
    if (this.kafa == 0){
      if (this.yapilcak.length>0){
        if (this.yapilcak.get(0)[0] == this.x && this.yapilcak.get(0)[1] == this.y){
          this.last = this.yon;
          this.yon = this.yapilcak.get(0)[2];
          this.yapilcak.remove(0);
        }
        else{
          this.last = this.yon;
        }
      }
    }
    else{
      this.last = this.yon;
    }
    if (this.yon==0){
      this.x--;
    }
    if (this.yon==1){
      this.y--;
    }
    if (this.yon==2){
      this.x++;
    }
    if (this.yon==3){
      this.y++;
    }
    
  }
  void display(){
    hareket(); 
    int g=255;
    if (this.kafa==1){
      g = 200;
    }
    if (yon==0){
      int x1=0,x2=2,y1=2,y2=0;
      if (yapilcak.length>0 && yapilcak.get(0)[0]==this.x && yapilcak.get(0)[1]==this.y){
      if (yapilcak.get(0)[2]==1){
        x1 = 2;
        x2 = 2;
        y1 = 0;
        y2 = 0;
      }
      if (yapilcak.get(0)[2]==3){
        x1 = 2;
        x2 = 2;
        y1 = 2;
        y2 = 2;
      }
      }
      rectangle(x1+xhesap(this.x),yhesap(this.y)+y1,xhesap(this.x)+48+x2,yhesap(this.y)+48+y2,0,g,0);
    }
    if (yon==1){
      int x1=2,x2=0,y1=0,y2=2;
      if (yapilcak.length>0 && yapilcak.get(0)[0]==this.x && yapilcak.get(0)[1]==this.y){
      if (yapilcak.get(0)[2]==0){
        x1 = 0;
        x2 = 0;
        y1 = 2;
        y2 = 2;
      }
      if (yapilcak.get(0)[2]==2){
        x1 = 2;
        x2 = 2;
        y1 = 2;
        y2 = 2;
      }
      }
      rectangle(x1+xhesap(this.x),yhesap(this.y)+y1,xhesap(this.x)+48+x2,yhesap(this.y)+48+y2,0,g,0);
    }
    if (yon==2){
      int x1=0,x2=2,y1=2,y2=0;
      if (yapilcak.length>0 && yapilcak.get(0)[0]==this.x && yapilcak.get(0)[1]==this.y){
      if (yapilcak.get(0)[2]==1){
        x1 = 0;
        x2 = 0;
        y1 = 0;
        y2 = 0;
      }
      if (yapilcak.get(0)[2]==3){
        x1 = 0;
        x2 = 0;
        y1 = 2;
        y2 = 2;
      }
      }
      rectangle(x1+xhesap(this.x),yhesap(this.y)+y1,xhesap(this.x)+48+x2,yhesap(this.y)+48+y2,0,g,0);
    }
    if (yon==3){
      int x1=2,x2=0,y1=0,y2=2;
      if (yapilcak.length>0 && yapilcak.get(0)[0]==this.x && yapilcak.get(0)[1]==this.y){
      if (yapilcak.get(0)[2]==0){
        x1 = 0;
        x2 = 0;
        y1 = 0;
        y2 = 0;
      }
      if (yapilcak.get(0)[2]==2){
        x1 = 2;
        x2 = 2;
        y1 = 0;
        y2 = 0;
      }
      }
      rectangle(x1+xhesap(this.x),yhesap(this.y)+y1,xhesap(this.x)+48+x2,yhesap(this.y)+48+y2,0,g,0);
    }
  }
}
void keyPress(char keyp){
  if (keyp == 'd' && yap==1 && list.get(0).yon!=0){
    for (int i=1;i<list.length;i++){
      list.get(i).yapilcak.append(new int[] {list.get(0).x,list.get(0).y,2});
    }
    list.get(0).yon = 2;
    yap = 0;
  }
  if (keyp == 'a' && yap==1 && list.get(0).yon!=2){
    for (int i=1;i<list.length;i++){
      list.get(i).yapilcak.append(new int[] {list.get(0).x,list.get(0).y,0});
    }
    list.get(0).yon = 0;
    yap = 0;
  }
  if (keyp == 'w' && yap==1 && list.get(0).yon!=3){
    for (int i=1;i<list.length;i++){
      list.get(i).yapilcak.append(new int[] {list.get(0).x,list.get(0).y,1});
    }
    list.get(0).yon = 1;
    yap = 0;
  }
  if (keyp == 's' && yap==1 && list.get(0).yon!=1){
    for (int i=1;i<list.length;i++){
      list.get(i).yapilcak.append(new int[] {list.get(0).x,list.get(0).y,3});
    }
    list.get(0).yon = 3;
    yap = 0;
  }
}
void display(){
  for (int i=0;i<list.length;i++){
    list.get(i).display();
  }
  yemek.display();
}
