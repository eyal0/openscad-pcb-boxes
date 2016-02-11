#!python
openscad_binary = 'openscad-nightly'

import os

def openscad(target, source, env):
  part = str(target[0]).split("_")[-1].split(".")[0]
  os.system(openscad_binary +
            ' -D \'$part="' + part + '"\'' +
            ' -D \'$fn=' + str(env['fn']) + '\'' +
            ' --viewall --autocenter --render' +
            ' -o ' + str(target[0]) + ' ' + str(source[0]))

openscad = Builder(
    action = openscad,
    suffix = ".png",
    src_suffix = ".scad")
env = Environment(
    BUILDERS = {'Openscad': openscad})
env["fn"] = ARGUMENTS.get('fn', 10)

Export('env')
SConscript(['esr_tester/SConscript',
            'demo_box/SConscript',
          ])
