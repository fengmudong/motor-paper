# Notebooks about classical MD

`Pucker.ipynb`  
visualizing time series produced by script `pucker.sh`.

`volumechange.ipynb` 
notebook to reveal volume increase from metastable to stable form 69189 to 69194 A^3, which is close to the Klok09 QM result.

`pre-wham.ipynb`
Prepares PlUMED simulation data for WHAM analysis.

`wham.ipynb`
Visualiztion WHAM analysis of umbrella sampling. Plots PMF and calculates free energy differences.

`2d-pcoord-separation.ipynb`
Shows how the 2D progress coordinates used in WESTPA calulations separate different states. Gives figure in the paper.

`plotWESTPA.ipynb`
notebook to compute and plot THI rate constant from WESTPA simulation data

`motorS.ipynb` `motorN-noboc.ipynb`
Notebooks for constructing MSM for motor S and motor N, respectively. Give figures in the paper.

# Notebooks about surface-hopping MD
`PlotHopping.ipynb`   
visualize `vmdanalysis.sh` result

`mndo2psi4.ipynb`
notebook to parse the final structures of MNDO trajectories to Psi4 input file

# Notebooks about forcefield optimizations
`torsiondrive-motorpaperfig.ipynb`
notebook to plot QM and MM energy surfaces. Gives figures in the paper.

`parmed_amber2gmx.ipynb`
instructions and code to convert Amber ForceBalance directory to Gromacs ForceBalance directory.

`fb2gmx.ipynb`
instructions and code to prepare Gromacs simulation after ForceBalance optimizations

# Notebook for analytic calculation in the paper
`analytic-motor-SS.ipynb`
Analytic calculation and plotting of steady state variables, such as rotation rate, from the kinetic model