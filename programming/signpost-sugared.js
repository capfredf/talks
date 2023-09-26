class Point2D {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }
  norm(){
    return sqrt(square(self.x) + square(self.y));
  }
}
//---sep---
var pt_a = new Point2D(3, 4);
pt_a.norm();
