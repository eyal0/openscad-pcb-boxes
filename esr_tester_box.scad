use <box_top.scad>;
use <box_bottom.scad>;

use <screws.scad>;
use <box_screw_post.scad>;
$pcb_width = 72.7;
$pcb_depth = 59.9;
$pcb_thickness = 1.1;
$pcb_top_clearance = 11.1-$pcb_thickness;
$pcb_bottom_clearance = 4;
$thickness = 2;
$epsilon = 0.01;
$fn=50;
screw_type = "m3";
$static_clearance = 0.2;
$dynamic_clearance = 0.4;

$box_size = [$pcb_width+4*$thickness,
             $pcb_depth+6*$thickness+4*screw_posts_max_radius(screw_type),
             $pcb_top_clearance+$pcb_thickness+$pcb_bottom_clearance+2*$thickness];

module add_screw_posts_in_corners(screw_type) {
  delta_side = 2*$thickness + screw_posts_max_radius(screw_type);
  add_screw_post([$box_size[0] - delta_side, $box_size[1] - delta_side, 0], "m3")
  add_screw_post([$box_size[0] - delta_side,                delta_side, 0], "m3")
  add_screw_post([               delta_side, $box_size[1] - delta_side, 0], "m3")
  add_screw_post([               delta_side,                delta_side, 0], "m3")
    children();
}

add_screw_posts_in_corners("m3") {
    box_top();
}
