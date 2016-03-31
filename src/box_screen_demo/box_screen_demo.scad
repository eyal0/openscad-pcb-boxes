include <../lib/globals.scad>;
use <../lib/box_top.scad>;
use <../lib/box_bottom.scad>;
use <../lib/box_screen.scad>;

$pcb_top_clearance = 10;
$pcb_thickness = 10;
$box_size = [20,20,20];

$group = "demo";
if ($group == "list") {
  echo("Printable: top, bottom");
  echo("All: demo, top, bottom");
}

if ($group == "demo" || $group == "top") {
  render_box_top($group == "demo" ? "demo" : "print") {
    add_top_screen_hole([10,10,0], 5) {
      square([3,3]);
      box_top();
    }
  }
}
if ($group == "demo" || $group == "bottom") {
  render_box_bottom($group == "demo" ? "demo" : "print") {
    box_bottom();
  }
}
