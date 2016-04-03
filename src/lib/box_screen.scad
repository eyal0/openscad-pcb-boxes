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
      import(str($filename, "_", $level-1, ".stl"));
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
        import(str($filename, "_", $level-1, ".stl"));
      }
      translate(screen_offset) {
        union() {
          slice_count = floor($fn/4);
          for (i = [0 : slice_count-1]) {
            theta_bottom = i*90/slice_count;
            theta_top = theta_bottom + 90/slice_count;
            slice_bottom_height = (1-cos(theta_bottom))*$thickness;
            slice_top_height = (1-cos(theta_top))*$thickness;
            slice_thickness = slice_top_height-slice_bottom_height;
            slice_bottom_offset = (1-sin(theta_bottom))*$thickness;
            slice_top_offset = (1-sin(theta_top))*$thickness;
            slice_offset = (slice_top_offset+slice_bottom_offset)/2;
            translate([0,0,slice_bottom_height]) {
              linear_extrude(slice_thickness+$epsilon) {
                difference() {
                  offset(r=$thickness+$epsilon) children(0);
                  offset(r=slice_offset) children(0);
                }
              }
            }
          }
          translate([0,0,$thickness]) {
            linear_extrude($pcb_top_clearance-screen_height-$static_clearance, convexity=10) {
              difference() {
                offset(r=$thickness+$epsilon) children(0);
                children(0);
              }
            }
          }
        }
      }
    }
  }
}
