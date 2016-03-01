module xy_offset(xy_offset, step) {
  if (!$epsilon) {
    echo("ERROR: $epsilon not defined in xy_offset");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  if (!$box_size) {
    echo("ERROR: $box_size not defined in xy_offset");
    UNDEFINED_DYNAMIC_VARIABLE_ERROR();
  }
  for(z = [-(step/2) : step : $box_size[2] + step]) {
    translate([0,0,z-step/2-$epsilon]) {
      linear_extrude(step + 2*$epsilon) {
        offset(r=xy_offset) {
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
