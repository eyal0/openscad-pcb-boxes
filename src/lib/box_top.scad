// Creates a rounded box top with a flat bottom.
// Assumes $thickness, $epsilon.
// Aligned so that the box is upside-down from usage and the inner box lines up with X and Y and Z.
module box_top(level) {
  if ($level != level && $level != -1) {
  } else {
    if (!$box_size) {
      echo("ERROR: $box_size not defined in box_top");
      UNDEFINED_DYNAMIC_VARIABLE_ERROR();
    }
    if (!$thickness) {
      echo("ERROR: $thickness not defined in box_top");
      UNDEFINED_DYNAMIC_VARIABLE_ERROR();
    }
    if (!$epsilon) {
      echo("ERROR: $epsilon not defined in box_top");
      UNDEFINED_DYNAMIC_VARIABLE_ERROR();
    }
    inside_dimensions = $box_size-[2*$thickness, 2*$thickness, $thickness];
    translate([$thickness, $thickness, $thickness]) {
      difference () {
        hull() {
          translate([                   0,                   0,                   0]) sphere(r=$thickness);
          translate([                   0,                   0,inside_dimensions[2]]) sphere(r=$thickness);
          translate([                   0,inside_dimensions[1],                   0]) sphere(r=$thickness);
          translate([                   0,inside_dimensions[1],inside_dimensions[2]]) sphere(r=$thickness);
          translate([inside_dimensions[0],                   0,                   0]) sphere(r=$thickness);
          translate([inside_dimensions[0],                   0,inside_dimensions[2]]) sphere(r=$thickness);
          translate([inside_dimensions[0],inside_dimensions[1],                   0]) sphere(r=$thickness);
          translate([inside_dimensions[0],inside_dimensions[1],inside_dimensions[2]]) sphere(r=$thickness);
        }
        cube(inside_dimensions+[0,0,$epsilon]);
        translate([-$thickness-$epsilon,
                   -$thickness-$epsilon,
                   $box_size[2]-$thickness]) {
          cube($box_size*[[1,0,0],[0,1,0],[0,0,0]] +
               [2*$epsilon, 2*$epsilon, $thickness + $epsilon]);
        }
      }
    }
  }
}

module render_box_top(style, level) {
  if ($level != level && $level != -1 && level != -1) {
    children();
  } else {
    if (style == "print") {
      if ($level == -1 || level == -1) {
        children();
      } else {
        import($import_filename);
      }
    }
    if (style == "demo") {
      if (!$box_size) {
        echo("ERROR: $box_size not defined in render_box_top");
        UNDEFINED_DYNAMIC_VARIABLE_ERROR();
      }
      translate([0, $box_size[1], $box_size[2]]) {
        rotate([180,0,0]) {
          if ($level == -1 || level == -1) {
            children();
          } else {
            import($import_filename);
          }
        }
      }
    }
  }
}

//box_top($box_size=[50,40,10], $epsilon=0.01, $thickness=3, $fn=50);
//demo_box_top($thickness=3, $box_size=[50,40,10]) box_top([50,100,20], $epsilon=0.01, $fn=50);
//print_box_top($thickness=3, $box_size=[50,40,10]) box_top([50,100,20], $epsilon=0.01, $fn=50);
