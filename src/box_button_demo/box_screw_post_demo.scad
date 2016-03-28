include <../lib/globals.scad>;
use <../lib/box_top.scad>;
use <../lib/box_bottom.scad>;

use <../lib/box_screw_post.scad>;

screw_type = "m3";

$box_size = [30,30,20];

if ($group == "list") {
  echo("Printable: top, bottom");
  echo("All: demo, top, bottom");
}
if ($group == "demo" || $group == "top") {
  render_box_top($group == "demo" ? "demo" : "print") {
    add_screw_post([$box_size[0]/2,$box_size[1]/2,0], "m3", 5){
      box_top();
    }
  }
}
if ($group == "demo" || $group == "bottom") {
  render_box_bottom($group == "demo" ? "demo" : "print") {
    add_screw_hole([$box_size[0]/2,$box_size[1]-$box_size[1]/2,0], "m3", -5){
      box_bottom();
    }
  }
}
