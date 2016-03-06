//$part is one of top, bottom, button, demo.
$part = "demo";

module render_parts() {
  if ($part == "top" && $children > 0) {
    print_box_top() {
      children(0);
    }
  }
  if ($part == "bottom" && $children > 1) {
    print_box_bottom() {
      children(1);
    }
  }
  if ($part == "button" && $children > 2) {
    print_button() {
      children(2);
    }
  }
  if ($part == "demo") {
    if($children > 0) {
      demo_box_top() {
        children(0);
      }
    }
    if($children > 1) {
      demo_box_bottom() {
        children(1);
      }
    }
    if($children > 2) {
      demo_button(pcb_offset+[pcb_width, pcb_depth, 0]-[13.2 - 11.9/2, 13.6-11.9/2,0], 8.4-$pcb_thickness) {
        children(2);
      }
    }
  }
}
