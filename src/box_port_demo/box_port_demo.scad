include <../lib/globals.scad>;
use <../lib/box_top.scad>;
use <../lib/box_bottom.scad>;

use <../lib/box_port.scad>;

$pcb_top_clearance = 10;
$pcb_thickness = 10;
$box_size = [100,50,30];
$inner_thickness = 1;
$rounding = 0.5;

$group = "bottom";
$level = -1;
if ($group == "demo" || $group == "top") {
  render_box_top($group == "demo" ? "demo" : "print", 3) {
    add_front_port_top([15,0,15], 3, 2) {
      add_front_port_top([15,0,15], 3, 1) {
        box_top(0);
      }
    }
  }
}
if ($group == "demo" || $group == "bottom") {
  render_box_bottom($group == "demo" ? "demo" : "print", 3) {
    add_front_port_bottom([35,0,15], 3, 2)  {
      add_front_port_bottom([15,0,15], 3, 1)  {
        box_bottom(0);
      }
    }
  }
}
