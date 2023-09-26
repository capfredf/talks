let sqrt = Math.sqrt // ignore
let square = function(x) { return Math.pow(x, 2);} // ignore
class Point2D {
  constructor(x, y){
    this.x = x;
    this.y = y;
  }
  norm() {
    return sqrt(square(this.x) + square(this.y));
  }
}
// ---sep---
let a = new Point2D(3, 4);
let m = a.norm;
// ---sep---
m.call(42)
// ---sep---
// result: NaN
