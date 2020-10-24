#!/bin/bash
echo "Job name?"
read name

echo "Number of atoms? (For 56 motors, O S - 48; N - 64; OOMe SOMe - 52; NOMe - 68)"
read natom

cd /home/winter/onsager/tsqm/dynamics
if [ -d $name ]
then
    cd $name
    cd hop
    for dir in run0??? 
    do
        # Use the following .py script to add a dummy atom to molden trajectory. The dummy atom provides better definition of central torsion. Avoid for-loop, or the .py runs unaccepatably slow!
        cat > dummy.py << EOF
    
#!/usr/bin/env python
import numpy as np
import pandas as pd     

natom = $natom

#Skip useless coordinates in the ATOM section
df = pd.read_csv('/home/winter/onsager/tsqm/dynamics/NAME/hop/RUN/traj.out', header=None, delim_whitespace=True, skiprows=natom+5, skip_blank_lines=False, names=['atom','x','y', 'z']) 

nframe = df.shape[0] // (natom+2) + 1

# Vectorized calculation on coordinates of the dummy atom, which should be perpendicular to 1-14-13 plane
r1 = df.iloc[0:0+(natom+2)*nframe:(natom+2),1:].values.astype(float)
r13 = df.iloc[12:12+(natom+2)*nframe:(natom+2),1:].values.astype(float)
r14 = df.iloc[13:13+(natom+2)*nframe:(natom+2),1:].values.astype(float)
nvec = np.cross((r1-r14),(r13-r14)) 
nvec = nvec / np.linalg.norm(nvec,axis=1,keepdims=True)
rdummy = r14 + nvec
# Replace the last atom by dummy atom.
df.iloc[(natom-1):(natom-1)+(natom+2)*nframe:(natom+2),0] = 'XX'
df.iloc[(natom-1):(natom-1)+(natom+2)*nframe:(natom+2),1:] = rdummy
    
df.to_csv('/home/winter/onsager/tsqm/dynamics/NAME/hop/RUN/pd.molden', header=None, index=None, sep='\t')    
EOF

        sed -i s/RUN/$dir/g dummy.py
        sed -i s/NAME/$name/g dummy.py
        python3 dummy.py
        # Adding file header skipped in pandas processing.
        head -1 $dir/traj.out > $dir/dummy.molden
        head -$((natom+5)) $dir/traj.out | tail -3 >> $dir/dummy.molden
        cat $dir/pd.molden >> $dir/dummy.molden
        rm $dir/pd.molden
        
        cat > $dir'.tcl' << EOF
mol new RUN/dummy.molden type molden first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
mol rename top traj.out
label add Dihedrals 0/12 0/13 0/14 0/15
label add Dihedrals 0/13 0/0 0/12 0/14
label add Dihedrals 0/26 0/24 0/15 0/14
label add Dihedrals 0/6 0/0 0/13 0/12
label add Dihedrals 0/15 0/14 0/13 0/$((natom-1))
label graph Dihedrals 0 RUN_dih.dat
label graph Dihedrals 1 RUN_pyr.dat
label graph Dihedrals 2 RUN_rot.dat
label graph Dihedrals 3 RUN_sta.dat
label graph Dihedrals 4 RUN_dum.dat
quit
EOF

        sed -i s/RUN/$dir/g $dir'.tcl'
        vmd -dispdev text -e $dir'.tcl'
        paste -d ' ' $dir'_dih.dat' $dir'_pyr.dat' $dir'_rot.dat' $dir'_sta.dat' $dir'_dum.dat' | awk '{print $2, $4, $6, $8, $10}' > $dir'_dihedrals.dat'
        grep "state: 2" $dir/hopping.out | tail -1 | awk '{print $2}' > $dir'.hopframe'
    done
    rm *.tcl *_dih.dat *_pyr.dat *_rot.dat *_sta.dat *_dum.dat
else
    echo "Missing .inp file!"
fi
