include <../lib/globals.scad>;
use <../lib/box_top.scad>;
use <../lib/box_bottom.scad>;

use <../lib/box_button.scad>;

$pcb_top_clearance = 10;
$pcb_thickness = 10;
$box_size = [100,50,30];
triangle_height = 10;
module arrow_up() {
    polygon(points=[
              [0, 12],
              [-5,-1],
              [5,-1]],
            paths=[
              [0,1,2]
              ]
      );
}

$group = "demo";
if ($group == "list") {
  echo("Printable: top, button");
  echo("All: demo, top, button");
}
if ($group == "demo" || $group == "top") {
  render_box_top($group == "demo" ? "demo" : "print") {
    add_top_button_hole([20,20,0], 5) {
      arrow_up();
      box_top();
    }
  }
}
if ($group == "demo" || $group == "button") {
  render_box_button($group == "demo" ? "demo" : "print") {
    add_button([15,15,0], 5) {
      arrow_up();
    }
  }
}
