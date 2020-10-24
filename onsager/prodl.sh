#!/bin/bash

# for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13
do
	cat > temp${i}.pbs << EOF
#!/bin/bash
#PBS -l walltime=300:00:00,nodes=1:ppn=2:gpu -q home-gibbs -A mgilson-gibbs
#PBS -j oe
#PBS -N Snolog${i}_prod

source /projects/gilson-onsager/mufeng/ambersource.sh
rm -rf /oasis/tscc/scratch/mufeng/Snolog${i}
mkdir /oasis/tscc/scratch/mufeng/Snolog${i}
cd /oasis/tscc/scratch/mufeng/Snolog${i}
cp /projects/gilson-onsager/mufeng/prodl.in prodl.in
cp /projects/gilson-onsager/mufeng/amber/Snolog${i}.prmtop Snolog${i}.prmtop
cp /projects/gilson-onsager/mufeng/amber/Snolog${i}_eq.rst Snolog${i}_eq.rst

pmemd.cuda_SPFP_orig -O -i prodl.in -p Snolog${i}.prmtop -c Snolog${i}_eq.rst -r Snolog${i}_prod.rst -o Snolog${i}_prod.out -inf Snolog${i}_prod.mdinfo -x Snolog${i}_prod.nc

rm -f *.in
rm -f *.prmtop
rm -f Snolog${i}_eq.rst
cp Snolog${i}* /projects/gilson-onsager/mufeng/amber

EOF
	qsub temp${i}.pbs
	rm temp${i}.pbs
done

