# Repository of Files to reproduce calculations in paper "Multiscale Molecular Dynamic Modelling of MHz Alkene Molecular Motors" of Mudong Feng et al.

In this repository, each directory often have a .md file explaining the contents of the directory. Github should render these .md files in the browser.

If you encounter any difficulty in reproducing the calculations, feel free to contact me by Github or email fengmudong95@gmail.com. 

## Index of directories
The files were used to run calculations on multiple workstations/clusters, so please understand that some hard-coded paths in my scripts may need modification to suit your computing environment. Specifically, the beginnings of paths, e.g. "/home/winter/onsager/..." or "/projects/gilson-onsager/mufeng/..." always needs modification, while directory names after such beginnings often work without modification. Think of this: "/home/winter/onsager/some_dir", "/projects/gilson-onsager/mufeng/some_dir" and "This_Github_Repository/onsager/some_dir" all mean to the same place.

`notebooks/`
Jupyter notebooks for analysis.

`onsager/`
plain classical MD files

`onsager/tsqm/`
Files associated with non-dynamics QM calculations.

`onsager/tsqm/dynamics`
Files associated with surface-hopping MD.

`onsager/tsqm/td`
TorsionDrive calculations

`onsager/fb/`
Files associated with Forcebalance optimizations

`onsager/plumed/`
Files associated with umbrella sampling

`onsager/westpa/`
Files associated with WESTPA calculations