use <box_top.scad>;
use <box_bottom.scad>;
use <box_screw_post.scad>;
use <screws.scad>;

$pcb_width = 72.7;
$pcb_depth = 59.9;
$pcb_thickness = 1.1;
$pcb_top_clearance = 11.1-$pcb_thickness;
$pcb_bottom_clearance = 4;
$thickness = 2;
$epsilon = 0.01;
$fn=50;
screw_type = "m3";

$box_size = [$pcb_width+4*$thickness,
             $pcb_depth+6*$thickness+4*screw_posts_max_radius(screw_type),
             $pcb_top_clearance+$pcb_thickness+$pcb_bottom_clearance+2*$thickness];

box_top();
