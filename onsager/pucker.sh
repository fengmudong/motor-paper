#!/bin/bash
## Call by `bash dihedral.sh meta` if your trajectories are meta1_prod.nc, meta2_prod.nc...

cd /home/winter/onsager/amber
rm firststep*.traj
rm secondstep*.traj
#for i in 1 2 3 4 5 6 7 8 9 10 11 12 13
for i in 1 2 3 4
do
	cat > firststep${i}.traj << EOF
parm $1${i}.prmtop
trajin $1${i}_prod.nc
strip :DCM outprefix strip
rms first @16,@15,@14
trajout strip.$1${i}.mdcrd
trajout strip.$1${i}.nc
run
quit

EOF
	cat > secondstep${i}.traj << EOF
parm strip.$1${i}.prmtop
trajin strip.$1${i}.mdcrd
dihedral distant @18 @15 @14 @10 range360 out temp${i}.dis
pucker stator @7 @6 @1 @14 @13 @8 cremer amplitude out temp${i}.sta
dihedral rotor @27 @15 @16 @25 out temp${i}.rot 

run
quit

EOF
done

parallel cpptraj -i ::: firststep*.traj
parallel cpptraj -i ::: secondstep*.traj

#for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
for i in 1 2 3 4
do
cat temp${i}.dis | awk '{print $2}' > $1$i.dis
cat temp${i}.sta | awk '{print $2 "\t" $3}' > $1$i.sta
cat temp${i}.rot | awk '{print $2}' > $1$i.rot
done




