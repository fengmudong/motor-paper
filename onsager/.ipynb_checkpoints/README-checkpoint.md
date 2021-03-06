`metapack.sh` `metapack_N.sh`
script to prepare the initial motor structures for classical MD, and solvating the motor into a solvent box.

`DCMb3opted.com`		
DFT optimized structure of DCM

`DCMb3opted.pdb`  		
pdb generated by `antechamber -i DCMb3opted.com -fi gcrt -o temp.pdb -fo pdb` and manually change res name from MOL to DCM

`DCMb3opted.mol2`		
generated by `antechamber -i DCMb3opted.pdb -fi pdb -o DCMb3opted.mol2 -fo mol2 -at gaff2 -c bcc`. It might be needed to manually alter the partial charges a little bit so they sum to zero.

`DCMb3opted.frcmod` 		
generated by `parmchk2 -a Y -i DCMb3opted.mol2 -f mol2 -o DCMb3opted.frcmod -s 2`
Note: this frcmod contains atomtype c3, which is also present in my motor forcefield parameters. By loading solvent frcmod before loading solute frcmod in tleap, solute frcmod will have higher priority, overwriting c3 LJ parameter of solvent frcmod.

`min.sh` `resheat.sh` `reseq.sh` `prodl.sh` `prodlshort.sh` `min.in` `resheat.in` `reseq.in` `prodl.in` `prodlshort.in`
Scripts for submitting each stage of plain MD simulations, and corresponding AMBER MD input files.

`amber/rev.traj`
cpptraj script to truncate the stable form portion out of plain MD trajectories for MSM analysis. 

`pucker.sh`  
script to calculate time series of various coordinates such as ring puckers using cpptraj. Also strips out solvent for faster processing.

`Pucker.ipynb`  
visualizing time series produced by scripts such as `pucker.sh`.

`Smeta1~13.com` `Nmeta1~6.com` `Ometa1~4.com` 
the final structures of surface hopping trajectories that are used as classical MD initial structures. Generated by cmds like 
`tail -q -n 50 MNDO_DIR/run0017/traj.out >> Ometa1.com` and file format conversion in `metapack.sh`

`comparedensity.ipynb` 
notebook to reveal volume increase from meta to stable form 69189 to 69194 A^3, which is close to the Klok09 QM result.

