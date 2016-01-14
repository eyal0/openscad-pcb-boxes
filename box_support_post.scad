include <globals.scad>;

// post_center_offset should be relative to bottom-left corner of the box top when upside-down.
module add_top_support_post(post_center_offset, pcb_hole_diameter, pcb_thickness) {
  if (!$thickness) {
    echo("ERROR: $thickness is not set in add_top_support_post");
  }
  if (!$pcb_top_clearance) {
    echo("ERROR: $pcb_top_clearance is not set in add_top_support_post");
  }
  if (!$static_clearance) {
    echo("ERROR: $pcb_top_clearance is not set in add_top_support_post");
  }
  children(0);
  // Height of the post that supports the stub.
  post_height = $thickness + $pcb_top_clearance + $static_clearance;
  post_radius = pcb_hole_diameter/2 + $thickness + $static_clearance;
  // Height of the stub including post height.
  stub_height = post_height + $pcb_thickness + $thickness;
  stub_radius = pcb_hole_diameter/2 - $static_clearance;
  translate(post_center_offset) {
    difference() {
      intersection() { //intersection so that the post isn't sticking out of the box top.
        translate(-post_center_offset) {
          hull() {
            children(0);
          }
        }
        union() {
          // post
          cylinder(h=post_height, r=post_radius);
          // stub
          cylinder(h=stub_height, r=stub_radius);
        }
      }
    }
  }
}

// post_center_offset should be relative to bottom-left corner of the box when right-side up.
module add_bottom_support_post(post_center_offset, pcb_hole_diameter, pcb_thickness, outside_box_height) {
  if (!$thickness) {
    echo("ERROR: $thickness is not set in add_bottom_support_post");
  }
  if (!$pcb_top_clearance) {
    echo("ERROR: $pcb_top_clearance is not set in add_bottom_support_post");
  }
  if (!$pcb_thickness) {
    echo("ERROR: $pcb_thickness is not set in add_bottom_support_post");
  }
  if (!$static_clearance) {
    echo("ERROR: $pcb_top_clearance is not set in add_bottom_support_post");
  }
  children(0);
  // Height of the post that accepts the stub.
  post_height = outside_box_height - $thickness - $pcb_top_clearance - 2*$static_clearance - $pcb_thickness;
  post_radius = pcb_hole_diameter/2 + $thickness + $static_clearance;
  // Depth of hole to accept the stub.
  stub_hole_height = $pcb_thickness + $thickness + $static_clearance;
  stub_hole_radius = pcb_hole_diameter/2;
  translate(post_center_offset) {
    difference() {
      intersection() { //intersection so that the post isn't sticking out of the box top.
        translate(-post_center_offset) {
          hull() {
            children(0);
          }
        }
        difference() {
          // post
          cylinder(h=post_height, r=post_radius);
          // stub hole
          translate([0,0,post_height-stub_hole_height]) {
            cylinder(h=stub_hole_height+$epsilon, r=pcb_hole_diameter/2);
          }
        }
      }
    }
  }
}

$pcb_top_clearance = 10;
$pcb_thickness = 3;
$thickness = 2;
add_top_support_post([20,20,0], 5, 5) {%cube([50,50,50]);}
add_bottom_support_post([30,30,0], 5, 5, 50) {%cube([50,50,50]);}
