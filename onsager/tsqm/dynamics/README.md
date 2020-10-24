# Software MNDO is needed for reproducing calculations in this directory, but not needed for calculations of other directories. `mdtools.doc` included in MNDO distribution is a very helpful tutorial and my calculations largely follow this tutorial. 

# Index of files in this directory

`dynvar_hop.in`
the MNDO dynamics input file specifying surface-hopping parameters.

`Ssampling` `Osampling` `Nsampling`
Directories containing MNDO ground state sampling and surface-hopping MD files. Some MNDO commands used are: `mdsample.py --vel --sample-size=100`
`python2 /home/mufeng/mndo99/mdtools/mdfilter.py --vel --target-state=2 --mapthr=0.7 -W -d`

`postanalysis.sh` 
My wrapper of MNDO's scripts after trajectories finish. Contains some sanity checks.

`vmdanalysis.sh`
script to calculate time series of varies coordinates from surface-hopping trajectory data.