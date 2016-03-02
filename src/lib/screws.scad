// M3 screws

m3_screw =
  [["screw_thread_diameter", 3],
   ["screw_head_diameter", 3*2],
   ["screw_head_height", 0.7*3],
   ["nut_diameter", 6.29], // measured 6.29, spec 2*m3; //6.4?
   ["nut_width", 6.29*sqrt(3)/2], // measured 5.44
   ["nut_thickness", 0.9*3], // forgot to measure
   ["screw_sunk", 0.7*3/2]];

screws = [["m3", m3_screw]];

function get_value(map, key) =
map[search([key], map, 0, 0)[0][0]][1] ?
map[search([key], map, 0, 0)[0][0]][1] : GET_VALUE_FAILURE;

function recursive_get_value_helper(map, keys, key_index) =
  len(keys) == key_index ? map :
  recursive_get_value_helper(get_value(map, keys[key_index]), keys, key_index+1);

function recursive_get_value(map, keys) =
  recursive_get_value_helper(map, keys, 0);

function get_screw_param(screw_type, param) =
  recursive_get_value(screws, [screw_type, param]);
