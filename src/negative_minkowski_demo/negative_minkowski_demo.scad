use <../lib/negative_minkowski.scad>;

$epsilon = 0.01;
$fn=60;
negative_minkowski() {
  difference() {
    cylinder(r=10,h=20);
    translate([-2.5,-2.5,-0.01]) cube([5,5,5]);
  }
  cylinder(r=0.15, h=$epsilon);
}
