include <../lib/globals.scad>;
use <../lib/box_top.scad>;
use <../lib/box_bottom.scad>;

use <../lib/box_button.scad>;
use <../lib/box_support_post.scad>;
use <../lib/box_screen.scad>;
use <../lib/screws.scad>;
use <../lib/box_screw_post.scad>;

pcb_width = 72.7;
pcb_depth = 59.9;
$pcb_thickness = 1.1;
$pcb_top_clearance = 12.3-$pcb_thickness;
pcb_bottom_clearance = 4;
screw_type = "m3";
$level = 0;
$level_count = 0;

$box_size = [pcb_width+4*$thickness,
             pcb_depth+6*$thickness+4*screw_posts_max_radius(screw_type),
             $pcb_top_clearance+$pcb_thickness+pcb_bottom_clearance+2*$thickness];
pcb_offset = [($box_size[0]-pcb_width)/2,
              ($box_size[1]-pcb_depth)/2,
              0];

module add_screw_posts_in_corners(screw_type) {
  delta_side = 2*$thickness + screw_posts_max_radius(screw_type);
  add_screw_post([$box_size[0] - delta_side, $box_size[1] - delta_side, 0], screw_type,  90, 1)
  add_screw_post([$box_size[0] - delta_side,                delta_side, 0], screw_type,  90, 2)
  add_screw_post([               delta_side, $box_size[1] - delta_side, 0], screw_type, -90, 3)
  add_screw_post([               delta_side,                delta_side, 0], screw_type, -90, 4)
    children();
}

module add_screw_holes_in_corners(screw_type) {
  delta_side = 2*$thickness + screw_posts_max_radius(screw_type);
  add_screw_hole([$box_size[0] - delta_side, $box_size[1] - delta_side, 0], screw_type,  90, 1)
  add_screw_hole([$box_size[0] - delta_side,                delta_side, 0], screw_type,  90, 2)
  add_screw_hole([               delta_side, $box_size[1] - delta_side, 0], screw_type, -90, 3)
  add_screw_hole([               delta_side,                delta_side, 0], screw_type, -90, 4)
    children();
}

pcb_hole_diameter = 3;
pcb_holes = [[                                1.1,  1.4, 0],
             [pcb_width - pcb_hole_diameter - 1.1,  1.4, 0],
             [                                1.1, 38.9, 0],
             [pcb_width - pcb_hole_diameter - 1.1,   39, 0]];

module add_top_support_posts() {
  pcb_hole_center_offset = [pcb_hole_diameter/2,pcb_hole_diameter/2,0];
  add_top_support_post(pcb_offset + pcb_holes[0] + pcb_hole_center_offset, pcb_hole_diameter, 5)
  add_top_support_post(pcb_offset + pcb_holes[1] + pcb_hole_center_offset, pcb_hole_diameter, 6)
  add_top_support_post(pcb_offset + pcb_holes[2] + pcb_hole_center_offset, pcb_hole_diameter, 7)
  add_top_support_post(pcb_offset + pcb_holes[3] + pcb_hole_center_offset, pcb_hole_diameter, 8)
    children();
}

module add_bottom_support_posts() {
  pcb_hole_center_offset = [pcb_hole_diameter/2,pcb_hole_diameter/2,0];
  add_bottom_support_post(pcb_offset + pcb_holes[0] + pcb_hole_center_offset, pcb_hole_diameter, 5)
  add_bottom_support_post(pcb_offset + pcb_holes[1] + pcb_hole_center_offset, pcb_hole_diameter, 6)
  add_bottom_support_post(pcb_offset + pcb_holes[2] + pcb_hole_center_offset, pcb_hole_diameter, 7)
  add_bottom_support_post(pcb_offset + pcb_holes[3] + pcb_hole_center_offset, pcb_hole_diameter, 8)
    children();
}
if ($group == "demo" || $group == "top") {
  render_box_top($group == "demo" ? "demo" : "print", 12) {
    add_top_button_hole(pcb_offset+[pcb_width, pcb_depth, 0]-[13.2 - 11.9/2, 13.6-11.9/2,0], 8.4-$pcb_thickness, 11) {
      circle(r=11.5/2);
      add_top_screen_hole(pcb_offset+[8+3,9,0], 5.1, 10) {
        square([56.6-2*3, 37.4-3-9]);
        add_top_screen_hole([-$epsilon, pcb_offset[1],0]+[0,pcb_depth-15,0], 0, 9) {
          translate([0,-$static_clearance]) {
            square([pcb_offset[0]+51.4+0.4+$epsilon,15+2*$static_clearance]);
          }
          add_top_support_posts() {
            add_screw_posts_in_corners(screw_type) {
              box_top(0);
            }
          }
        }
      }
    }
  }
}
if ($group == "demo" || $group == "bottom") {
  render_box_bottom($group == "demo" ? "demo" : "print", 9) {
    add_bottom_support_posts() {
      add_screw_holes_in_corners(screw_type) {
        box_bottom(0);
      }
    }
  }
}
if ($group == "demo" || $group == "button") {
  render_box_top($group == "demo" ? "demo" : "print", 1) {
    add_button(pcb_offset+[pcb_width, pcb_depth, 0]-[13.2 - 11.9/2, 13.6-11.9/2,0], 8.4-$pcb_thickness, 0) {
      circle(r=11.5/2);
    }
  }
}
