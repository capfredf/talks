class Point2D {
  x : number; y : number;
  constructor(x : number, y : number) {
    this.x = x; this.y = y;
  }
  norm(this:this) {
    return sqrt(square(this.x) + square(this.y));
  }
}
// ---sep---
var p2d = new Point2D(3, 4);
// ---sep---
var meth = p2d.norm;
// ---sep---
meth.call(42); // type-checks, unsound
// result: NaN
