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
    polygon(points=[
              [0, 0],
              [5,0],
              [0,12]],
            paths=[
              [0,1,2]
              ]
      );
}
$group = "bottom";
$level = 0;
if ($group == "demo" || $group == "top") {
  //render_box_top($group == "demo" ? "demo" : "print", 0) {
    add_front_port_top([15,0,15], 0) {
      arrow_up();
      box_top(0);
    }
  //}
}
if ($group == "demo" || $group == "bottom") {
  //render_box_top($group == "demo" ? "demo" : "print", 0) {
    add_front_port_bottom([15,0,15], 0)  {
      arrow_up();
      box_bottom(0);
    }
  //}
}
/*if ($group == "demo" || $group == "bottom") {
  render_box_bottom($group == "demo" ? "demo" : "print", 0) {
    box_bottom(0);
  }
}
*/
