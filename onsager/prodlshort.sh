#!/bin/bash

#for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
#for i in 1 2 3 4 5 6 7 8 9 10 11 12 13
for i in 1 2 3 4
do
	cat > temp${i}.pbs << EOF
#!/bin/bash
#PBS -l walltime=300:00:00,nodes=1:ppn=2:gpu -q home-gibbs -A mgilson-group
#PBS -j oe
#PBS -N Nnolog${i}_prod

source /projects/gilson-onsager/mufeng/ambersource.sh
rm -rf /oasis/tscc/scratch/mufeng/Nnolog${i}
mkdir /oasis/tscc/scratch/mufeng/Nnolog${i}
cd /oasis/tscc/scratch/mufeng/Nnolog${i}
cp /projects/gilson-onsager/mufeng/temp.in temp.in
cp /projects/gilson-onsager/mufeng/amber/Nnolog${i}.prmtop Nnolog${i}.prmtop
cp /projects/gilson-onsager/mufeng/amber/Nnolog${i}_eq.rst Nnolog${i}_eq.rst

pmemd.cuda_SPFP_orig -O -i temp.in -p Nnolog${i}.prmtop -c Nnolog${i}_eq.rst -r Nnolog${i}_prod.rst -o Nnolog${i}_prod.out -inf Nnolog${i}_prod.mdinfo -x Nnolog${i}_prod.nc

rm -f *.in
rm -f *.prmtop
rm -f Nnolog${i}_eq.rst
cp Nnolog${i}* /projects/gilson-onsager/mufeng/amber

EOF
	qsub temp${i}.pbs
	rm temp${i}.pbs
done

