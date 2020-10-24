#!/bin/bash
echo "Job name?"
read name

cd /projects/gilson-onsager/mufeng/tsqm/dynamics
if [ -d $name ]
then
    cd $name/hop
    trajectories_data_generator.sh
    trajectories_check_I_length.tcsh
    ls run*/MD_data/E1.dat > data.ls
    mmean.py
    ls run*/MD_data/E2.dat > data.ls
    mmean.py
    ls run*/MD_data/CC12.dat > data.ls
    mmean.py
    ls run*/MD_data/pop1.dat > data.ls
    mmean.py
    ls run*/MD_data/prob1.dat > data.ls
    mmean.py

else
    echo "Missing .inp file!"
fi
