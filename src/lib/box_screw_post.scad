use <screws.scad>;
use <upsidedown.scad>;
use <import_children.scad>;

function screw_hole_post_radius(screw_type) = get_screw_param(screw_type, "screw_head_diameter")/2 + $static_clearance + $thickness;
function screw_post_radius(screw_type) = get_screw_param(screw_type, "nut_diameter")/2 + $dynamic_clearance*2/sqrt(3) + $thickness; // matching post_radius below
function screw_posts_max_radius(screw_type) =
  screw_hole_post_radius(screw_type) > screw_post_radius(screw_type) ?
  screw_hole_post_radius(screw_type) :
  screw_post_radius(screw_type);
    function range(least, most, value) = max(least, min(value, most));


// nut_opening_rotation 0 is to the right when viewed above.  positive values rotate positive y.
// screw_center_offset should be relative to bottom-left corner of the box bottom when upright.
module add_screw_hole(screw_center_offset, screw_type, nut_opening_rotation, level) {
  function screw(p) = get_screw_param(screw_type, p);
  level_preamble(level) {
    children();
    if (!$thickness) {
      echo("ERROR: $thickness not defined in add_screw_hole");
      UNDEFINED_DYNAMIC_VARIABLE_ERROR();
    }
    if (!$static_clearance) {
      echo("ERROR: $static_clearance not defined in add_screw_hole");
      UNDEFINED_DYNAMIC_VARIABLE_ERROR();
    }
    if (!$epsilon) {
      echo("ERROR: $epsilon not defined in add_screw_hole");
      UNDEFINED_DYNAMIC_VARIABLE_ERROR();
    }

    // Depth of hole for screw head.
    head_hole_height = screw("screw_head_height") + screw("screw_sunk") + $static_clearance;

    // depth of hole for fixing in place.
    fitting_hex_thickness = screw("nut_thickness")/2 + $static_clearance;

    post_height = head_hole_height + $thickness + fitting_hex_thickness;
    post_radius = screw_hole_post_radius(screw_type);

    difference() {
      union() {
        level_import(level) {
          children();
        }
        translate(upsidedown_offset(screw_center_offset)) {
          rotate(upsidedown_angle(-90+nut_opening_rotation)) {
            // post
            cylinder(h=post_height, r=post_radius);
          }
        }
      }
      translate(upsidedown_offset(screw_center_offset)) {
        rotate(upsidedown_angle(-90+nut_opening_rotation)) {
          translate([0,0,-$epsilon]) {
            // head hole
            cylinder(h=head_hole_height+$epsilon,
                     r=screw("screw_head_diameter")/2+$static_clearance/cos(180/$fn));
            // screw hole
            cylinder(h=post_height+$epsilon*2, r=(screw("screw_thread_diameter")/2+$dynamic_clearance)/cos(180/$fn));
          }
          // fitting hex indentation
          translate([0,0,post_height-fitting_hex_thickness]) {
            rotate(360/12) {
              cylinder(h=fitting_hex_thickness+$epsilon, r=screw("nut_diameter")/2+$static_clearance*2/sqrt(3),$fn=6);
            }
          }
        }
      }
    }
  }
}


