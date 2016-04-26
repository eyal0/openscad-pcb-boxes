use <box_top.scad>;
use <upsidedown.scad>;

// button_offset should be offset to move the first child relative to
// bottom-left corner of the box top when upside-down.  First child
// should be the button's 2D projection, it will be rounded to a
// smaller size.  The rest is the box.  The button_height is how high
// it is off the top of the pcb.

//$epsilon=0.5;

// Made as wide as $thickness and padded by $epsilon on both sides.
module front_port_hole(port_offset, offset=0) {
  /*render_box_top("demo", 0) front_port_hole(port_offset) {
    children(0);
  }*/
  // Make the hole for the port.
  translate([port_offset[0], $thickness+$epsilon, port_offset[2]]) {
    rotate([90,0,0]) {
      linear_extrude($thickness+2*$epsilon) {
        offset(r=offset) {
          children();
        }
      }
    }
  }
}

module project_to_xy() {
  hull() {
    children();
    translate([0,0,-$epsilon]) {
      linear_extrude($epsilon) {
        projection() {
          children();
        }
      }
    }
  }
}

// First child should be a two-dimensional shape to cut out of the front of the box.  port_offset should have only positive y and z values.
module add_front_port_top(port_offset, level) {
  if ($level != level && $level != -1) {
    children([1:$children-1]);
  } else {
    difference() {
      children([1:$children-1]);
      render_box_top("demo", 0) {
        project_to_xy() {
          front_port_hole(port_offset) {
            children(0);
          }
        }
        project_to_xy() {
          front_port_hole(port_offset, offset=1, $thickness=$thickness/2+$static_clearance/2) {
            children(0);
          }
        }
      }
      
    }
  }
}

module front_port_hole_hole(port_offset) {
  // Make the hole for the port.
  translate([port_offset[0], $thickness, port_offset[2]]) {
    rotate([90,0,0]) {
      linear_extrude($thickness) {
        children();
      }
    }
  }
}

module add_front_port_bottom(port_offset, level) {
  if ($level != level && $level != -1) {
    children([1:$children-1]);
  } else {
    children([1:$children-1]);
    difference () {
      hull() {
        front_port_hole(port_offset) {
          children(0);
        }
        translate([0,0,-$epsilon]) {
          linear_extrude($epsilon) {
            projection() {
              front_port_hole(port_offset) {
              children(0);
              }
            }
          }
        }
      }
      minkowski() {
        sphere(r=$epsilon);
        front_port_hole(port_offset) {
          children(0);
        }
      }
    }
    linear_extrude($thickness + $static_clearance + $epsilon) {
      projection() {
        front_port_hole(port_offset) {
          children(0);
        }
      }
    }
  }
}
