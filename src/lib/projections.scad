include <globals.scad>;
include <screws.scad>;
include <box_screw_post.scad>;

pcb_width = 72.7;
pcb_depth = 59.9;
$pcb_thickness = 1.1;
$pcb_top_clearance = 12.3-$pcb_thickness;
pcb_bottom_clearance = 4;
screw_type = "m3";

$box_size = [pcb_width+4*$thickness,
             pcb_depth+6*$thickness+4*screw_posts_max_radius(screw_type),
             $pcb_top_clearance+$pcb_thickness+pcb_bottom_clearance+2*$thickness];
$thickness = 2;

module all_rotations(space) {
  projection(cut=true)
  translate([0,0,-$thickness/2]) {
    children();
    #translate([$box_size[0]+space,0,$box_size[0]]) rotate([0,90,0]) children();
    translate([$box_size[0]*2+$box_size[2]+2*space,0,$box_size[2]]) rotate([0,180,0]) children();
    translate([$box_size[0]*2+2*$box_size[2]+3*space,0,0]) rotate([0,270,0]) children();
    translate([0,-space,0]) rotate([90,0,0]) children();
    translate([0,$box_size[1]+space,$box_size[1]]) rotate([-90,0,0]) children();
  }
}

//projections("Q:\\Users\\Eyal\\Documents\\OpenSCAD\\openscad-pcb-boxes\\output\\box_button_demo\\box_button_demo_demo.stl");
module importer() {
  import("Q:\\Users\\Eyal\\Documents\\OpenSCAD\\openscad-pcb-boxes\\output\\esr_tester\\esr_tester_demo.stl");
}
all_rotations(5) {
  importer();//("Q:\\Users\\Eyal\\Documents\\OpenSCAD\\openscad-pcb-boxes\\output\\box_button_demo\\box_button_demo_demo.stl");
}
