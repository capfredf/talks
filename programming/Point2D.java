// start: declaration
import java.lang.reflect.*; // ignore
import java.lang.Math; // ignore
class Point2D {
  private int x, y;
  public Point2D(int x, int y) {
    this.x = x;
    this.y = y;
  }
  public double norm() {
    return Math.sqrt(this.x * this.x + this.y * this.y);
  }
  // indent: -3
  // ---sep--- initialization
  public static void main(String[] args) { // ignore
    Point2D pt_a = new Point2D(3, 4);
    // ---sep--- extraction
    try { // ignore
      Method norm = Point2D.class.getMethod("norm", Point2D.class);
    // ---sep--- application
      norm.invoke(pt_a);
      // result: 5
    // ignore
    } catch (NoSuchMethodException e) { // ignore
      System.err.println("class Apple doesn't have a method named norm"); //ignore
    } catch (IllegalAccessException e) { // ignore
      e.printStackTrace(); // ignore
    } catch (InvocationTargetException  e) { //ignore
      e.printStackTrace(); //ignore
    } // ignore
    // ignore
  } // ignore
} // ignore
