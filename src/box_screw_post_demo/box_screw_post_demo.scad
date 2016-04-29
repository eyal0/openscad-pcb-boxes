include <../lib/globals.scad>;
use <../lib/box_top.scad>;
use <../lib/box_bottom.scad>;

use <../lib/box_screw_post.scad>;

screw_type = "m3";

$box_size = [100,100,40];
if ($group == "demo" || $group == "top") {
  render_box_top($group == "demo" ? "demo" : "print", 3) {
    add_screw_post([10,$box_size[1]/3*2,0], "m3", 0, 2){
      add_screw_post([10,$box_size[1]/3,0], "m3", 0, 1){
        box_top(0);
      }
    }
  }
}
if ($group == "demo" || $group == "bottom") {
  render_box_bottom($group == "demo" ? "demo" : "print", 3) {
    add_screw_hole([10,$box_size[1]/3*2,0], "m3", 0, 2){
      add_screw_hole([10,$box_size[1]/3,0], "m3", 0, 1){
        box_bottom(0);
      }
    }
  }
}
