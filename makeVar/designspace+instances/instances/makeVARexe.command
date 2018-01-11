#!/usr/bin/env python
# -*- coding: utf-8 -*-

# makeVAR.py

"""
    Generate variable fonts using fontmake

    You need to have installed:
        fontmake command, https://github.com/googlei18n/fontmake
        – In terminal run: 'pip install fontmake' (you'll need pip if not installed)

        vanilla python library: https://github.com/typesupply/vanilla
        – Drop the vanilla folder in a Terminal window while pressing the command key.
        – type: 'sudo python setup.py install', enter.
        – type your user password (you won't see anything while typing) and press enter.
"""


__version__ = '0.1d'

print
print "makeVAR v%s" % __version__
print __doc__
print


from vanilla.dialogs import getFile
import sys
import os
import os.path
import subprocess


# get designspace file
getDesignspace = getFile('Select the .designspace file:', fileTypes=['designspace'])
if getDesignspace:
    designspacePath = getDesignspace[0]
    currentFolder = os.path.dirname(designspacePath)
    os.chdir(currentFolder)

    # output
    outputFilePath = os.path.join(currentFolder, "mkvar_output.log")
    f = open(outputFilePath, 'w')
    sep = '-' * 57 + '\n'
    report = [sep, 'Generate variable font using\n%s\n\n' % designspacePath, sep]

    # command stuff
    command = 'fontmake -m %s -o variable' % designspacePath
    popen = subprocess.Popen(command, shell=True, stdout=f, stderr=subprocess.PIPE)

    for line in popen.stderr:
        # write output to stdout anyway
        sys.stdout.write(line)
        report.append(line)
    sys.stdout.write('\n')
    popen.wait()

    # write report to output file
    f.write(''.join(report) + '\n')
    f.close()

    # open current folder to check report and fonts if generated
    os.system('open .')
