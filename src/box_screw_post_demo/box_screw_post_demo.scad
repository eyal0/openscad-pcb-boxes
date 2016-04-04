include <../lib/globals.scad>;
use <../lib/box_top.scad>;
use <../lib/box_bottom.scad>;

use <../lib/box_screw_post.scad>;

screw_type = "m3";

$box_size = [40,20,20];
if ($group == "demo" || $group == "top") {
  render_box_top($group == "demo" ? "demo" : "print", 2) {
    add_screw_post([10,$box_size[1]/2,0], "m3", 0, 1){
      box_top(0);
    }
  }
}
if ($group == "demo" || $group == "bottom") {
  render_box_bottom($group == "demo" ? "demo" : "print", 2) {
    add_screw_hole([10,$box_size[1]/2,0], "m3", 0, 1){
      box_bottom(0);
    }
  }
}
