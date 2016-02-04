// button_offset should be offset to move the first child relative to
// bottom-left corner of the box top when upside-down.  First child
// should be the button's 2D projection, it will be rounded to a
// smaller size.  The rest is the box.  The button_height is how high
// it is off the top of the pcb.

module add_top_button_hole(button_offset, button_height) {
  if (!$thickness) {
    echo("ERROR: $thickness is not set in add_top_button_hole");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$epsilon) {
    echo("ERROR: $epislon is not set in add_top_button_hole");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$dynamic_clearance) {
    echo("ERROR: $dynamic_clearance is not set in add_top_button_hole");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$pcb_top_clearance) {
    echo("ERROR: $pcb_top_clearance is not set in add_top_support_post");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$static_clearance) {
    echo("ERROR: $static_clearance is not set in add_top_support_post");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  difference() {
    children([1:$children-1]);
    translate(button_offset + [0,0,-$epsilon])  {
      linear_extrude(height=$thickness+2*$epsilon, convexity=10) {
        offset(r=$dynamic_clearance) {
          offset(r=$thickness) {
            offset(r=-$thickness) {
              children(0);
            }
          }
        }
      }
    }
  }
  translate(button_offset) {
    intersection() { //intersection so that the hole's supports aren't sticking out of the box top.
      translate(-button_offset) {
        hull() {
          children([1:$children-1]);
        }
      }
      linear_extrude(height=$pcb_top_clearance-button_height-2*$static_clearance, convexity=10) {
        difference() {
          offset(r=$thickness) {
            offset(r=$dynamic_clearance) {
              offset(r=$thickness) {
                offset(r=-$thickness) {
                  children(0);
                }
              }
            }
          }
          offset(r=$dynamic_clearance) {
            offset(r=$thickness) {
              offset(r=-$thickness) {
                children(0);
              }
            }
          }
        }
      }
    }
  }
}

// button_offset should be offset to move the first child relative to
// bottom-left corner of the box top when upside-down.  First child
// should be the button's 2D projection, it will be rounded to a
// smaller size.  The rest is the box.  The button_height is how high
// it is off the top of the pcb.
module add_button(button_height) {
  if (!$thickness) {
    echo("ERROR: $thickness is not set in add_button");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$pcb_top_clearance) {
    echo("ERROR: $pcb_top_clearance is not set in add_button");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$pcb_thickness) {
    echo("ERROR: $pcb_thickness is not set in add_button");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$static_clearance) {
    echo("ERROR: $static_clearance is not set in add_button");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$box_size) {
    echo("ERROR: $box_size is not set in add_button");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$epsilon) {
    echo("ERROR: $epsilon is not set in add_button");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  minkowski() {
    sphere(r=$thickness);
    linear_extrude($pcb_top_clearance-button_height-$static_clearance, convexity=10) {
      offset(r=-$thickness) {
        children(0);
      }
    }
  }
  translate([0,0,-$thickness]) {
    linear_extrude($thickness, convexity=10) {
      offset(r=$thickness) {
        offset(r=$dynamic_clearance) {
          offset(r=$thickness) {
            offset(r=-$thickness) {
              children(0);
            }
          }
        }
      }
    }
  }
}

module print_button() {
  if (!$thickness) {
    echo("ERROR: $thickness is not set in print_button");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  translate([0,0,$thickness]) {
    children();
  }
}

use <box_top.scad>;

module demo_button(button_offset, button_height) {
  if (!$thickness) {
    echo("ERROR: $thickness is not set in print_button");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  demo_box_top() {
    translate(button_offset + [0,0,$pcb_top_clearance-button_height-$static_clearance]) {
      rotate([180,0,0]) {
        children();
      }
    }
  }
}


// Uncomment for testing.

/*
$epsilon = 0.01;
$pcb_top_clearance = 10;
$pcb_thickness = 10;
$thickness = 2;
$static_clearance = 0.2;
$box_size = [100,50,30];
$fn = 50;
$dynamic_clearance = 0.4;
triangle_height = 10;
demo_box_top() {
  add_top_button_hole([20,20,0], 5) {
    polygon(points=[
              [-triangle_height/1.5, 0],
              [triangle_height/3, triangle_height*sqrt(3)/3],
              [triangle_height/3, -triangle_height*sqrt(3)/3]],
            paths=[
              [0,1,2]
              ]
      );
    box_top();
  }
}

demo_button([20,20,0], 5) {
  add_button(5) {
    polygon(points=[
              [-triangle_height/1.5, 0],
              [triangle_height/3, triangle_height*sqrt(3)/3],
              [triangle_height/3, -triangle_height*sqrt(3)/3]],
            paths=[
              [0,1,2]
              ]
      );
  }
}
*/

