#!/bin/bash
export PATH="/usr/local/cuda-11.4/bin${PATH:+:${PATH}}"
export PYTHONPATH=$PYTHONPATH:"/home/peterse583/qsim"
# export PATH="/usr/local/cuda-11.4/bin${PATH:+:${PATH}}"
# export PYTHONPATH=$PYTHONPATH:"$PWD"
python3 noise4.py