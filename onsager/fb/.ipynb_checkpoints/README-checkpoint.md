# Index of files in this directory

`fbprep.sh`
preparation script that creates a template Forcebalance directory for each new molecule under study. There may be some OpenBabel warnings which can be ignored

`fbN_2scans`
similar result to `fbN_dihrot`

`free-params.txt`
Text file for using `EVAL`. See my coversation with Leeping for details.

FB has problems when using `read` or `readchk` keywords to restart job. A workaround is to copy-paste `*.frcmod` and `free-params.txt` from previous FB job to serve as the new initial forcefield files. If the copied .frcmod file has unwanted negative values, e.g, negative bond force constant, I can simply delete the negative sign - although the initial QM-MM plot is very off-diagonal, a few iterations can bring the points to be very near diagonal, way faster than a fresh start from GAFF2 default parameter values.
In addition, I found that my FB calculations are insensitive to initial parameters values, i.e. starting from previous calculation final values do not make result different from starting from GAFF.

`batch calculate initial FF values.xlsx`
spreadsheet for preparing initial value of FF parameters when `EVAL` is used

`fbO/` `fbS/`
FB working directory created by `fbprep.sh`

`fbOS.frcmod`
created by merging GAFF2 initial .frcmod files for motor O and S. The inital .frcmod file only differ in terms containing oxygen or sulfur.

`fbOS/`
fit `fbOS.frcmod` to torsiondrive data of both O and S motor.

`fbO_2scan/` using two O motor scans to parameterize O motor FF. Successful in preventing too low improper amplitude.

`fbO_allparams/`
trying to see whether by allowing more FF parameters to change, whether I can get similar fitting plot as old 56s result. 
If add O-containing angle terms - not improving

`fbO_at2scans/`
using attenuate keyword to see whether the slope can be closer to one, but found that attenuate can not

`fbO_atallparams2scans`
using attenuate keyword to see whether it can lessen the changes in LJ parameters, but found that it can not.

`fbO_regallparams2scans`
The best I can do to limit how much LJ parameters can change, when `logarithmic_map` is used.
According to my results and discussion with Leeping, using `logarithmic_map` prevents me from letting LJ parameters change a little while letting other parameters to change a lot.

`fbO_nologregallparams2scans`
A good fitting result I got while limiting how much LJ parameters can change, when no `logarithmic_map` is used.

`fbO_eval`
testing `eval` to keep improper from going negative. LJ parameters not allowed to change. The resulting FF is similar in central torsion barrier to `fbO_2scans`

`fbO_evalreg`
basically adding `eval` to `fbO_nologregallparams2scans`.
I also tried smaller regularization penalty in `fbO_evalreg_smaller` and also tried larger priors. They turn out not changing fitting quality. So no need to tweak regularization anymore.
no transition at all after long simulation.

`fbO_evaltorsionreg`
same as `fbO_evalreg` except also forcing torsion terms to be non-negative.
no transition at all after long simulation. Changing to only fitting dihrot PES does not decrease the barrier height, so does using `attenuate`

`fbO_evaltorsionreg_testnoforce`
testing not fitting force but only fitting energy. The resulting FF has smaller central torsion barrier, but other parameters are also vastly different from when fitting force. Also, because `drawforces.vmd` visualization result of `fbO_evaltorsionreg` is already not too good, not fitting force is probably worse.

`fbO_allreg`
optimizing all parameters (bond, angle, torsion, improper, LJ), and ensure (by tuning prior width) all of them being positive value. Also using regularziation. Result has smaller central torsion barrier and closer to QM PES, but the bond and angle force constants are unphysically small

`fbO_allevalreg`
optimizing all parameters (bond, angle, torsion, improper, LJ), and ensure (by using EVAL also on bond force constant and angle force constant) all of them being positive value
The optimization take days - in the first day (~iter100) the bond and angle parameters changes seem small enough to be reasonable, but in the 2nd day they have changed too much. I'm testing with FF in iter100 instead of the final forcefield.
The resulting MD simulation produce no transition at all.

`fbO_allevalreg_testcont` (likely not as good as using box, discarded.)
continue `fbO_allevalreg_test` from iter20. 
The idea is to try a series of optimizations that gradually shifts the location of harmonic restraints in parameter space and bring to final values.
To make it work, I also need to change trust0 to smaller?

`fbO_allevalreg_serial` (likely not as good as using box, discarded.)
slightly change in priors from `fbO_allevalreg_test` and fresh start, to be followed by `fbO_allevalreg_serial2`
The idea is to try a series of optimizations that gradually shifts the location of harmonic restraints in parameter space and bring to final values 

`fbO_allevalreg_box2`
Using flat-bottom restraints implemented as keyword `penalty_type box` and `penalty_power 12.0`
priors tuned for physical relevance. basically the same result as `fbO_allreg_box`

`fbO_allreg_box` `fbO_allreg_box2`
similar to `fbO_allevalreg_box2` but not using EVAL on bond and angle parameters, because flat-bottom restraints of appropriate width should be able to take care of parameter positivity, and that EVAL likely slows down optimization a bit.
`box2` is more aggresive in allowed range of parameter changes. Smaller central torsion barrier at the cost of softer bond and angle parameters
box leads to MD files `Oallregbox*.*`, which gave no transition at all.
box2 leads to MD files `Oallregboxtwo*.*`, which gave successful THI's, but the rate constant is probably overestimated.

`fbO_ccbox1,2,3`
same FB options as `fbO_allreg_box`, but using cc instead of ce atom type.
Very close result to `fbO_allreg_box`.
1 has low prior width, 2 intermediate, 3 high prior width.
1 give no transition in MD, 3 too fast THI in MD, 2 gives order-of-magnitude correct THI rate constant in WESTPA calculation, but the 300K MD trajs look a bit "high temperature"

