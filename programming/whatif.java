try {
  Method norm = Point2D.class.getMethod("norm", Point2D.class);
  norm.invoke(42);
} catch .... {
  ....
}
