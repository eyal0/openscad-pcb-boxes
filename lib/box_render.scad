//$part is one of top, bottom, button, demo.
$part = "demo";

module render_parts() {
  if ($part == "top") {
    print_box_top() {
      children(0);
    }
  }
  if ($part == "bottom") {
    print_box_bottom() {
      children(1);
    }
  }
  if ($part == "button") {
    print_button() {
      children(2);
    }
  }
  if ($part == "demo") {
    demo_box_top() {
      children(0);
    }
    demo_box_bottom() {
      children(1);
    }
    demo_button(pcb_offset+[pcb_width, pcb_depth, 0]-[13.2 - 11.9/2, 13.6-11.9/2,0], 8.4-$pcb_thickness) {
      children(2);
    }
  }
}
