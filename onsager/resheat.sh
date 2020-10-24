#!/bin/bash

#for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13
#for i in 1 2 3 4 5
do
	cat > temp${i}.pbs << EOF
#!/bin/bash
#PBS -l walltime=7:00:00,nodes=1:ppn=1 -q condo
#PBS -j oe
#PBS -N heat

source /projects/gilson-onsager/mufeng/ambersource.sh
cd /projects/gilson-onsager/mufeng/amber
pmemd_orig -O -i ../resheat.in -p Snologmodbondmin${i}.prmtop -c Snologmodbondmin${i}_min.rst -r Snologmodbondmin${i}_heat.rst -o Snologmodbondmin${i}_heat.out -inf Snologmodbondmin${i}_heat.mdinfo -x Snologmodbondmin${i}_heat.nc -ref Snologmodbondmin${i}_min.rst

EOF
	qsub temp${i}.pbs
done

