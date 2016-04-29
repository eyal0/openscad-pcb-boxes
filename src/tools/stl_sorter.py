#!/usr/bin/python3
import argparse
import stl
import sys

parser = argparse.ArgumentParser(description='Sorts an STL file into a canonical order.')
parser.add_argument('infile', type=argparse.FileType('r', encoding='UTF-8'),
                    help='file to sort', metavar='PATH_TO_STL')

args = parser.parse_args()
if args.infile.read(5).lower() == "solid":
  infile_ascii = True
else:
  infile_ascii = False
args.infile.seek(0)
if infile_ascii:
  solid = stl.read_ascii_file(args.infile)
else:
  infile_ascii = False
  solid = stl.read_binary_file(args.infile)

solid.sort_facets()
if infile_ascii:
  solid.write_ascii(sys.stdout)
else:
  solid.write_binary(sys.stdout)
