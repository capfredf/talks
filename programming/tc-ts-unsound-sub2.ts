class Point3D extends Point2D {
  z : number;
  constructor(x : number,
              y : number,
              z : number) {
    super(x, y);
    this.z = z;
  }
  norm(this:this) : number {
    return sqrt(square(3) +
                square(4) +
                square(undefined));
  }
}
