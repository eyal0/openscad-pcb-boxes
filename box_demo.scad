use <lib/box_top.scad>;
use <lib/box_bottom.scad>;
use <lib/box_screw_post.scad>;
use <lib/box_support_post.scad>;

$fn = 50;
$thickness = 2;
$static_clearance = 0.2;
$dynamic_clearance = 0.4;
$epsilon = 0.01;
$box_size = [100,50,40];
$pcb_top_clearance = 2;
$pcb_thickness = 4;
demo_box_top() {
  add_top_support_post([20,20,0], 6)
    add_screw_post([10,10,0], "m3")
    box_top();
}
demo_box_bottom() {
  add_bottom_support_post([20,$box_size[1]-20,0], 6)
    add_screw_hole([10,$box_size[1]-10,0], "m3")
    box_bottom();
}
