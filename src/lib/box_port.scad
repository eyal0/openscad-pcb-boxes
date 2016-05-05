use <box_top.scad>;
use <upsidedown.scad>;
use <import_children.scad>;
use <wiggle.scad>;

// button_offset should be offset to move the first child relative to
// bottom-left corner of the box top when upside-down.  First child
// should be the button's 2D projection, it will be rounded to a
// smaller size.  The rest is the box.  The button_height is how high
// it is off the top of the pcb.

// Made as thick as tab_thickness and padded by $epsilon on both sides.
module front_port_hole(port_offset, radius, tab_thickness, tab_padding) {
  // Make the hole for the port.
  translate([port_offset[0], tab_thickness+tab_padding, port_offset[2]]) {
    rotate([90,0,0]) {
      cylinder(h=tab_thickness+2*tab_padding, r=radius);
    }
  }
}

// Makes a round port with given radius.  port_offset should have only
// positive x and z values.  Assume that the highest, widest point of
// the shape is on the y axis for extending tabs.
module add_front_port_top(port_offset, radius, level) {
  level_preamble(level) {
    children();
    difference() {
      level_import(level) {
        children();
      }
      render_box_top("demo", -1) {
        front_port_hole(port_offset,
                        radius+$static_clearance,
                        $thickness+$epsilon+2, $epsilon);
        translate([port_offset[0]-radius-$static_clearance,
                   -$epsilon,
                   -$epsilon]) {
          cube([radius*2+2*$static_clearance,
                $thickness+2*$epsilon,
                $epsilon+port_offset[2]]);
        }
        translate([port_offset[0]-radius-$static_clearance-$thickness,
                   -$epsilon,
                   -$epsilon]) {
          cube([radius*2+2*$static_clearance+$thickness*2,
                $thickness/2+$static_clearance/2+$epsilon,
                $epsilon+port_offset[2]+$static_clearance]);
        }
      }
    }
  }
}

// Makes a round port with given radius.
// port_offset should have only positive x and z
// values.  Assume that the highest, widest point of the shape is on
// the y axis for extending tabs.
module add_front_port_bottom(port_offset, radius, level) {
  level_preamble(level) {
    children();
    level_import(level) {
      children();
    }
    difference() {
      union() {
        translate([port_offset[0]-radius,
                   0,
                   0]) {
          cube([radius*2,
                $thickness,
                port_offset[2]]);
        }
        translate([port_offset[0]-radius-$thickness,
                   0,
                   0]) {
          cube([radius*2+$thickness*2,
                $thickness/2-$static_clearance/2,
                port_offset[2]]);
        }
        translate([port_offset[0]-radius,
                   0,
                   0]) {
          cube([2*radius,
                $thickness + $static_clearance + $epsilon,
                $thickness]);
        }
      }
      front_port_hole(port_offset,
                      radius+$static_clearance,
                      $thickness+$epsilon+2, $epsilon);
    }
  }
}
