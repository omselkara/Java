double[][] matrixmul(double[][]a,double[][]b){
    if (!(a.length>0) || !(b.length>0) || !(a[0].length>0) || !(b[0].length>0) || a[0].length!=b.length){
        print("There is an error");
        return new double[][] {};
    }
    double[][] result = new double[a.length][b[0].length];
    for (int i=0;i<b[0].length;i++){
        for (int s=0;s<a.length;s++){
            double sum = 0;
            for (int d=0;d<a[0].length;d++){
                sum += a[s][d]*b[d][i];
            }
            result[s][i] = sum;
        }
    }
    return result;
}
double[] rotatex(double x,double y,double z,float angle){
    double[][] a = {{+1,+0                       ,+0                       },
                   {+0,+Math.cos(radians(angle)),-Math.sin(radians(angle))},
                   {+0,+Math.sin(radians(angle)),+Math.cos(radians(angle))}};
    double[][] b = {{x},{y},{z}};
    double[][] result = matrixmul(a,b);
    return new double[] {result[0][0],result[1][0],result[2][0]};
}
double[] rotatey(double x,double y,double z,float angle){
    double[][] a = {{+Math.cos(radians(angle)),+0,+Math.sin(radians(angle))},
                    {+0                       ,+1,+0                       },
                    {-Math.sin(radians(angle)),+0,+Math.cos(radians(angle))}};
    double[][] b = {{x},{y},{z}};
    double[][] result = matrixmul(a,b);
    return new double[] {result[0][0],result[1][0],result[2][0]};
}
double[] rotatez(double x,double y,double z,float angle){
    double[][] a = {{+Math.cos(radians(angle)),-Math.sin(radians(angle)),+0},
                    {+Math.sin(radians(angle)),+Math.cos(radians(angle)),+0},
                    {+0                       ,+0                       ,+1}};
    double[][] b = {{x},{y},{z}};
    double[][] result = matrixmul(a,b);
    return new double[] {result[0][0],result[1][0],result[2][0]};
}
