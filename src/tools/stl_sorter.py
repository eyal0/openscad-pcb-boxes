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


new_facets = []
for i in range(len(solid.facets)):
  facet = solid.facets[i]
  f_new = stl.Facet(None, [stl.Vector3d(*(round(coord,3) for coord in vertex))
                       for vertex in facet])
  f_new.recalculate_normal()
  if f_new.normal != None:
    new_facets.append(f_new)
solid.facets = new_facets

count = 0
while count < 10000:
  joined_facet = solid.remove_planar_edge()
  if not joined_facet:
    break
  #sys.stderr.write("joining a facet %d\n" % count)
  count += 1
  while joined_facet.remove_1d_vertex():
    #joined_facet.remove_colinear_vertex()):
    #sys.stderr.write("removing a vertex\n")
    pass

new_f = []
for f in solid.facets:
  new_f += f.split_to_triangles()
solid = stl.Solid(solid.name, new_f)
solid.sort_facets()

if infile_ascii:
  solid.write_ascii(sys.stdout)
else:
  solid.write_binary(sys.stdout)
