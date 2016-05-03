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


#new_facets = []
#for i in range(len(solid.facets)):
#  facet = solid.facets[i]
#  f_new = stl.Facet(None, [stl.Vector3d(*(round(coord,3) for coord in vertex))
#                           for vertex in facet])
#  f_new.recalculate_normal()
##  if f_new.normal != None:
#  new_facets.append(f_new)
#solid.facets = new_facets

#for i in range(len(solid.facets)):
#  solid.facets[i].recalculate_normal()
#
#count = 0
#while count < 10000:
#  joined_facet = solid.remove_planar_edge()
#  if not joined_facet:
#    break
#  sys.stderr.write("joining a facet: %s\n" % joined_facet)
#  count += 1
#  while joined_facet.remove_1d_vertex():
#    #joined_facet.remove_colinear_vertex()):
#    sys.stderr.write("removing a vertex: %s\n" % joined_facet.vertices)
#    if len(joined_facet.vertices) < 3:
#      # Become degenerate, remove.
#      solid.facets.remove(joined_facet)
#      break
#    pass
#
#
#new_f = []
#for f in solid.facets:
#  new_triangles = f.split_to_triangles()
#  for t in new_triangles:
#    t.recalculate_normal()
#    sys.stderr.write("removing: %s\n" % t)
#    if not t.normal:
#      new_triangles.remove(t)
#  new_f += new_triangles
#solid = stl.Solid(solid.name, new_f)
#
solid.sort_facets()

if infile_ascii:
  solid.write_ascii(sys.stdout)
else:
  solid.write_binary(sys.stdout)
