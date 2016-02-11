// post_center_offset should be relative to bottom-left corner of the
// box top when upside-down.
// $pcb_top_clearance is the height between the top of the PCB and the
// inside of the box.  Any parts sticking above $pcb_top_clearance
// will require a hole in the top of the box.
module add_top_support_post(post_center_offset, pcb_hole_diameter) {
  if (!$thickness) {
    echo("ERROR: $thickness is not set in add_top_support_post");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$pcb_top_clearance) {
    echo("ERROR: $pcb_top_clearance is not set in add_top_support_post");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$pcb_thickness) {
    echo("ERROR: $pcb_thickness is not set in add_top_support_post");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$static_clearance) {
    echo("ERROR: $static_clearance is not set in add_top_support_post");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  children();
  // Height of the post that supports the stub.
  post_height = $thickness + $pcb_top_clearance - $static_clearance;
  // Height of the stub including post height.
  stub_height = post_height + $pcb_thickness + $thickness;

  stub_radius = pcb_hole_diameter/2 - $static_clearance;
  post_radius = stub_radius + $thickness;
  translate(post_center_offset) {
    intersection() { //intersection so that the post isn't sticking out of the box top.
      translate(-post_center_offset) {
        hull() {
          children();
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

// post_center_offset should be relative to bottom-left corner of the box when right-side up.
module add_bottom_support_post(post_center_offset, pcb_hole_diameter) {
  if (!$thickness) {
    echo("ERROR: $thickness is not set in add_bottom_support_post");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$pcb_top_clearance) {
    echo("ERROR: $pcb_top_clearance is not set in add_bottom_support_post");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$pcb_thickness) {
    echo("ERROR: $pcb_thickness is not set in add_bottom_support_post");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$static_clearance) {
    echo("ERROR: $static_clearance is not set in add_bottom_support_post");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$box_size) {
    echo("ERROR: $box_size is not set in add_bottom_support_post");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$epsilon) {
    echo("ERROR: $epsilon is not set in add_bottom_support_post");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  children();
  // Height of the post that accepts the stub.
  // Box outer height - post height of screw hole - pcb thickness - offset if post is floating
  post_height = $box_size[2] -
    ($thickness + $pcb_top_clearance - $static_clearance) // post height from the top
    - $pcb_thickness
    - $static_clearance - post_center_offset[2];
  // Depth of hole to accept the stub.
  stub_hole_height = $thickness;

  // Radii copied from above.
  // Add static clearance compared to above.
  stub_radius = pcb_hole_diameter/2 - $static_clearance + $static_clearance;
  post_radius = stub_radius + $thickness;

  translate(post_center_offset) {
    difference() {
      // post
      cylinder(h=post_height, r=post_radius);
      // stub hole
      translate([0,0,post_height-stub_hole_height]) {
        cylinder(h=stub_hole_height+$epsilon, r=stub_radius);
      }
    }
  }
}

// Uncomment for testing.

/*
use <box_top.scad>;
use <box_bottom.scad>;

$epsilon = 0.01;
$pcb_top_clearance = 10;
$pcb_thickness = 10;
$thickness = 2;
$static_clearance = 0.2;
$box_size = [100,50,30];
$fn = 50;
demo_box_top() add_top_support_post([20,20,0], 5) {box_top();}
demo_box_bottom() add_bottom_support_post([20,30,0], 5) {%box_bottom();}
*/
