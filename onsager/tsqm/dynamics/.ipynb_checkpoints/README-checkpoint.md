# Please note that software MNDO is NOT required to reproduce most calculations in my paper, but MNDO is required to reproduce most calculations *in this directory*. Also, `mdtools.doc` included in MNDO distribution is a very helpful tutorial and my calculations largely follow this tutorial. 

# Index of files in this directory

`dynvar_hop.in`
the MNDO dynamics input file specifying surface-hopping parameters.

`Ssampling` `SOMesampling` `Osampling` `OOMesampling` `Nsampling`
Directories containing surface-hopping MD files. Some MNDO commands used are:
`mdsample.py --vel --sample-size=100`
`python2 /home/mufeng/mndo99/mdtools/mdfilter.py --vel --target-state=2 --mapthr=0.7 -W -d`

`postanalysis.sh` 
My wrapper of MNDO's scripts after trajectories finish. Contains some sanity checks.

`vmdanalysis.sh`
script to calculate time series of varies coordinates from surface-hopping trajectory data.

`PlotHopping.ipynb`   
visualize `vmdanalysis.sh` result