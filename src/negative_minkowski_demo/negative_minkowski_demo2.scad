step = 0.1;
$fn = 60;
$epsilon = 0.01;

module XY_offset(first_offset, second_offset) {
  for(z=[0:step:25]) {
    //echo(z);
    translate([0,0,z-step/2-$epsilon]) {
      linear_extrude(step+2*$epsilon) {
        offset(second_offset) {
          offset(first_offset) {
            projection(cut=true) {
              translate([0,0,-z]) {
                children();
              }
            }
          }
        }
      }
    }
  }
}

XY_offset(-0.15,0) {
  difference() {
    cylinder(r=10,h=20);
    translate([-2.5,-2.5,-0.01]) cube([5,5,5]);
  }
}
