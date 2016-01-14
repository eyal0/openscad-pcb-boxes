include <globals.scad>

// screw_center_offset should be relative to bottom-left corner of the box bottom when upright.
module add_screw_hole(screw_center_offset, screw_scad) {
  post_height = screw_head_height + screw_sunk + $thickness;
  fitting_hex_height = post_height + nut_height/2;
  echo(fitting_hex_height);
  difference() {
    union() {
      children(0);
      translate(screw_center_offset) {
        // post
        cylinder(post_height, r=screw_head_diameter/2+$static_clearance+$thickness);
        // fitting hex 
        rotate(360/12) {
          cylinder(h=fitting_hex_height,r=nut_diameter/2,$fn=6);
        }
      }
    }
    translate(screw_center_offset+[0,0,-$epsilon]) {
      union() {
        // head hole
        cylinder(h=screw_head_height+screw_sunk+$epsilon+$static_clearance,
                 r=screw_head_diameter/2+$static_clearance);
        // screw hole
        cylinder(h=fitting_hex_height+$epsilon*2, r=screw_thread_diameter/2+$static_clearance);
      }
    }
  }
}
//top();
//bottom();
include <m3_screw.scad>;
add_screw_hole([10,10,0], "m3_screw"){cube([30,30,$thickness]);}

