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


for i in range(len(solid.facets)):
  facet = solid.facets[i]
  f_new = stl.Facet(None, [stl.Vector3d(*(round(coord,3) for coord in vertex))
                       for vertex in facet])
  f_new.recalculate_normal()
  if f_new.normal == None:
    print(f_new)

  solid.facets[i] = f_new
solid.sort_facets()
#count = 0
#while solid.remove_planar_edge() and count < 30:
#  count += 1
#  sys.stderr.write("facets down to %d\n" % (count))
#new_f = []
#for f in solid.facets:
#  new_f += f.split_to_triangles()
#solid = stl.Solid(solid.name, new_f)
#solid.sort_facets()

#for facet in solid.facets:
#  for vertex in enumerate(facet.vertices):
#    facet[vertex[0]] = (round(vertex[1].x),
#                        round(vertex[1].y),
#                        round(vertex[1].z))
if infile_ascii:
  solid.write_ascii(sys.stdout)
else:
  solid.write_binary(sys.stdout)
