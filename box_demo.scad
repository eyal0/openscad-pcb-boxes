include <box_top.scad>;
include <box_bottom.scad>;
include <box_screw_post.scad>;
$fn = 50;
$thickness = 2;
$static_clearance = 0.2;
$dynamic_clearance = 0.4;
$epsilon = 0.01;
$box_size = [100,40,30];
demo_box_top() {
  add_screw_post([10,10,0], "m3") %box_top();
}
demo_box_bottom() {
  add_screw_hole([10,$box_size[1]-10-2*$thickness,0], "m3") %box_bottom();
}
