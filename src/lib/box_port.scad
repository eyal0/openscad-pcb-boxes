use <box_top.scad>;
use <upsidedown.scad>;

// button_offset should be offset to move the first child relative to
// bottom-left corner of the box top when upside-down.  First child
// should be the button's 2D projection, it will be rounded to a
// smaller size.  The rest is the box.  The button_height is how high
// it is off the top of the pcb.

// Made as thick as tab_thickness and padded by $epsilon on both sides.
module front_port_hole(port_offset, tab_thickness, tab_padding) {
  // Make the hole for the port.
  translate([port_offset[0], tab_thickness+tab_padding, port_offset[2]]) {
    rotate([90,0,0]) {
      linear_extrude(tab_thickness+2*tab_padding) {
        children();
      }
    }
  }
}
$epsilon=0.3;
// Extends the 3d shape down to the xy plane, extending below by extend_below.
module project_to_xy(extend_below) {
  union() {
    children();
    difference() {
      hull() {
        children();
        translate([0,0,-extend_below]) {
          linear_extrude($epsilon) {
            projection() {
              children();
            }
          }
        }
      }
      translate([0,$epsilon,$epsilon]) {
        hull() {
          children();
          translate([0,0,$box_size[2]]) {
            linear_extrude($epsilon) {
              projection() {
                children();
              }
            }
          }
        }
      }
      translate([0,-$epsilon,$epsilon]) {
        hull() {
          children();
          translate([0,0,$box_size[2]]) {
            linear_extrude($epsilon) {
              projection() {
                children();
              }
            }
          }
        }
      }
    }
  }
}

// Project the child down to xy but without the original child.
module tab_without_lap(port_offset, tab_thickness, tab_padding, extend_below) {
  difference() {
    project_to_xy(extend_below) {
      front_port_hole(port_offset,
                      tab_thickness, tab_padding) {
        children(0);
      }
    }
    minkowski() {
      sphere(r=$epsilon);
      front_port_hole(port_offset,
                      tab_thickness, tab_padding) {
        children(0);
      }
    }
  }
}

// Create the left or right most edge of the child.
// direction is "left" or "right"
module lap_strip(port_offset, tab_thickness, tab_padding, direction, extend_below) {
  shift = direction=="left" ? $epsilon : -$epsilon;
  difference() {
    tab_without_lap(port_offset,tab_thickness,tab_padding,extend_below) {
      children(0);
    }
    translate([shift, -$epsilon, $epsilon]) {
      hull()
      tab_without_lap(port_offset,tab_thickness+2*$epsilon, tab_padding, extend_below) {
        children(0);
      }
    }
    translate([shift, -$epsilon, -$epsilon]) {
      hull()
      tab_without_lap(port_offset,tab_thickness+2*$epsilon, tab_padding, extend_below) {
        children(0);
      }
    }
  }
}

// Create the rightmost or leftmost edge of the child, extended to
// $thickness width..
module lap(port_offset, tab_thickness, tab_padding, direction, extend_below) {
  shift = direction=="left" ? -$thickness : $thickness;
  hull() {
    lap_strip(port_offset, tab_thickness, tab_padding, direction, extend_below) {
      children(0);
    }
    translate([shift,0,0]) {
      lap_strip(port_offset, tab_thickness, tab_padding, direction, extend_below) {
        children(0);
      }
    }
  }
}

// Project child to xy and add side wings in x on both sides.
module tab_with_lap(port_offset, tab_thickness, tab_padding, extend_below) {
  lap(port_offset, tab_thickness, tab_padding, "left", extend_below) {
    children(0);
  }
  lap(port_offset, tab_thickness, tab_padding, "right", extend_below) {
    children(0);
  }
  tab_without_lap(port_offset, tab_thickness, tab_padding, extend_below) {
    children(0);
  }
}

//$epsilon=0.3;
// First child should be a two-dimensional shape to cut out of the
// front of the box.  port_offset should have only positive y and z
// values.
module add_front_port_top(port_offset, level) {
  if ($level != level && $level != -1) {
    children([1:$children-1]);
  } else {
    difference() {
      children([1:$children-1]);
      render_box_top("demo", level) {
        union() {
          project_to_xy($epsilon) {
            front_port_hole(port_offset, $thickness, $epsilon) {
              children(0);
            }
          }
          // For the overlapping section, half thickness.
          tab_with_lap(port_offset,
                       $thickness/2+$static_clearance/2,
                       $epsilon,
                       $epsilon) {
            children(0);
          }
        }
      }
    }
  }
}

//$epsilon=0.5;

module add_front_port_bottom(port_offset, level) {
  if ($level != level && $level != -1) {
    children([1:$children-1]);
  } else {
    children([1:$children-1]);
    union() {
      tab_without_lap(port_offset, $thickness, 0) {
        children(0);
      }
      tab_with_lap(port_offset, $thickness/2-$static_clearance/2, 0, 0) {
        children(0);
      }
    }
    translate([0,0,$thickness]) {
      rotate([-90,0,0]) {
        linear_extrude($thickness + $static_clearance + $epsilon) {
          projection() {
            front_port_hole(port_offset, $thickness, $epsilon=0) {
              children(0);
            }
          }
        }
      }
    }
  }
}