// nut_opening_rotation 0 is to the right when viewed above.  positive values rotate toward positive y.
// post_center_offset should be relative to bottom-left corner of the box top when upside-down.
module add_screw_post(post_center_offset, screw_type, nut_opening_rotation, level) {
  function screw(p) = get_screw_param(screw_type, p);
  level_preamble(level) {
    children();
    if (!$thickness) {
      echo("ERROR: $thickness not defined in add_screw_post");
      UNDEFINED_DYNAMIC_VARIABLE_ERROR();
    }
    if (!$dynamic_clearance) {
      echo("ERROR: $static_clearance not defined in add_screw_post");
      UNDEFINED_DYNAMIC_VARIABLE_ERROR();
    }
    if (!$static_clearance) {
      echo("ERROR: $dynamic_clearance not defined in add_screw_post");
      UNDEFINED_DYNAMIC_VARIABLE_ERROR();
    }
    if (!$epsilon) {
      echo("ERROR: $epsilon not defined in add_screw_post");
      UNDEFINED_DYNAMIC_VARIABLE_ERROR();
    }
    if (!$box_size) {
      echo("ERROR: $box_size not defined in add_screw_post");
      UNDEFINED_DYNAMIC_VARIABLE_ERROR();
    }

    // box outer height - post height of screw hole - offset if the post is floating
    post_height = $box_size[2] -
      (screw("screw_head_height") + screw("screw_sunk") + 2*$static_clearance + $thickness + screw("nut_thickness")/2) // post_height from above
      - $static_clearance // so that the posts meet with a small gap
      - post_center_offset[2]; // in case the post is floating
    nut_radius_with_dynamic_clearance = screw("nut_diameter")/2 + $dynamic_clearance*2/sqrt(3);
    post_radius = nut_radius_with_dynamic_clearance + $thickness;

    fitting_hex_height = post_height + screw("nut_thickness")/2; // from above without the clearance

    nut_opening_width = screw("nut_width")+2*$dynamic_clearance;

    nut_pocket_total = post_height-2*$thickness-2*$static_clearance;

    nut_opening_height0 = screw("nut_thickness") + 2*$dynamic_clearance;
    if (nut_pocket_total - nut_opening_height0 < 0) {
      echo("ERROR: Box not tall enough for nut opening.");
      BOX_NOT_TALL_ENOUGH_FOR_NUT_OPENING();
    }

    nut_pit_height = range(0, screw("nut_thickness")/2,
                           nut_pocket_total - nut_opening_height0);

    nut_opening_height1 = range(nut_opening_height0, screw("nut_width") + 2*$dynamic_clearance,
                                nut_pocket_total - nut_pit_height);

    nut_dome_height = range(0, screw("nut_thickness")/2,
                            nut_pocket_total - nut_opening_height1 - nut_pit_height);

    nut_opening_height = post_height-2*$thickness-2*$static_clearance - nut_pit_height - nut_dome_height;

    nut_pocket_height = 2*$static_clearance + nut_pit_height + nut_dome_height + nut_opening_height;
    level_import(level) {
      children();
    }
    translate(post_center_offset) {
      difference() {
        intersection() { //intersection so that the post isn't sticking out of the box top.
          translate(-post_center_offset) {
            hull() {
              level_import(level) {
                children();
              }
            }
          }
          rotate(-90+nut_opening_rotation) {
            union() {
              // post
              cylinder(h=post_height, r=post_radius);
              // fixing hex stub
              rotate(360/12) {
                cylinder(h=fitting_hex_height,
                         r=screw("nut_diameter")/2,
                         $fn=6);
              }
            }
          }
        }
        rotate(-90+nut_opening_rotation) {
          difference() { // difference so that the holes don't go through the box.
            union() {
              // screw hole
              translate([0,0,$epsilon]) { // so that it sticks out of the top and not the bottom.
                cylinder(h=fitting_hex_height,
                         r=(screw("screw_thread_diameter")/2+$dynamic_clearance)/cos(180/$fn));
              }
              // nut pocket
              translate([0,0,post_height-$thickness-nut_pocket_height]) {
                rotate(360/12) {
                  cylinder(h=nut_pocket_height,
                           r=nut_radius_with_dynamic_clearance,
                           $fn=6);
                }
              }
              // nut insertion opening
              translate([0,0,post_height-$thickness-nut_pocket_height+$static_clearance+nut_pit_height]) {
                //rotate(360/12)
                translate([-nut_opening_width/2,0,0]) {
                  cube([nut_opening_width,
                        post_radius+$epsilon,
                        nut_opening_height]);
                }
              }
            }
            translate(-post_center_offset) {
              level_import(level) {
                children();
              }
            }
          }
        }
      }
    }
  }
}
