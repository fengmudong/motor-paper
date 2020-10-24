#!/bin/bash

cd /home/winter/onsager/
for i in 1 2 3 4 5
do
    cp tsqm/Nm.com Nmeta$i.com
    antechamber -i Nmeta$i.com -fi gcrt -o Nmeta$i.mol2 -fo mol2 -at gaff2 -c bcc
    sed -i s/cc/ce/g Nmeta$i.mol2
    antechamber -i Nmeta$i.mol2 -fi mol2 -o Nmeta$i.pdb -fo pdb

# Then, run packmol
    cat > temp.packmol << EOF
tolerance 2.0
filetype pdb
output pack.pdb

structure DCMb3opted.pdb 
  number 600 
  inside box 0. 0. 0. 40. 40. 40. 
end structure

structure Nmeta$i.pdb
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
loadamberparams fb/fbN_nolog/result/input/fbN.frcmod
MOL = loadmol2 Nmeta$i.mol2
PACK = loadpdb pack.pdb
setbox PACK centers
saveamberparm PACK amber/Nnolog${i}.prmtop amber/Nnolog${i}.inpcrd
quit
EOF
        tleap -f temp.leap
done
