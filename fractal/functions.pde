float sign (PVector p1,PVector p2,PVector p3){
    return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
}
boolean PointInTriangle (PVector pt,PVector v1,PVector v2,PVector v3){
    float d1 = sign(pt, v1, v2);
    float d2 = sign(pt, v2, v3);
    float d3 = sign(pt, v3, v1);
    boolean has_neg = (d1 < 0) || (d2 < 0) || (d3 < 0);
    boolean has_pos = (d1 > 0) || (d2 > 0) || (d3 > 0);
    return !(has_neg && has_pos);
}
