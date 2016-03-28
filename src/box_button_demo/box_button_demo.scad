include <../lib/globals.scad>;
use <../lib/box_top.scad>;
use <../lib/box_bottom.scad>;

use <../lib/box_button.scad>;

$pcb_top_clearance = 10;
$pcb_thickness = 10;
$box_size = [100,50,30];
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

$group = "bottom";
if ($group == "list") {
  echo("Printable: top, button, bottom");
  echo("All: demo, top, button, bottom");
}
if ($group == "demo" || $group == "top") {
  render_box_top($group == "demo" ? "demo" : "print") {
    add_top_button_hole([15,15,0], 5) {
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
if ($group == "demo" || $group == "bottom") {
  render_box_bottom($group == "demo" ? "demo" : "print") {
    box_bottom();
  }
}