`fbO_ljbox`
Similar to `fbO_ccbox` but only allow dihedral and LJ parameters to change. The purpose is to serve as control for Gromacs Buckingham optimization in `fbO_ljboxbuck`

`parmed_amber2gmx.ipynb`
instructions and code to convert Amber FB directory to Gromacs FB directory.

`fbO_ljboxgmx`
Same as `fbO_ljbox` except using Gromacs instead. Produced the same intial QM-MM plot as `fbO_ljbox`, validating my port of Amber parameters to Gromacs.

Forcebalance out of the box gives Gromacs error "Setting the total number of threads is only supported with thread-MPI and
GROMACS was compiled without thread-MPI". The solution to this is: 
`sed -i s/-nt/-ntomp/g ~/psiconda/envs/fb/lib/python3.6/site-packages/forcebalance/gmxio.py`
I've done this modification on both TSCC and Vulcan

`fbO_ljboxbuck`
Same as `fbO_ljboxgmx` except making needed changes in `forcefield/` to use Buckingham potential instead of LJ.
ref: http://manual.gromacs.org/current/reference-manual/functions/nonbonded-interactions.html#buckingham-potential
Buckingham parameters taken from Table III of paper "Critical evaluation of molecular mechanics, Engler et al."

`fbO_ljboxbuck2,3,4`
2,3 have larger vdw priors, 4 has no regularization, but still result is bad.


`fbO_allboxbuckB1~6`
Changing to Mayo paper Table 2 initial parameters and only allow B to change in buckingham. 2 also allowed a rather small change in buckingham A and C. Bad result.
also allowing bond and angle parameters to change.
mainly only allow B to change in buckingham, also sometimes allowed a rather small change in buckingham A and C. Tried 3 setups - optimizing all, optimizing C and H, optimizing H.

`fbO_allboxbuckB6earlystop`
early stop of optimization by using a looser convergence criterion. The incentive is that early stop seems to give a little lower THI barrier.
Why the result is bad after I change to table 2 of Mayo paper?

`fbO_allboxbuckB4smallerprior`
Probably the best priors to choose.
fbO_allboxbuckB4smallerprior/input.tmp/scan_dihrot/iter_0012 looks good in PES. More iterations, however, bring THI barrier higher. MD files `B4smaller*.*` using FF params from iter0012. 3 runs fo 100ns trajectories look physical but no transition. It seems unlikely to observe even a single transition from brute force MD 

`fbO_allboxbuckB2new`
My current best bet

`fbO_allboxbuckpaper`
Produces figure for motor paper

`mdframes2psi4.sh`
extract MD frames and send back to QM to create additional FB targets.

`energygrads-to-qdata.ipynb`
parse energies and gradients of `mdframes2psi4.sh` jobs into `qdata.txt` inside `tsqm/mdframes2psi4/`.

`fbO_mdframes` `fbO_mdframes_noreg`
same as `fbO_ccbox3` except the the only targets are frames from `strip.Occboxthree1.mdcrd` processed in `tsqm/mdframes2psi4/`
noreg has no regularization. To see how the resulting FF performs on other targets, copy paste resulting FF files to a new FB directory `fbO_mdframes_noregcont` and see the first iteration result?

`fbO_addmdframes`
same as `fbO_ccbox3` except adding targets from `strip.Occboxthree1.mdcrd` processed in `tsqm/mdframes2psi4/`
The result seems similar to `fbO_ccbox3` but with bonds and angles slightly less softened.

`fbO_weightmdframes`
increase the weight of mdframes target, to strike a balance between decreasing THI barrier and preventing too much bond and angle parameter changes. 2 has larger priors, MD files `Oweightmdframes*.*` which give no transition even using WESTPA in westpa/O2/.
Seems that role of mdframes are not very different from tuning prior widths, i.e. not possible to strike a better balance than not using mdframes

`fbO_maxweightmdframes`
make weight of mdframes target much larger than other targets so essentially fitting to only mdframes target, but with the added benefit that I can also see how other targets perform.
The resulting dihrot PES has generally correct shape but too high THI barrier

`fbS_modbond` `fbS_modbondcc`
same setup as `fbS_2scans` but before optimization, manually modify central bond length to 1.36A, average of `S.com` and `Sm.com`. The former uses ce atom type and latter cc. In both cases, modifying bond length improve the final objective function, but not enough changes to stop cc and ce having very different results.

`fbS_box` `fbScc_box`
Optimize all parameters to see whether ce and cc can converge to the same minimum. Indeed, the results essentially the same whether started from cc or ce.

`fbS_box2` `fbScc_box2`
Allowing less change in bond, angle and LJ parameters. Still cc and ce converge to the same minimum

`fbS_box3` `fbScc_box3`
Allowing even less change in bond, angle and LJ parameters. cc and ce now converge to slightly different PES and obj. function.

`fbS_box4` `fbScc_box4`
In between box2 and box4. cc and ce have noticeable but very small different result.

`fbS_nolog`
same as `fbS_2scans` except not using log map. EVAL must be used to prevent negative amplitudes. The inputs are similar to `fbS_box`. The final parameters is close to `fbS_2scans`, except now the small amplitudes often become essentially zero, and the final objective function is a tiny bit better. Still can not converge to same final parameters when using cc or ce. Reasonable result from ordinary MD simulations, no simulation artifact found. Good rate constant from WESTPA

`fbO_nolog`
Very close to `fbOcc`. Not sure which one is better.

`fbN_nolog`
Very close to fbN_2scans with slightly better looking PES