include <../lib/globals.scad>;
use <../lib/box_top.scad>;
use <../lib/box_bottom.scad>;

use <../lib/box_port.scad>;

$pcb_top_clearance = 10;
$pcb_thickness = 10;
$box_size = [100,50,30];
$inner_thickness = 1;
$rounding = 0.5;
module arrow_up() {
  circle(r=5);
  /*polygon(points=[
      [0,7],
      [5,7],
      [5,0],
      [2,3],
      [0,0]            
                  ],
          paths=[
              [0,1,2,3,4]
                 ]
          );*/
}
$fn=20;
$group = "bottom";
$level = -1;
if ($group == "demo" || $group == "top") {
  render_box_top($group == "demo" ? "demo" : "print", 2) {
    add_front_port_top([15,0,15], 1) {
      arrow_up();
      box_top(0);
    }
  }
}
if ($group == "demo" || $group == "bottom") {
  render_box_bottom($group == "demo" ? "demo" : "print", 2) {
    add_front_port_bottom([15,0,15], 1)  {
      arrow_up();
      box_bottom(0);
    }
  }
}
/*if ($group == "demo" || $group == "bottom") {
  render_box_bottom($group == "demo" ? "demo" : "print", 0) {
    box_bottom(0);
  }
}
*/
