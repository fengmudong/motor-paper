atom numbering in PLUMED:
because 600 DCM appear before 1 MOL in the prmtop, the first DCM atom has index 1 while the first MOL atom has index 3001.

`prod.in`
AMBER input file for umbrella sampling.

`us_Snolog.sh`
Script used for umbrella sampling.

`us_strip.sh`
process US trajs - strip the solvent for visualization, using cpptraj to calculate dihedrals (a sanity check is to compare cpptraj result and plumed result of the same dihedral)

`us_dih.ipynb`
visualize time series of dihedral in US trajs

`wham.cmd`
stores the command to use for calling WHAM

