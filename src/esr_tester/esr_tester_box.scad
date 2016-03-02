use <../lib/box_top.scad>;
use <../lib/box_bottom.scad>;

use <../lib/box_button.scad>;
use <../lib/box_support_post.scad>;
use <../lib/box_screen.scad>;
use <../lib/screws.scad>;
use <../lib/box_screw_post.scad>;
use <../lib/negative_minkowski.scad>;
use <../lib/xy_offset.scad>;
include <../lib/box_render.scad>;


pcb_width = 72.7;
pcb_depth = 59.9;
$pcb_thickness = 1.1;
$pcb_top_clearance = 12.3-$pcb_thickness;
pcb_bottom_clearance = 4;
$thickness = 2;
$epsilon = 0.01;
$fn=10;
screw_type = "m3";
// Below clearances assume accurate printing that might require XY compensation.
$static_clearance = 0.25;
$dynamic_clearance = 0.35;

$box_size = [pcb_width+4*$thickness,
             pcb_depth+6*$thickness+4*screw_posts_max_radius(screw_type),
             $pcb_top_clearance+$pcb_thickness+pcb_bottom_clearance+2*$thickness];
pcb_offset = [($box_size[0]-pcb_width)/2,
              ($box_size[1]-pcb_depth)/2,
              0];

// v is a row vector.  Output is the offset needed if the box is upsidedown
function upsidedown_offset(v) = [v[0], $box_size[1]-v[1], v[2]];
function upsidedown_rotate(angle) = -angle;

module add_screw_posts_in_corners(screw_type) {
  delta_side = 2*$thickness + screw_posts_max_radius(screw_type);
  add_screw_post([$box_size[0] - delta_side, $box_size[1] - delta_side, 0], "m3",  90)
  add_screw_post([$box_size[0] - delta_side,                delta_side, 0], "m3",  90)
  add_screw_post([               delta_side, $box_size[1] - delta_side, 0], "m3", -90)
  add_screw_post([               delta_side,                delta_side, 0], "m3", -90)
    children();
}

module add_screw_holes_in_corners(screw_type) {
  delta_side = 2*$thickness + screw_posts_max_radius(screw_type);
  add_screw_hole(upsidedown_offset([$box_size[0] - delta_side, $box_size[1] - delta_side, 0]), "m3", upsidedown_rotate( 90))
  add_screw_hole(upsidedown_offset([$box_size[0] - delta_side,                delta_side, 0]), "m3", upsidedown_rotate( 90))
  add_screw_hole(upsidedown_offset([               delta_side, $box_size[1] - delta_side, 0]), "m3", upsidedown_rotate(-90))
  add_screw_hole(upsidedown_offset([               delta_side,                delta_side, 0]), "m3", upsidedown_rotate(-90))
    children();
}

module add_top_support_posts() {
  pcb_hole_diameter = 3;
  pcb_hole_center_offset = [pcb_hole_diameter/2,pcb_hole_diameter/2,0];
  top_left  =   [                                1.1,  1.4, 0];
  top_right =   [pcb_width - pcb_hole_diameter - 1.1,  1.4, 0];
  bottom_left = [                                1.1, 38.9, 0];
  bottom_right =[pcb_width - pcb_hole_diameter - 1.1,   39, 0];
  add_top_support_post(pcb_offset+ top_left     + pcb_hole_center_offset, pcb_hole_diameter)
  add_top_support_post(pcb_offset+ top_right    + pcb_hole_center_offset, pcb_hole_diameter)
  add_top_support_post(pcb_offset+ bottom_left  + pcb_hole_center_offset, pcb_hole_diameter)
  add_top_support_post(pcb_offset+ bottom_right + pcb_hole_center_offset, pcb_hole_diameter)
    children();
}

module add_bottom_support_posts() {
  pcb_hole_diameter = 3;
  pcb_hole_center_offset = [pcb_hole_diameter/2,pcb_hole_diameter/2,0];
  top_left  =   [                                1.1,  1.4, 0];
  top_right =   [pcb_width - pcb_hole_diameter - 1.1,  1.4, 0];
  bottom_left = [                                1.1, 38.9, 0];
  bottom_right =[pcb_width - pcb_hole_diameter - 1.1,   39, 0];
  add_bottom_support_post(upsidedown_offset(pcb_offset + top_left + pcb_hole_center_offset), pcb_hole_diameter)
  add_bottom_support_post(upsidedown_offset(pcb_offset + top_right + pcb_hole_center_offset), pcb_hole_diameter)
  add_bottom_support_post(upsidedown_offset(pcb_offset + bottom_left + pcb_hole_center_offset), pcb_hole_diameter)
  add_bottom_support_post(upsidedown_offset(pcb_offset + bottom_right + pcb_hole_center_offset), pcb_hole_diameter)
    children();
}

render_parts() {
  add_top_button_hole(pcb_offset+[pcb_width, pcb_depth, 0]-[13.2 - 11.9/2, 13.6-11.9/2,0], 8.4-$pcb_thickness) {
    circle(r=11.5/2);
    add_top_screen_hole(pcb_offset+[8+3,9,0], 5.1) {
      square([56.6-2*3, 37.4-3-9]);
      add_top_screen_hole([-$epsilon, pcb_offset[1],0]+[0,pcb_depth-15,0], 0) {
        translate([0,-$static_clearance]) {
          square([pcb_offset[0]+51.4+0.4+$epsilon,15+2*$static_clearance]);
        }
        add_top_support_posts() {
          add_screw_posts_in_corners("m3") {
            box_top();
          }
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
