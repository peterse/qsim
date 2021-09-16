#!/bin/bash
# You must source the installed drivers and libraries as they appear in the
# terraform startup script.
export PATH="/usr/local/cuda-11.4/bin${PATH:+:${PATH}}"
export PYTHONPATH=$PYTHONPATH:"/home/peterse583/qsim"
# export PATH="/usr/local/cuda-11.4/bin${PATH:+:${PATH}}"
# export PYTHONPATH=$PYTHONPATH:"$PWD"
python3 noise4.py