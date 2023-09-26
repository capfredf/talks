// start: declaration
let sqrt = Math.sqrt // ignore
let square = Math.pow // ignore
class Point2D {
  constructor(x, y){
    this.x = x;
    this.y = y
  }
  norm() {
    return sqrt(square(this.x) + square(this.y));
  }
}
// ---sep--- initialization
let pt_a = new Point2D(3, 4);
// ---sep--- extraction
let m = pt_a.norm;
// ---sep--- application
m.call(pt_a)
// result: 5
