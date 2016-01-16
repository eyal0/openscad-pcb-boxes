include <box_top.scad>;
include <box_bottom.scad>;
include <box_screw_post.scad>;
$fn = 50;
$thickness = 2;
$static_clearance = 0.2;
$dynamic_clearance = 0.4;
$epsilon = 0.01;
$box_size = [100,50,40];
demo_box_top() {
  add_screw_post([6,6,10], "m3")
    %box_top();
}
demo_box_bottom() {
  add_screw_hole([6,$box_size[1]-6,0], "m3")
    %box_bottom();
}
