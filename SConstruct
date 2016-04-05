#!python
AddOption("--fn",
          dest = "fn",
          type = "int",
          nargs = 1,
          action = "store",
          metavar="VAL",
          help=('$fn=VAL when building.  '
                'Higher for greater resolution but longer build times.'))

output_dir = 'output_fn' + str(GetOption('fn'))
SConscript('src/SConscript', variant_dir=output_dir, duplicate=0)
