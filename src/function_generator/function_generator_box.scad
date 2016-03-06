use <../lib/box_top.scad>;
use <../lib/box_bottom.scad>;

use <../lib/box_button.scad>;
use <../lib/box_support_post.scad>;
use <../lib/box_screen.scad>;
use <../lib/screws.scad>;
use <../lib/box_screw_post.scad>;
include <../lib/box_render.scad>;

pcb_width = 80;
pcb_depth = 80;
$pcb_thickness = 1.5;
$thickness = 2;
$pcb_top_clearance = 18.9 + $thickness;
pcb_bottom_clearance = 3.3;
$epsilon = 0.01;
$fn=10;
screw_type = "m3";
$static_clearance = 0.2;
$dynamic_clearance = 0.4;

$box_size = [pcb_width+6*$thickness+4*screw_posts_max_radius(screw_type),
             pcb_depth+4*$thickness,
             $pcb_top_clearance+$pcb_thickness+pcb_bottom_clearance+2*$thickness];
pcb_offset = [($box_size[0]-pcb_width)/2,
              ($box_size[1]-pcb_depth)/2,
              0];

// v is a row vector.  Output is the offset needed if the box is upsidedown
function upsidedown_offset(v) = [v[0], $box_size[1]-v[1], v[2]];
function upsidedown_rotate(angle) = -angle;

module add_screw_posts_in_corners(screw_type) {
  delta_side = 2*$thickness + screw_posts_max_radius(screw_type);
  add_screw_post([$box_size[0] - delta_side, $box_size[1] - delta_side, 0], screw_type, 180)
  add_screw_post([$box_size[0] - delta_side,                delta_side, 0], screw_type,   0)
  add_screw_post([               delta_side, $box_size[1] - delta_side, 0], screw_type, 180)
  add_screw_post([               delta_side,                delta_side, 0], screw_type,   0)
    children();
}

module add_screw_holes_in_corners(screw_type) {
  delta_side = 2*$thickness + screw_posts_max_radius(screw_type);
  add_screw_hole(upsidedown_offset([$box_size[0] - delta_side, $box_size[1] - delta_side, 0]), screw_type, upsidedown_rotate(180))
  add_screw_hole(upsidedown_offset([$box_size[0] - delta_side,                delta_side, 0]), screw_type, upsidedown_rotate(  0))
  add_screw_hole(upsidedown_offset([               delta_side, $box_size[1] - delta_side, 0]), screw_type, upsidedown_rotate(180))
  add_screw_hole(upsidedown_offset([               delta_side,                delta_side, 0]), screw_type, upsidedown_rotate(  0))
    children();
}

module add_top_support_posts() {
  pcb_hole_diameter = 3.3;
  pcb_hole_center_offset = [pcb_hole_diameter/2,pcb_hole_diameter/2,0];
  top_left  =   [                                2.4,  2.4, 0];
  top_right =   [pcb_width - pcb_hole_diameter - 2.5,  2.5, 0];
  bottom_left = [                                2.5, 74.2, 0];
  bottom_right =[pcb_width - pcb_hole_diameter - 2.5, 74.2, 0];
  add_top_support_post(pcb_offset+ top_left     + pcb_hole_center_offset, pcb_hole_diameter)
  add_top_support_post(pcb_offset+ top_right    + pcb_hole_center_offset, pcb_hole_diameter)
  add_top_support_post(pcb_offset+ bottom_left  + pcb_hole_center_offset, pcb_hole_diameter)
  add_top_support_post(pcb_offset+ bottom_right + pcb_hole_center_offset, pcb_hole_diameter)
    children();
}

module add_bottom_support_posts() {
  pcb_hole_diameter = 3.3;
  pcb_hole_center_offset = [pcb_hole_diameter/2,pcb_hole_diameter/2,0];
  top_left  =   [                                2.4,  2.4, 0];
  top_right =   [pcb_width - pcb_hole_diameter - 2.5,  2.5, 0];
  bottom_left = [                                2.5, 74.2, 0];
  bottom_right =[pcb_width - pcb_hole_diameter - 2.5, 74.2, 0];
  add_bottom_support_post(upsidedown_offset(pcb_offset + top_left + pcb_hole_center_offset), pcb_hole_diameter)
  add_bottom_support_post(upsidedown_offset(pcb_offset + top_right + pcb_hole_center_offset), pcb_hole_diameter)
  add_bottom_support_post(upsidedown_offset(pcb_offset + bottom_left + pcb_hole_center_offset), pcb_hole_diameter)
  add_bottom_support_post(upsidedown_offset(pcb_offset + bottom_right + pcb_hole_center_offset), pcb_hole_diameter)
    children();
}

render_parts() {
  add_top_button_hole(pcb_offset+[pcb_width, pcb_depth, 0]-[13.2 - 11.9/2, 13.6-11.9/2,0], 8.4-$pcb_thickness) {
    circle(r=11.5/2);
    add_top_screen_hole(pcb_offset+[4.4+$thickness, 14+$thickness,0], 18.9) {
      square([71.1-2*$thickness, 24-2*$thickness]);
      add_top_support_posts() {
        add_screw_posts_in_corners("m3") {
          box_top();
        }
      }
    }
  }
  add_bottom_support_posts() {
    add_screw_holes_in_corners("m3") {
      box_bottom();
    }
  }
  add_button(8.4-$pcb_thickness) {
    circle(r=11.5/2);
  }
}
