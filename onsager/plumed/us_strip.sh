#!/bin/bash

cd /home/winter/onsager/plumed
rm firststep*.traj
rm secondstep*.traj
#for i in `seq -1.2 0.1 1.6`
#for i in `seq -1.2 0.1 2.9`
for i in `seq -1.9 0.1 2.1`
do
	cat > firststep$i.traj << EOF
parm ../amber/Snolog1.prmtop
trajin repSnolog_$i/repSnolog_$i.nc
strip :DCM outprefix strip
rms first @16,@15,@14
trajout repSnolog_$i/strip.repSnolog_$i.mdcrd
run
quit

EOF
	cat > secondstep$i.traj << EOF
parm ../amber/strip.Snolog1.prmtop
trajin repSnolog_$i/strip.repSnolog_$i.mdcrd
dihedral distant @18 @15 @14 @10 out repSnolog_$i/dih_$i.dat
run
quit

EOF
done

parallel cpptraj -i ::: firststep*.traj
#parallel cpptraj -i ::: secondstep*.traj

rm firststep*.traj
rm secondstep*.traj




