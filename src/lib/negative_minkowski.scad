module negative_minkowski() {
  minuend = 0;
  subtrahend = [1:$children-1];
  difference() {
    children(minuend);
    intersection() {
      children(minuend);
      render($fn=30) minkowski() {
        difference() {
          render() minkowski() {
            children(minuend);
            sphere(r=$epsilon);
          }
          children(minuend);
        }
        children(subtrahend);
      }
    }
  }
}

/*
For testing.

$epsilon = 0.1;
$fn=20;
$bezel = 2;
minkowski() {
  sphere(r=$bezel);
  negative_minkowski() {
    #cylinder(r=10, h=20);
    sphere(r=$bezel);
  }
}
*/
