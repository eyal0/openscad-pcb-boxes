include <box_top.scad>
include <box_bottom.scad>

box_outside_dimensions = [100,100,30];
demo_box_top(box_outside_dimensions) {
  box_top(box_outside_dimensions);
}
demo_box_bottom() {
  box_bottom(box_outside_dimensions);
}
