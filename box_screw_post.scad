// screw_center_offset should be relative to bottom-left corner of the box bottom when upright.
module add_screw_hole(screw_center_offset, screw_type) {
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

include <globals.scad>;

// post_center_offset should be relative to bottom-left corner of the box top when upside-down.
module add_nut_post(post_center_offset, outer_box_height) {
  children(0);
  // box outer height - post height of screw hole - offset if the post is floating
  post_height = outer_box_height-(screw_head_height+screw_sunk+$thickness)-post_center_offset[2];
  translate(post_center_offset) {
    difference() {
      // post
      intersection() { //intersection so that the post isn't sticking out of the box top.
        translate(-post_center_offset) hull() children(0);
        cylinder(h=post_height, r=nut_diameter/2+$thickness);
      }
      // screw hole
      translate(-post_center_offset) {
        difference() { // difference so that the hole doesn't go through the box.
          translate(post_center_offset) {
            cylinder(h=post_height+$epsilon,
                     r=screw_thread_diameter/2+$static_clearance);
          }
        }
        children(0);
      }
      //fixing hex hole
      translate([0,0,post_height-nut_height]) {
        rotate(360/12) {
          cylinder(h=nut_height+$epsilon,
                   r=nut_diameter/2+$static_clearance*2/sqrt(3),
                   $fn=6);
        }
      }
      // nut hole
      translate([0,0,post_height-4*nut_height-$thickness]) {
        rotate(360/12) {
          cylinder(h=3 * nut_height,
                   r=nut_diameter/2+$static_clearance*2/sqrt(3),
                   $fn=6);
        }
      }
      // nut insertion opening
      translate([0,0,post_height-3.5*nut_height-$thickness]) {
        //rotate(360/12)
        translate([-nut_width/2-$static_clearance,0,0]) {
          cube([nut_width+$static_clearance*2,
                nut_diameter/2+$thickness+$epsilon, // from post radius
                nut_height+$static_clearance*2]); // todo: make bigger for removal of nuts?
        }
      }
    }
  }
}

include <m3_screw.scad>;
add_nut_post([20,20,0], 50) {%cube([50,50,50]);}
