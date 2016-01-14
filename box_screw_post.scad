include <screws.scad>;

// screw_center_offset should be relative to bottom-left corner of the box bottom when upright.
module add_screw_hole(screw_center_offset, screw_type) {
  if (!$thickness) {
    echo("ERROR: $thickness not defined in add_screw_hole");
  }
  if (!$static_clearance) {
    echo("ERROR: $static_clearance not defined in add_screw_hole");
  }
  if (!$epsilon) {
    echo("ERROR: $epsilon not defined in add_screw_hole");
  }

  function screw(p) = get_screw_param(screw_type, p);
  // Depth of hole for screw head.
  head_hole_height = screw("screw_head_height") + screw("screw_sunk") + $static_clearance;

  // depth of hole for fixing in place.
  fitting_hex_height = $thickness + $static_clearance;

  post_height = head_hole_height + fitting_hex_height + $thickness;
  post_radius = screw("screw_head_diameter")/2 + $static_clearance + $thickness;


  difference() {
    union() {
      children();
      translate(screw_center_offset) {
        // post
        cylinder(h=post_height, r=post_radius);
      }
    }
    translate(screw_center_offset+[0,0,-$epsilon]) {
      // head hole
      cylinder(h=head_hole_height+$epsilon,
               r=screw("screw_head_diameter")/2+$static_clearance);
      // screw hole
      cylinder(h=post_height+$epsilon*2, r=screw("screw_thread_diameter")/2+$static_clearance);
    }
    // fitting hex
    translate(screw_center_offset+[0,0,post_height-fitting_hex_height]) {
      rotate(360/12) {
        cylinder(h=fitting_hex_height+$epsilon, r=screw("nut_diameter")/2+$static_clearance*2/sqrt(3),$fn=6);
      }
    }
  }
}


//For testing, uncomment.

/*
include <box_bottom.scad>;
$fn = 50;
$thickness = 2;
$static_clearance = 0.2;
$epsilon = 0.01;
$box_size = [100,50,30];
add_screw_hole([10,10,0], "m3"){box_bottom();}
*/

// post_center_offset should be relative to bottom-left corner of the box top when upside-down.
module add_screw_post(post_center_offset, screw_type) {
  if (!$thickness) {
    echo("ERROR: $thickness not defined in add_screw_post");
  }
  if (!$static_clearance) {
    echo("ERROR: $static_clearance not defined in add_screw_post");
  }
  if (!$epsilon) {
    echo("ERROR: $epsilon not defined in add_screw_post");
  }

  function screw(p) = get_screw_param(screw_type, p);
  // box outer height - post height of screw hole - offset if the post is floating
  post_height = $box_size[2] -
    (screw("screw_head_height") + screw("screw_sunk") + $static_clearance + 2*$thickness) // post_height from above
    - $static_clearance // so that the posts meet with a small gap
    - post_center_offset[2]; // in case the post is floating
  nut_radius_with_clearance = screw("nut_diameter")/2 + $static_clearance*2/sqrt(3);
  post_radius = nut_radius_with_cleraance + $thickness;

  fitting_hex_height = post_height + $thickness;

  children();
  translate(post_center_offset) {
    difference() {
      intersection() { //intersection so that the post isn't sticking out of the box top.
        translate(-post_center_offset) {
          hull() {
            children();
          }
        }
        union() {
          // post
          cylinder(h=post_height, r=post_radius);
          // fixing hex stub
          translate([0,0,post_height-nut_height]) {
            rotate(360/12) {
              cylinder(h=nut_height+$epsilon,
                       r=nut_diameter/2+$static_clearance*2/sqrt(3),
                       $fn=6);
            }
          }
        }
      }
      difference() { // difference so that the holes don't go through the box.
        union() {
          // screw hole
          cylinder(h=post_height+$epsilon,
                   r=screw("screw_thread_diameter")/2+$static_clearance);
          // nut hole
          translate([0,0,post_height-$thickness-3*nut_height-$thickness]) {
            rotate(360/12) {
              cylinder(h=3 * nut_height,
                       r=nut_diameter/2+$static_clearance*2/sqrt(3),
                       $fn=6);
            }
          }
        }
        translate(-post_center_offset) {
          children();
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

//add_nut_post([20,20,0], 50) {%cube([50,50,50]);}

