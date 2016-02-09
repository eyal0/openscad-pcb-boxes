use <box_top.scad>;
use <box_bottom.scad>;

use <box_button.scad>;
use <box_support_post.scad>;
use <box_screen.scad>;
use <screws.scad>;
use <box_screw_post.scad>;

//$part is one of top, bottom, button, demo.
$part = "top";

pcb_width = 72.7;
pcb_depth = 59.9;
$pcb_thickness = 1.1;
$pcb_top_clearance = 12.3-$pcb_thickness;
pcb_bottom_clearance = 4;
$thickness = 2;
$epsilon = 0.01;
$fn=10;
screw_type = "m3";
$static_clearance = 0.2;
$dynamic_clearance = 0.4;

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
  left = 1.0;
  right = pcb_width - left - pcb_hole_diameter;
  top = 1.2;
  bottom = 38.9;
  add_top_support_post(pcb_offset+[ left,    top,0] + pcb_hole_center_offset, pcb_hole_diameter)
  add_top_support_post(pcb_offset+[right,    top,0] + pcb_hole_center_offset, pcb_hole_diameter)
  add_top_support_post(pcb_offset+[ left, bottom,0] + pcb_hole_center_offset, pcb_hole_diameter)
  add_top_support_post(pcb_offset+[right, bottom,0] + pcb_hole_center_offset, pcb_hole_diameter)
    children();
}

module add_bottom_support_posts() {
  pcb_hole_diameter = 3;
  pcb_hole_center_offset = [pcb_hole_diameter/2,pcb_hole_diameter/2,0];
  left = 1.0;
  right = pcb_width - left - pcb_hole_diameter;
  top = 1.2;
  bottom = 38.9;
  add_bottom_support_post(upsidedown_offset(pcb_offset+[ left,    top,0] + pcb_hole_center_offset), pcb_hole_diameter)
  add_bottom_support_post(upsidedown_offset(pcb_offset+[right,    top,0] + pcb_hole_center_offset), pcb_hole_diameter)
  add_bottom_support_post(upsidedown_offset(pcb_offset+[ left, bottom,0] + pcb_hole_center_offset), pcb_hole_diameter)
  add_bottom_support_post(upsidedown_offset(pcb_offset+[right, bottom,0] + pcb_hole_center_offset), pcb_hole_diameter)
    children();
}

module render_parts() {
  if ($part == "top") {
    print_box_top() {
      children(0);
    }
  }
  if ($part == "bottom") {
    print_box_bottom() {
      children(1);
    }
  }
  if ($part == "button") {
    print_button() {
      children(2);
    }
  }
  if ($part == "demo") {
    demo_box_top() {
      children(0);
    }
    demo_box_bottom() {
      children(1);
    }
    demo_button(pcb_offset+[pcb_width, pcb_depth, 0]-[13.2 - 11.9/2, 13.6-11.9/2,0], 8.4-$pcb_thickness) {
      children(2);
    }
  }
}

render_parts() {
  add_top_button_hole(pcb_offset+[pcb_width, pcb_depth, 0]-[13.2 - 11.9/2, 13.6-11.9/2,0], 8.4-$pcb_thickness) {
    circle(r=11.5/2);
    add_top_screen_hole(pcb_offset+[8+3,0,0], 5.1) {
      square([56.6-2*3, 37.4-3-9]);
      add_top_screen_hole([0,pcb_offset[1],0]+[-0.4,pcb_depth-14.5,0], 0) {
        square([51.4+0.4,14.9]);
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
