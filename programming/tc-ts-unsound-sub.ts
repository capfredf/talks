class Point3D extends Point2D {
  z : number;
  constructor(x : number,
              y : number,
              z : number) {
    super(x, y);
    this.z = z;
  }
  norm(this:this) : number {
    return sqrt(square(pt_a.x) +
                square(pt_a.y) +
                square(pt_a.z));
  }
}
