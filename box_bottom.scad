module box_bottom() {
  if (!$box_size) {
    echo("ERROR: $box_size not defined in box_bottom");
  }
  if (!$thickness) {
    echo("ERROR: $thickness not defined in box_bottom");
  }
  if (!$static_clearance) {
    echo("ERROR: $static_clearance not defined in box_bottom");
  }
  translate ([$static_clearance,$static_clearance,0]) {
    echo($box_size*[[1,0,0],
                    [0,1,0],
                    [0,0,0]]);
    cube($box_size*[[1,0,0],
                    [0,1,0],
                    [0,0,0]] +
         [-2*($thickness+$static_clearance),
          -2*($thickness+$static_clearance),
          $thickness]);
  }
}

module print_box_bottom() {
  if (!$static_clearance) {
    echo("ERROR: $static_clearance not defined in print_box_bottom");
  }
  translate([-$static_clearance, -$static_clearance, 0]) {
    children();
  }
}

module demo_box_bottom() {
  if (!$thickness) {
    echo("ERROR: $thickness not defined in demo_box_bottom");
  }
  translate([$thickness, $thickness, 0]) {
    children();
  }
}

//box_bottom($box_size=[100,50,20], $thickness=3, $static_clearance=0.2);
//demo_box_bottom($box_size=[100,50,20], $thickness=3, $static_clearance=0.2) box_bottom();
//print_box_bottom($box_size=[100,50,20], $thickness=3, $static_clearance=0.2) box_bottom();
