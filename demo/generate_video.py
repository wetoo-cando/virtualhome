#!/usr/local/bin/python

# Generate video for a program. Make sure you have the executable open
import sys
sys.path.append('../simulation/')

from unity_simulator.comm_unity import UnityCommunication

script = ['[Walk] <sofa> (1)', '[Sit] <sofa> (1)'] # Add here your script

print('Starting Unity...')
comm = UnityCommunication()

print('Starting scene...')
comm.reset(4)

print('Generating video...')
comm.render_script(script, output_folder='unity_vol/Output/', image_synthesis='seg_inst', capture_screenshot=True)

print('Generated, find video in simulation/unity_simulator/output/')
