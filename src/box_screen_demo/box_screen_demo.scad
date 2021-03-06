include <../lib/globals.scad>;
use <../lib/box_top.scad>;
use <../lib/box_bottom.scad>;
use <../lib/box_screen.scad>;

$pcb_top_clearance = 10;
$pcb_thickness = 2;
$box_size = [20,20,20];

if ($group == "demo" || $group == "top") {
  render_box_top($group == "demo" ? "demo" : "print", 2) {
    add_top_screen_hole([10,10,0], 5, 1) {
      square([3,3]);
      box_top(0);
    }
  }
}
if ($group == "demo" || $group == "bottom") {
  render_box_bottom($group == "demo" ? "demo" : "print", 1) {
    box_bottom(0);
  }
}
