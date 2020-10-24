# Index of files in this directory

`fbprep.sh`
preparation script that creates a template Forcebalance directory for each new molecule under study. There may be some OpenBabel warnings which can be ignored

`fbS_nolog`
motor S forcefield optimization. Only dihedral terms optimized. Produces result in paper figure

`fbN_nolog`
motor N forcefield optimization. Only dihedral terms optimized. Produces result in paper figure

`fbO_nolog`
motor O forcefield optimization. Only dihedral terms optimized. Produces result in paper figure

`fbO_ccbox2`
motor O forcefield optimization. All parameters allowed to change with box restraints. The resulting parameters gave good THI rate constant but have too soft bonds and angles

`fbO_allboxbuckpaper`
Produces figure for the Buckingham PES in paper.

`fbScc_nolog`
motor S forcefield optimization using cc instead of ce atomtype. Only dihedral terms optimized.