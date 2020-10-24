`tdsub.sh` 
Example script for submiting torsiondrive jobs on a cluster. `addworkers.sh` 

`addworkers.sh`  
Script to add more workers for a torsiondrive master job

`mndo2psi4.ipynb`
parse the final structures of MNDO trajectories to Psi4 input file for optimization

`O/` `O_dihrot/` `S/` `S_dihrot/` `N/` `N_dihrot/`
Directories containing necessary inputs to TorsionDrive. In each directory, there is .in file whose coordinates don't matter but contain Psi4 input information such as basis set; a .txt file specifying the scanned coordinates and their ranges; a .xyz file providing the initial structures for the scan.
