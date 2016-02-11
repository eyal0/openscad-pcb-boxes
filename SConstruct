#!python
openscad_binary = 'openscad-nightly'

import os

def openscad(target, source, env):
  part = str(target[0]).split("_")[-1].split(".")[0]
  for t in target:
    print(t)
    command = (openscad_binary +
              ' -D \'$part="' + part + '"\'' +
              ' -D \'$fn=' + str(env['fn']) + '\'' +
              ' --viewall --autocenter --render' +
               ' -o ' + str(target[0]) + ' ' + str(source[0]))
    print(command)
    #os.system(command)

def openscad2(target, source):
  if '.' in str(target):
    targets = [str(target)]
  else:
    targets = [str(target) + suffix for suffix in ['.png', '.stl']]
  if '.' in str(source):
    sources = [str(source)]
  else:
    sources = [str(source[0]) + suffix for suffix in ['.scad']]
  print targets
  for t in targets:
    for s in sources:
      env.Openscad(target=t, source=s)

openscad = Builder(
    action = openscad)
#VariantDir('src', 'output')
env = Environment(
    BUILDERS = {'Openscad': openscad})
env["fn"] = ARGUMENTS.get('fn', 10)

Export('env openscad2')
d = 'src'
conscripts = [os.path.join(d,o,"SConscript") for o in os.listdir(d) if os.path.isfile(os.path.join(d,o,"SConscript"))]
SConscript(conscripts)
