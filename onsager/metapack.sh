#!/bin/bash

cd /home/winter/onsager/

## First, prepare the necessary .com files from imcomplete .com files that contain .xyz coordinates, which I created by cmds like `tail -q -n 50 run0017/traj.out >> ../../../../Smeta1.com`
## This for loop should be commented out when these .com files were already created earlier and you only want to test a different set of forcefield paramters!
# for i in 1 2 3 4 5 6 7 8 9 10 11 12 13
# do
#     cat > temp.com << EOF
# %mem=100GB
# %nprocshared=16
# %chk=Sm.chk
# #p opt=calcfc freq rb3lyp/6-31g(d,p) geom=connectivity scf=(maxcycle=500)

# DFT opt

# 0 1
# EOF
#     tail -n +3 Smeta$i.com >> temp.com
#     mv temp.com Smeta$i.com
# done

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13
do
    # Then, prepare the necessary .mol2 and .pdb files from .com
    antechamber -i Smeta$i.com -fi gcrt -o Smeta$i.mol2 -fo mol2 -at gaff2 -c bcc
    sed -i s/cc/ce/g Smeta$i.mol2
    antechamber -i Smeta$i.mol2 -fi mol2 -o Smeta$i.pdb -fo pdb

# Then, run packmol
    cat > temp.packmol << EOF
tolerance 2.0
filetype pdb
output pack.pdb

structure DCMb3opted.pdb 
  number 600 
  inside box 0. 0. 0. 40. 40. 40. 
end structure

structure Smeta$i.pdb
  number 1
  inside box 0. 0. 0. 40. 40. 40. 
end structure
EOF

    packmol < temp.packmol
    
# Then, run tleap
    cat > temp.leap << EOF
source leaprc.gaff2
loadamberparams DCMb3opted.frcmod
DCM = loadmol2 DCMb3opted.mol2
loadamberparams fb/fbS_nologmodbondmin/result/input/fbS.frcmod
MOL = loadmol2 Smeta$i.mol2
PACK = loadpdb pack.pdb
setbox PACK centers
saveamberparm PACK amber/Snologmodbondmin${i}.prmtop amber/Snologmodbondmin${i}.inpcrd
quit
EOF
        tleap -f temp.leap
done
