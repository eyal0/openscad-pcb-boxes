include <../lib/globals.scad>;
use <../lib/box_top.scad>;
use <../lib/box_bottom.scad>;

use <../lib/box_button.scad>;
use <../lib/box_support_post.scad>;
use <../lib/box_screen.scad>;
use <../lib/screws.scad>;
use <../lib/box_screw_post.scad>;
use <../lib/box_port.scad>;

pcb_width = 80;
pcb_depth = 80;
$pcb_thickness = 1.5;
$pcb_top_clearance = 18.9 + $thickness;
pcb_bottom_clearance = 3.3;
screw_type = "m3";

$box_size = [pcb_width+6*$thickness+4*screw_posts_max_radius(screw_type),
             pcb_depth+4*$thickness,
             $pcb_top_clearance+$pcb_thickness+pcb_bottom_clearance+2*$thickness];
pcb_offset = [($box_size[0]-pcb_width)/2,
              ($box_size[1]-pcb_depth)/2,
              0];

module add_screw_posts_in_corners(screw_type) {
  delta_side = 2*$thickness + screw_posts_max_radius(screw_type);
  add_screw_post([$box_size[0] - delta_side, $box_size[1] - delta_side, 0], screw_type, -90, 1)
  add_screw_post([$box_size[0] - delta_side,                delta_side, 0], screw_type,  90, 2)
  add_screw_post([               delta_side, $box_size[1] - delta_side, 0], screw_type, -90, 3)
  add_screw_post([               delta_side,                delta_side, 0], screw_type,  90, 4)
    children();
}

module add_screw_holes_in_corners(screw_type) {
  delta_side = 2*$thickness + screw_posts_max_radius(screw_type);
  add_screw_hole([$box_size[0] - delta_side, $box_size[1] - delta_side, 0], screw_type, -90, 1)
  add_screw_hole([$box_size[0] - delta_side,                delta_side, 0], screw_type,  90, 2)
  add_screw_hole([               delta_side, $box_size[1] - delta_side, 0], screw_type, -90, 3)
  add_screw_hole([               delta_side,                delta_side, 0], screw_type,  90, 4)
    children();
}

pcb_hole_diameter = 3.3;
pcb_holes = [[                                2.4,  2.4, 0],
             [pcb_width - pcb_hole_diameter - 2.5,  2.5, 0],
             [                                2.5, 74.2, 0],
             [pcb_width - pcb_hole_diameter - 2.5, 74.2, 0]];
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

// Make a 2D equilateral triangle centered, pointing up (which is along negative y)
module triangle_up(triangle_side) {
  triangle_height = triangle_side*sqrt(3)/2;
  polygon(points=[[               0, -triangle_height*2/3],
                  [-triangle_side/2,  triangle_height*1/3],
                  [ triangle_side/2,  triangle_height*1/3]],
          paths=[[0,2,1]]);
}

module arrow_up() {
  triangle_up(8);
}

module reverse_difference() {
  difference() {
    children([1:$children-1]);
    children(0);
  }
}

//$group = "demo";

