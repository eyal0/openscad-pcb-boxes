use <box_top.scad>;
use <box_bottom.scad>;

use <box_button.scad>;
use <box_support_post.scad>;
use <box_screen.scad>;
use <screws.scad>;
use <box_screw_post.scad>;


pcb_width = 72.7;
pcb_depth = 59.9;
$pcb_thickness = 1.1;
$pcb_top_clearance = 11.1-$pcb_thickness;
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

module add_screw_posts_in_corners(screw_type) {
  delta_side = 2*$thickness + screw_posts_max_radius(screw_type);
  add_screw_post([$box_size[0] - delta_side, $box_size[1] - delta_side, 0], "m3")
  add_screw_post([$box_size[0] - delta_side,                delta_side, 0], "m3")
  add_screw_post([               delta_side, $box_size[1] - delta_side, 0], "m3")
  add_screw_post([               delta_side,                delta_side, 0], "m3")
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


add_top_button_hole(pcb_offset+[pcb_width, pcb_depth, 0]-[13.2/2,13.5/2,0], 10) {// need to measure these
  circle(r=11.5/2);
  add_top_screen_hole(pcb_offset+[8,0,0], 5.1) { // need to measure offset of screen
    square([56.6,37.4]);
    add_top_screen_hole([0,pcb_offset[1],0]+[-0.4,pcb_depth-14.5,0], 0) {
      square([48.7+0.4,14.8+0.3]);
      add_top_support_posts() {
        add_screw_posts_in_corners("m3") {
          box_top();
        }
      }
    }
  }
}
