#!/usr/bin/python
import stl
import sys
import fileinput

infile_ascii = True
in_stl = sys.stdin

if infile_ascii:
  solid = stl.read_ascii_file(in_stl)
else:
  solid = stl.read_binary_string(in_stl)

solid.sort_facets()

if infile_ascii:
  solid.write_ascii(sys.stdout)
else:
  solid.write_binary(sys.stdout)
