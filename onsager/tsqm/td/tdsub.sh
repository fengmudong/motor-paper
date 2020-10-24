#!/bin/bash
echo "Job name?"
read name

#echo "how many worker nodes do you want?"
#read Nworker

echo "work queue port number?"
read port

echo "xyz file for inital coords?"
read xyzfile

cd /projects/gilson-onsager/mufeng/tsqm/td/
if [ -e $name.in ]
then
    cat > $name.pbs << 'EOF'

#!/bin/bash
#PBS -l walltime=500:00:00,nodes=1:ppn=16 -q home
#PBS -j oe
#PBS -N JOBNAME

### Running on the master node of work_queue

# note that `conda activate ...` doesn't seem to work inside a pbs script
source ~/.condainit
export PYTHONUNBUFFERED=1
export PYTHONIOENCODING=UTF-8

cd /projects/gilson-onsager/mufeng/tsqm/td
mkdir -p JOBNAME
cd JOBNAME
cp ../JOBNAME.in JOBNAME.in
cp ../dihedrals2d.txt dihedrals2d.txt
cp ../XYZ XYZ

## Submit NWORKER times workernode.pbs to request NWORKER nodes
#i=1 
#while [ "$i" -le NWORKER ]; do
#    qsub -v MASTER=$(awk '{print $1; exit}' $PBS_NODEFILE),MASTERP=PORT /projects/gilson-onsager/mufeng/tsqm/td/workernode.pbs
#    ((i+=1))
#done

# Note that you should write set_num_threads(nthread) in the psi4 input file to allow multi-core speed up.
torsiondrive-launch JOBNAME.in dihedrals2d.txt --init_coords XYZ -g 5 -e psi4 --wq_port PORT -v 1>scan.log 2>worker.log &
sleep 60

# Kill existing workers that might have been left over by previous jobs.
if [ $(ps xjf | grep work_queue_worker | grep -v grep | awk '{print $2}' | wc -l) -gt 0 ] ; then
    ps xjf | grep work_queue_worker | grep -v grep | awk '{print $2}' | xargs kill
fi

cd ..
# Create a folder to store worker log files.
mkdir -p workers
cd workers

# At most, 16 workers can be submitted cuz TSCC node has 16 cores. Accordingly --cores should be changed.
i=1 
while [ "$i" -le 4 ]; do
   work_queue_worker --cores 4 -t 86400s localhost PORT &> $PBS_JOBID.$i.log &
   ((i+=1))
done
wait

EOF
    sed -i s/JOBNAME/$name/g $name.pbs
    sed -i s/NWORKER/$Nworker/g $name.pbs
    sed -i s/PORT/$port/g $name.pbs
    sed -i s/XYZ/$xyzfile/g $name.pbs
    qsub $name.pbs
    #rm $name.pbs

else
    echo "Missing .in input file!"
fi





