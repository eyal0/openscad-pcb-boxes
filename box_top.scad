// Creates a rounded box top with a flat bottom.
// Assumes $thickness, $epsilon.
// Aligned so that the box is upside-down from usage and the inner box lines up with X and Y and Z.
module box_top() {
  if (!$box_size) {
    echo("ERROR: $box_size not defined in box_top");
  }
  if (!$thickness) {
    echo("ERROR: $thickness not defined in box_top");
  }
  if (!$epsilon) {
    echo("ERROR: $epsilon not defined in box_top");
  }
  inside_dimensions = $box_size-[2*$thickness, 2*$thickness, $thickness];
  difference () {
    minkowski () {
      sphere(r=$thickness);
      cube(inside_dimensions);
    }
    cube(inside_dimensions+[0,0,$epsilon]);
    translate([-$thickness-$epsilon,
               -$thickness-$epsilon,
               $box_size[2]-$thickness]) {
      cube($box_size+[2*$epsilon, 2*$epsilon, $epsilon]);
    }
  }
}

module print_box_top() {
  if (!$thickness) {
    echo("ERROR: $thickness not defined in print_box_top");
  }
  translate([$thickness, $thickness, $thickness]) {
    children();
  }
}

module demo_box_top() {
  if (!$thickness) {
    echo("ERROR: $thickness not defined in demo_box_top");
  }
  if (!$box_size) {
    echo("ERROR: $box_size not defined in demo_box_top");
  }
  translate([$thickness,
             $box_size[1]-$thickness,
             $box_size[2]-$thickness]) {
    rotate([180,0,0]) {
      children();
    }
  }
}

//box_top($box_size=[50,40,10], $epsilon=0.01, $thickness=3, $fn=50);
//demo_box_top($thickness=3, $box_size=[50,40,10]) box_top([50,100,20], $epsilon=0.01, $fn=50);
//print_box_top($thickness=3, $box_size=[50,40,10]) box_top([50,100,20], $epsilon=0.01, $fn=50);
