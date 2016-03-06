use <../lib/box_top.scad>;
use <../lib/box_bottom.scad>;

use <../lib/box_screw_post.scad>;
include <../lib/box_render.scad>;

$thickness = 2;
$epsilon = 0.01;
$fn=10;
screw_type = "m3";
// Below clearances assume accurate printing that might require XY compensation.
$static_clearance = 0.25;
$dynamic_clearance = 0.35;

$box_size = [30,30,20];

render_parts() {
  add_screw_post([$box_size[0]/2,$box_size[1]/2,0], "m3", 5){
    box_top();
  }
  add_screw_hole([$box_size[0]/2,$box_size[1]-$box_size[1]/2,0], "m3", -5){
    box_bottom();
  }
}
