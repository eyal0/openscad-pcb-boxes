// All modules that operate in levels must be wrapped with this.
// children(0) is just pass through.  children(1) is doing the work.
// If level matches $level or either are -1, do the second, either do the first.
module level_preamble(level) {
  if ($level == level || $level == -1 || level == -1) {
    children([1:$children-1]);
  } else {
    children(0);
  }
}

module level_import(level) {
  if ($level == -1 || level == -1) {
    children();
  } else {
    if ($import_filename) {
      import($import_filename);
    }
  } 
}
