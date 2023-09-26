# start: declaration
import math # ignore
sqrt = math.sqrt # ignore
def square(x): # ignore
  return x * x # ignore
class Point2D(object):
  def __init__(self, x, y):
    self.x = x
    self.y = y

  def norm(self):
    return sqrt(square(self.x) * square(self.x))
# ---sep--- initialization
pt_a = Point2D(3, 4)
# ---sep--- extraction
m = pt_a.norm
# ---sep--- application
m()
# result: 5
