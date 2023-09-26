class Point2D {
  x : number;
  y : number;
  constructor(x : number,
              y : number) {
    this.x = x;
    this.y = y;
  }
  norm(this:this) {
    return sqrt(square(this.x) +
                square(this.y));
  }
}
// ---sep---
class Point3D extends Point2D {
  z : number;
  constructor(x : number,
              y : number,
              z : number) {
    super(x, y);
    this.z = z;
  }
  norm(this:this) : number {
    return sqrt(square(this.x) +
                square(this.y) +
                square(this.z));
  }
}
// ---sep---
var pt_a = new Point2D(3, 4);
// ---sep---
var pt_b : Point2D = new Point3D(3, 4, 5);
// ---sep---
var meth = pt_b.norm;
// ---sep---
meth.call(pt_a);  // type-checks, unsound
// ---sep---
// result: NaN
