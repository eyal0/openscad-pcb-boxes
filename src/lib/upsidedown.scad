// v is a row vector.  Output is the offset needed if the box is upsidedown
function upsidedown_offset(v) = [v[0], $box_size[1]-v[1], v[2]];
function upsidedown_angle(angle) = -angle;
module upsidedown_polygon() {
  mirror([0,1,0]) {
    children();
  }
}
