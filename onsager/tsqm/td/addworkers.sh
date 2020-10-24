#!/bin/bash
### This script is used to request additional worker nodes from condo queue to work for your master torsiondrive job at port.

echo "how many worker nodes do you want?"
read Nworker

echo "where is your master (type tscc-1-*)?"
read master

echo "which work queue port number to work for?"
read port


cd /projects/gilson-onsager/mufeng/tsqm/td/
cat > addworker.pbs << EOF

#!/bin/bash
#PBS -l walltime=7:59:00,nodes=1:ppn=16 -q condo
#PBS -j oe
#PBS -N workersfor$port

# source activate tddev

cd /projects/gilson-onsager/mufeng/tsqm/td/workers
ssh -L$port:localhost:$port -o ServerAliveInterval=30 -A -N -f $master

# Kill existing workers that might have been left over by previous jobs.
if [ $(ps xjf | grep work_queue_worker | grep -v grep | awk '{print $2}' | wc -l) -gt 0 ] ; then
    ps xjf | grep work_queue_worker | grep -v grep | awk '{print $2}' | xargs kill
fi

# Run four workers because a 16-core node can be divided to four 4-core workers
i=1 
while [ \$i -le 4 ]; do
    work_queue_worker --cores 4 -t 86400s localhost $port &>/dev/null &
    ((i+=1))
done
wait
EOF

i=1
while [ $i -le $Nworker ]; do
    qsub /projects/gilson-onsager/mufeng/tsqm/td/addworker.pbs
    ((i+=1))
done


