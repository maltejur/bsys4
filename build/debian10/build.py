#!/usr/bin/env python3

import os
import sys
import optparse
import time
import glob


start_time = time.time()


parser = optparse.OptionParser()
parser.add_option('-n', '--no-execute', dest='no_execute', default=False, action="store_true")
options, args = parser.parse_args()

#
# general functions
#

def script_exit(statuscode):
    if (time.time() - start_time) > 60:
        # print elapsed time
        elapsed = time.strftime("%H:%M:%S", time.gmtime(time.time() - start_time))
        print(f"\n\aElapsed time: {elapsed}")

    sys.exit(statuscode)

def exec(cmd, exit_on_fail = True, do_print = True):
    if cmd != '':
        if do_print:
            print(cmd)
        if not options.no_execute:
            retval = os.system(cmd)
            if retval != 0 and exit_on_fail:
                print("fatal error: command '{}' failed".format(cmd))
                script_exit(1)
            return retval
        return None

def patch(patchfile):
    cmd = "patch -p1 -i {}".format(patchfile)
    print("\n*** -> {}".format(cmd))
    if not options.no_execute:
        retval = os.system(cmd)
        if retval != 0:
            print("fatal error: patch '{}' failed".format(patchfile))
            script_exit(1)

def enter_srcdir(_dir = None):
    if _dir == None:
        dir = "librewolf-{}".format(version)
    else:
        dir = _dir
    print("cd {}".format(dir))
    if not options.no_execute:
        try:
            os.chdir(dir)
        except:
            print("fatal error: can't change to '{}' folder.".format(dir))
            script_exit(1)

def leave_srcdir():
    print("cd ..")
    if not options.no_execute:
        os.chdir("..")


#
# The actual script
#

#
# post_build stage:
#


def get_objdir():
    pattern = "obj-*"
    retval = glob.glob(pattern)
    if options.no_execute:
        return "obj-XXX"
    if len(retval) != 1:
        print("fatal error: in execute_lw_post_build(): cannot glob build output folder '{}'".format(pattern))
        script_exit(1)
    return retval[0]


def post_build(is_macos=False):
    print('[debug] --- post_build stage ---------------------------------------')
    dirname = get_objdir()

    distfolder = "dist/bin"
    if is_macos:
        distfolder = 'dist/LibreWolf.app/Contents/Resources'

    if not options.no_execute:
        os.makedirs("{}/{}/defaults/pref".format(dirname,distfolder), exist_ok=True)
        os.makedirs("{}/{}/distribution".format(dirname,distfolder), exist_ok=True)

    exec('git clone https://gitlab.com/librewolf-community/settings.git')
    exec("cp -v settings/defaults/pref/local-settings.js {}/{}/defaults/pref/".format(dirname,distfolder))
    exec("cp -v settings/distribution/policies.json {}/{}/distribution/".format(dirname,distfolder))
    exec("cp -v settings/librewolf.cfg {}/{}/".format(dirname,distfolder))
    exec('rm -rf settings')

    exec('git clone https://gitlab.com/librewolf-community/windows.git')
    patch('windows/patches/package-manifest.patch')
    exec('rm -rf settings')



# my build folder will be:
script = os.path.realpath(__file__)
build_folder = os.path.dirname(script)
enter_srcdir(build_folder)

# perform the build
exec('./mach build')
post_build()
exec('./mach package')
