import os, sys

version=sys.argv[1]
os.environ['MACH_USE_SYSTEM_PYTHON'] = '1'

os.chdir('/work/librewolf-{}'.format(version))
os.system('./mach build && ./mach package')
