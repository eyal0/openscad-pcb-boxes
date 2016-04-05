// screen_height is the height from the pcb top for the screen.
// screen_offset is the offset of the screen from the bottom left
// corner of the box when upside-down.  First child is the 2D shape of
// the screen to expose.

module add_top_screen_hole(screen_offset, screen_height, level) {
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
      import($import_filename);
      translate(screen_offset-[0,0,$epsilon]) {
        linear_extrude($thickness+2*$epsilon+$pcb_top_clearance-screen_height-$static_clearance, convexity=10) {
          offset(r=$thickness) {
            children(0);
          }
        }
      }
    }
    intersection() { //intersection so that the screen hole sides aren't outside the box size.
      hull() {
        import($import_filename);
      }
      translate(screen_offset) {
        intersection() {
          translate([0,0,$thickness]) {
            minkowski(convexity=10) {
              sphere(r=$thickness);
              linear_extrude($thickness+$pcb_top_clearance-screen_height+$epsilon, convexity=10) {
                difference() {
                  offset(r=$thickness + $epsilon)
                    children(0);
                  offset(r=$thickness) {
                    children(0);
                  }
                }
              }
            }
          }
          translate([0,0,-$epsilon]) {
            linear_extrude($thickness+$pcb_top_clearance-screen_height-$static_clearance+2*$epsilon, convexity=10) {
              offset(r=$thickness+$epsilon) {
                children(0);
              }
            }
          }
        }
      }
    }
  }
}
