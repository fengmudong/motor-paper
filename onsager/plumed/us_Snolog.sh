#!/bin/bash
cd /projects/gilson-onsager/mufeng/plumed/

for i in `seq -1.9 0.1 2.1`;do
    rm -rf Snolog_$i/
    mkdir -p Snolog_$i/
    cd Snolog_$i/
    cat > plumed.dat << EOF
dih: TORSION ATOMS=3043,3015,3014,3029
restraint: RESTRAINT ARG=dih KAPPA=200 AT=$i
ene: ENERGY
PRINT STRIDE=400 ARG=dih,ene FILE=COLVAR_$i
EOF
    
    cat > plumed_$i.pbs << EOF
#!/bin/bash
#PBS -l walltime=200:00:00,nodes=1:ppn=2:gpu -q home-gibbs -A mgilson-group
#PBS -j oe
#PBS -N us_Snolog_$i

rm -rf /oasis/tscc/scratch/mufeng/plumed/Snolog_$i/
mkdir /oasis/tscc/scratch/mufeng/plumed/Snolog_$i/
cd /oasis/tscc/scratch/mufeng/plumed/Snolog_$i/
cp /projects/gilson-onsager/mufeng/plumed/prod.in prod.in
cp /projects/gilson-onsager/mufeng/amber/Snolog1.prmtop Snolog1.prmtop
cp /projects/gilson-onsager/mufeng/amber/Snolog1_eq.rst Snolog1_eq.rst
cp /projects/gilson-onsager/mufeng/plumed/Snolog_$i/plumed.dat plumed.dat

export MODULEPATH=/projects/builder-group/jpg/modulefiles/applications:$MODULEPATH 
export PLUMED_KERNEL=/projects/builder-group/jpg/amber/18/lib/libplumedKernel.so
module load cuda/10.1.243
module load amber
pmemd.cuda -O -i prod.in -p Snolog1.prmtop -c Snolog1_eq.rst -r Snolog_$i.rst -o Snolog_$i.out -inf Snolog_$i.mdinfo -x Snolog_$i.nc

rm -f *.in
rm -f *.prmtop
rm -f Snolog1_eq.rst
cp * /projects/gilson-onsager/mufeng/plumed/Snolog_$i/

EOF
    qsub plumed_$i.pbs
    cd ..
done
