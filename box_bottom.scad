include <globals.scad>;

module box_bottom(box_outside_dimensions) {
  translate ([$static_clearance,$static_clearance,0]) {
    cube([box_outside_dimensions[0]-2*($thickness+$static_clearance),
          box_outside_dimensions[1]-2*($thickness+$static_clearance),
          $thickness]);
  }
}

module print_box_bottom() {
  translate([-$static_clearance, -$static_clearance, 0]) {
    children();
  }
}

module demo_box_bottom() {
  translate([$thickness, $thickness, 0]) {
    children();
  }
}

// box_bottom([50,100,20]);
