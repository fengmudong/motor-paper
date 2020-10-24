#!/bin/bash

#for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
#for i in 1 2 3 4 5 6 7 8 9 10 11 12 13
for i in 1 2 3 4
do
	cat > temp${i}.pbs << EOF
#!/bin/bash
#PBS -l walltime=7:00:00,nodes=1:ppn=1 -q condo
#PBS -j oe
#PBS -N eq

source /projects/gilson-onsager/mufeng/ambersource.sh
cd /projects/gilson-onsager/mufeng/amber
pmemd_orig -O -i ../reseq.in -p Nnolog${i}.prmtop -c Nnolog${i}_heat.rst -r Nnolog${i}_eq.rst -o Nnolog${i}_eq.out -inf Nnolog${i}_eq.mdinfo -x Nnolog${i}_eq.nc -ref Nnolog${i}_min.rst

EOF
	qsub temp${i}.pbs
done

