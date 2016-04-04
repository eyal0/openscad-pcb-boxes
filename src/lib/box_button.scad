use <upsidedown.scad>;

// button_offset should be offset to move the first child relative to
// bottom-left corner of the box top when upside-down.  First child
// should be the button's 2D projection, it will be rounded to a
// smaller size.  The rest is the box.  The button_height is how high
// it is off the top of the pcb.

module add_top_button_hole(button_offset, button_height, level) {
  if ($level != level) {
    children([1:$children-1]);
  } else {
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
      import(str($filename, "_", $level-1, ".stl"));
      translate(button_offset + [0,0,-$epsilon])  {
        linear_extrude(height=$thickness+2*$epsilon, convexity=10) {
          offset(r=$dynamic_clearance+$thickness) {
            offset(r=-$thickness) {
              children(0);
            }
          }
        }
      }
    }
    translate(button_offset) {
      intersection() { //intersection so that the hole's supports aren't sticking out of the box top.
        translate(-button_offset) {
          hull() {
            import(str($filename, "_", $level-1, ".stl"));
          }
        }
        linear_extrude(height=$pcb_top_clearance-button_height-2*$static_clearance, convexity=10) {
          difference() {
            offset(r=2*$thickness+$dynamic_clearance) {
              offset(r=-$thickness) {
                children(0);
              }
            }
            offset(r=$dynamic_clearance + $thickness) {
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

use <box_top.scad>;  // to put it in the right place for the box top

// button_offset should be offset to move the first child relative to
// bottom-left corner of the box top when upside-down.  First child
// should be the button's 2D projection, it will be rounded to a
// smaller size.  The rest is the box.  The button_height is how high
// it is off the top of the pcb.
module add_button(button_offset, button_height, level) {
  if ($level != level) {
  } else {
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
    translate(button_offset + [0,0,$pcb_top_clearance-button_height-$static_clearance]) {
      rotate([180,0,0]) {
        minkowski() {
          sphere(r=$thickness);
          linear_extrude($pcb_top_clearance-button_height-$static_clearance, convexity=10) {
            offset(r=-$thickness) {
              upsidedown_polygon() { // because it's upsidedown from the top
                children(0);
              }
            }
          }
        }
        translate([0,0,-$thickness]) {
          linear_extrude($thickness, convexity=10) {
            offset(r=2*$thickness+$dynamic_clearance) {
              offset(r=-$thickness) {
                upsidedown_polygon() { // because it's upsidedown from the top
                  children(0);
                }
              }
            }
          }
        }
      }
    }
  }
}
