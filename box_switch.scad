// handle_offset0 should be offset to move the first child relative to
// bottom-left corner of the box top when upside-down for off switch
// position.  handle_offset1 should be offset to move the fist child
// for on switch position.  First child should be the switch handles's
// 2D projection.  The rest is the box.  The handle_base_height is how
// igh the handle of the switch is from the top of the pcb.
// handle_height is how tall the handle is.
module add_switch_hole(handle_offset0, handle_offset1, handle_base_height, handle_height) {
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
    translate(handle_offset0 + [0,0,-$epsilon])  {
      linear_extrude(height=$thickness+2*$epsilon, convexity=10) {
        offset(r=$dynamic_clearance+$static_clearance+$thickness) {
          hull() {
            children(0);
            translate(handle_offset1-handle_offset0) {
              children(0);
            }
          }
        }
      }
    }
  }
  translate(handle_offset0-(handle_offset1-handle_offset0)/2) {
    intersection() { //intersection so that the hole's supports aren't sticking out of the box top.
      translate(-(handle_offset0-(handle_offset1-handle_offset0)/2)) {
        hull() {
          children([1:$children-1]);
        }
      }
      linear_extrude(height=$thickness +
                     ($pcb_top_clearance-handle_base_height-2*$dynamic_clearance) // from base of new handle below
                     -$dynamic_clearance, convexity=10) {
        difference() {
          offset(r=$dynamic_clearance+$static_clearance+3*$thickness) {
            hull() {
              children(0);
              translate(2*(handle_offset1-handle_offset0)) {
                children(0);
              }
            }
          }
          offset(r=$dynamic_clearance+$static_clearance+2*$thickness) {
            hull() {
              children(0);
              translate(2*(handle_offset1-handle_offset0)) {
                children(0);
              }
            }
          }
        }
      }
    }
  }
}

// handle_offset0 should be offset to move the first child relative to
// bottom-left corner of the box top when upside-down for off switch
// position.  handle_offset1 should be offset to move the fist child
// for on switch position.  First child should be the switch handles's
// 2D projection.  The rest is the box.  The handle_base_height is how
// igh the handle of the switch is from the top of the pcb.
// handle_height is how tall the handle is.
module add_switch(handle_offset0, handle_offset1, handle_base_height, handle_height) {
  if (!$thickness) {
    echo("ERROR: $thickness is not set in add_button");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$pcb_top_clearance) {
    echo("ERROR: $pcb_top_clearance is not set in add_button");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$static_clearance) {
    echo("ERROR: $static_clearance is not set in add_button");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  difference() {
    union() {
      // Handle of the new handle.
      translate((handle_offset1-handle_offset0)/2+[0,0,$static_clearance+$thickness]) {
        minkowski() {
          sphere(r=$static_clearance+$thickness);
          linear_extrude($pcb_top_clearance-handle_base_height-2*$static_clearance-$dynamic_clearance) {
            children(0);
          }
        }
      }
      // Base of the new handle
      linear_extrude($pcb_top_clearance-handle_base_height-2*$dynamic_clearance) {
        offset(r=2*$thickness+$static_clearance) {
          hull() {
            children(0);
            translate(handle_offset1-handle_offset0) {
              children(0);
            }
          }
        }
      }
    }
    // Hole for orginal handle.
    translate((handle_offset1-handle_offset0)/2) {
      minkowski() {
        sphere(r=$static_clearance);
        linear_extrude(handle_height) {
          children(0);
        }
      }
    }
  }
}

module print_switch() {
  children();
}

module demo_switch(handle_offset0, handle_offset1, handle_base_height, handle_height) {
  if (!$thickness) {
    echo("ERROR: $thickness is not set in demo_switch");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$box_size) {
    echo("ERROR: $box_size is not set in demo_switch");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$pcb_top_clearance) {
    echo("ERROR: $pcb_top_clearance is not set in demo_switch");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$dynamic_clearance) {
    echo("ERROR: $dynamic_clearance is not set in demo_switch");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  translate([handle_offset0[0], $box_size[1]-handle_offset0[1]-$thickness, handle_offset0[2]] +
            [0,0,$box_size[2]-$thickness-
             ($pcb_top_clearance-handle_base_height-2*$dynamic_clearance) // from base of new handle above
              +$dynamic_clearance]) {
    children();
  }
}


// Uncomment for testing.

use <box_top.scad>;
//use <box_bottom.scad>;

$epsilon = 0.01;
$pcb_top_clearance = 20;
$pcb_thickness = 10;
$thickness = 2;
$static_clearance = 0.2;
$box_size = [100,50,30];
$fn = 50;
$dynamic_clearance = 0.4;
triangle_height = 10;
demo_switch([20,10,0],[25,10,0], 5, 3) {
  add_switch([20,10,0],[25,10,0], 5, 3) {
    square([2,2]);
  }
}
demo_box_top() {
  add_switch_hole([20,10,0],[25,10,0], 5, 3) {
    square([2,2]);
    box_top();
  }
}

//demo_box_bottom() add_bottom_support_post([20,30,0], 5) {%box_bottom();}