$inner_thickness = 1;
if ($group == "demo" || $group == "top") {
  render_box_top($group == "demo" ? "demo" : "print", 18) {
    // Left BNC.
    add_front_port_top([pcb_offset[0]+16.09,0,$thickness+pcb_bottom_clearance+$pcb_thickness+12.25/2], 17) {
      circle(r=12.25/2+$static_clearance);
      add_top_screen_hole(pcb_offset+[1.07,pcb_depth-33,0], 0, 16) {
        square([5.53, 13.2]);
        add_top_button_hole(pcb_offset+[pcb_width, pcb_depth, 0]-[4.9, 22.8, 0], 8.3, 15) {
          rotate(90) arrow_up();
          add_top_button_hole(pcb_offset+[pcb_width, pcb_depth, 0]-[4.9+10.03333*2, 22.8, 0], 8.3, 14) {
            rotate(-90) arrow_up();
            add_top_button_hole(pcb_offset+[pcb_width, pcb_depth, 0]-[4.9+10.03333, 22.8+10.03333, 0], 8.3, 13) {
              rotate(0) arrow_up();
              add_top_button_hole(pcb_offset+[pcb_width, pcb_depth, 0]-[4.9+10.03333, 22.8-10.03333, 0], 8.3, 12) {
                rotate(180) arrow_up();
                add_top_button_hole(pcb_offset+[pcb_width, pcb_depth, 0]-[4.9+10.03333, 22.8, 0], 8.3, 11) {
                  circle(r=4);
                  add_top_button_hole(pcb_offset+[pcb_width, pcb_depth, 0]-[4.9+10.03333*3, 22.8, 0], 8.3, 10) {
                    translate([-4, -4]) square([8,8]);
                    add_top_screen_hole(pcb_offset+[4.4+$thickness, 14+$thickness,0], 18.9, 9) {
                      square([71.1-2*$thickness, 24-2*$thickness]);
                      add_top_support_posts() {
                        add_screw_posts_in_corners(screw_type) {
                          reverse_difference() {
                            union() {
                              // Right BNC.
                              translate([pcb_offset[0]+16.09+16.71,
                                         $box_size[1]+$epsilon,
                                         $box_size[2]-$thickness-pcb_bottom_clearance-$pcb_thickness-12.25/2]) {
                                rotate([90,0,0]) {
                                  cylinder(h=$thickness+2*$epsilon, r=12.25/2+$static_clearance);
                                }
                              }
                              // Right knob.
                              translate([pcb_offset[0]+pcb_width-15.04,
                                         $box_size[1]+$epsilon,
                                         $box_size[2]-$thickness-pcb_bottom_clearance-$pcb_thickness-6.99]) {
                                rotate([90,0,0]) {
                                  cylinder(h=$thickness+2*$epsilon, r=7/2+$static_clearance);
                                }
                              }
                              // Left knob.
                              translate([pcb_offset[0]+pcb_width-28.26,
                                         $box_size[1]+$epsilon,
                                         $box_size[2]-$thickness-pcb_bottom_clearance-$pcb_thickness-6.99]) {
                                rotate([90,0,0]) {
                                  cylinder(h=$thickness+2*$epsilon, r=7/2+$static_clearance);
                                }
                              }
                            }
                            box_top(0);
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
if ($group == "demo" || $group == "bottom") {
  render_box_bottom($group == "demo" ? "demo" : "print", 10) {
    add_front_port_bottom([pcb_offset[0]+16.09,0,$thickness+pcb_bottom_clearance+$pcb_thickness+12.25/2], 9) {
      circle(r=12.25/2+$static_clearance);
      add_bottom_support_posts() {
        add_screw_holes_in_corners(screw_type) {
          box_bottom(0);
        }
      }
    }
  }
}

if ($group == "demo" || $group == "right") {
  render_box_top($group == "demo" ? "demo" : "print", 1) {
    add_button(pcb_offset+[pcb_width, pcb_depth, 0]-[4.9, 22.8, 0], 8.3, 0) {
      rotate(-90) arrow_up();
    }
  }
}

if ($group == "demo" || $group == "left") {
  render_box_top($group == "demo" ? "demo" : "print", 1) {
    add_button(pcb_offset+[pcb_width, pcb_depth, 0]-[4.9+10.03333*2, 22.8, 0], 8.3, 0) {
      rotate(90) arrow_up();
    }
  }
}

if ($group == "demo" || $group == "up") {
  render_box_top($group == "demo" ? "demo" : "print", 1) {
    add_button(pcb_offset+[pcb_width, pcb_depth, 0]-[4.9+10.03333, 22.8+10.03333, 0], 8.3, 0) {
      rotate(0) arrow_up();
    }
  }
}

if ($group == "demo" || $group == "down") {
  render_box_top($group == "demo" ? "demo" : "print", 1) {
    add_button(pcb_offset+[pcb_width, pcb_depth, 0]-[4.9+10.03333, 22.8-10.03333, 0], 8.3, 0) {
      rotate(180) arrow_up();
    }
  }
}

if ($group == "demo" || $group == "ok") {
  render_box_top($group == "demo" ? "demo" : "print", 1) {
    add_button(pcb_offset+[pcb_width, pcb_depth, 0]-[4.9+10.03333, 22.8, 0], 8.3, 0) {
      circle(r=3);
    }
  }
}

if ($group == "demo" || $group == "reset") {
  render_box_bottom($group == "demo" ? "demo" : "print", 1) {
    add_button(pcb_offset+[pcb_width, pcb_depth, 0]-[4.9+10.03333*3, 22.8, 0], 8.3, 0) {
      translate([-3, -3]) square([6,6]);
    }
  }
}
