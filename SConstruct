#!python
openscad_binary = 'openscad-nightly'
#openscad_png = Builder(
#        action = 'Xvfb :5 -screen 0 800x600x24 && DISPLAY=:5 ' + openscad_binary + ' -o $TARGET $SOURCE')
#action = openscad_binary + ' -o $TARGET $SOURCE')

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

render_parts = ['demo', 'button', 'top', 'bottom']
view_parts = render_parts

for part in render_parts:
  env.Openscad(target='esr_tester_' + part + '.stl', source=['esr_tester_box.scad'])
for part in view_parts:
  env.Openscad(target='esr_tester_' + part + '.png', source=['esr_tester_box.scad'])
