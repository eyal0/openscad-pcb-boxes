// screen_height is the height from the pcb top for the screen.
// screen_offset is the offset of the screen from the bottom left
// corner of the box when upside-down.  First child is the 2D shape of
// the screen to expose.

module add_top_screen_hole(screen_offset, screen_height) {
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
    translate(screen_offset-[0,0,$epsilon]) {
      linear_extrude($thickness+2*$epsilon, convexity=10) {
        offset(r=$thickness) {
          children(0);
        }
      }
    }
  }
  translate(screen_offset) {
    !intersection() {
      translate([0,0,$thickness]) {
        minkowski(convexity=10) {
          sphere(r=$thickness);
          linear_extrude($thickness+$pcb_top_clearance-screen_height, convexity=10) {
            difference() {
              offset(r=$thickness+$epsilon) {
                children(0);
              }
              offset(r=$thickness) {
                children(0);
              }
            }
          }
        }
      }
      #translate([0,0,-$epsilon]) {
        linear_extrude($thickness+$pcb_top_clearance-screen_height-$static_clearance+$epsilon, convexity=10) {
          offset(r=$thickness) {
            children(0);
          }
        }
      }
    }
  }
}

// Uncomment for testing.

/*
use <box_top.scad>;

$epsilon = 0.01;
$pcb_top_clearance = 10;
$pcb_thickness = 10;
$thickness = 2;
$static_clearance = 0.2;
$box_size = [100,50,30];
$fn = 30;
$dynamic_clearance = 0.4;
triangle_height = 10;
demo_box_top() {
  add_top_screen_hole([20,20,0], 5) {
    //polygon(points=[
    //          [-triangle_height/1.5, 0],
    //          [triangle_height/3, triangle_height*sqrt(3)/3],
    //          [triangle_height/3, -triangle_height*sqrt(3)/3]],
    //        paths=[
    //          [0,1,2]
    //          ]
    //  );
    square([3,3]);
    box_top();
  }
}
*/