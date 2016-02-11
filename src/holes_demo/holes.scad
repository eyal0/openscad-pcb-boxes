union() {
  $fn = 60;
  for (x = [0:7]) {
    translate([ 0+x*20,0]) cylinder(r=3.2+x/10, h=10);
  }
  translate([-10,-5,0]) cube([8*20, 10, 2]);
}

translate([0,20,0]) union() {
  $fn = 6;
  for (x = [0:7]) {
    translate([ 0+x*20,0,0]) cylinder(r=3.2+x/10, h=10);
  }
  translate([-10,-5,0]) cube([8*20, 10, 2]);
}

translate([0,40,0]) difference() {
  $fn = 60;
  translate([-10,-5,0]) cube([8*20, 10, 4]);
  for (x = [0:7]) {
    translate([ 0+x*20,0,-1]) cylinder(r=(3.5+x/10)/cos(180/$fn), h=10);
  }
}

translate([0,60,0]) difference() {
  $fn = 6;
  translate([-10,-5,0]) cube([8*20, 10, 4]);
  for (x = [0:7]) {
    translate([ 0+x*20,0,-1]) rotate(360/12) cylinder(r=(3.5+x/10)/cos(180/$fn), h=10);
  }
}

