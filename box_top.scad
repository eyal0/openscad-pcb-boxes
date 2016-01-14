$fn=50;
$epsilon = 0.01;
$thickness = 3;

// Creates a rounded box top with a flat bottom.
// Assumes $thickness, $epsilon.
// Aligned so that the box is upside-down from usage and the inner box lines up with X and Y and Z.
module box_top(outside_dimensions) {
  inside_dimensions = outside_dimensions-[2*$thickness, 2*$thickness, $thickness];
  difference () {
    minkowski () {
      sphere(r=$thickness);
      cube(inside_dimensions);
    }
    cube(inside_dimensions+[0,0,$epsilon]);
    translate([-$thickness-$epsilon,
               -$thickness-$epsilon,
               outside_dimensions[2]-$thickness]) {
      cube(outside_dimensions+[2*$epsilon, 2*$epsilon, $epsilon]);
    }
  }
}

module print_box_top() {
  translate([$thickness, $thickness, $thickness]) {
    children();
  }
}

module demo_box_top(box_outside_dimensions) {
  translate([$thickness,
             box_outside_dimensions[1]-$thickness,
             box_outside_dimensions[2]-$thickness]) {
    rotate([180,0,0]) {
      children();
    }
  }
}

//box_top([50,100,20]);
