#!/bin/bash
echo "What's the .com file name (tsqm/name.com)?"
read com
echo "Directory name for running ForceBalance (onsager/fb/dir)?"
read name
echo "Directory for your Torsiondrive dihpyr job that gives qdata.txt (tsqm/td/dir)?"
read tddir1
echo "Directory for your Torsiondrive dihrot job that gives qdata.txt (tsqm/td/dir)?"
read tddir2

mkdir -p /home/winter/onsager/fb/$name
cd /home/winter/onsager/fb/$name

cat > input.in << EOF
\$options
forcefield $name.frcmod
jobtype newton
writechk $name.fbchk
LOGARITHMIC_MAP
\$end
\$target
type abinitio_amber
name scan_dihpyr
engine amber
force 1
writelevel 2
amber_leapcmd $name.leap
\$end
\$target
type abinitio_amber
name scan_dihrot
engine amber
force 1
writelevel 2
amber_leapcmd $name.leap
\$end
EOF
mkdir targets
cd targets

mkdir -p scan_dihpyr
cd scan_dihpyr
cp /home/winter/onsager/tsqm/td/$tddir1/qdata.txt qdata.txt
python /home/winter/onsager/forcebalance/src/molecule.py qdata.txt all.mdcrd
cat > $name.leap << EOF
loadamberparams $name.frcmod
MOL = loadmol2 /projects/gilson-onsager/mufeng/fb/$name.mol2
x = loadpdb conf.pdb
saveamberparm x fb.prmtop fb.inpcrd
quit
EOF
cd ..

mkdir -p scan_dihrot
cd scan_dihrot
cp /home/winter/onsager/tsqm/td/$tddir2/qdata.txt qdata.txt
python /home/winter/onsager/forcebalance/src/molecule.py qdata.txt all.mdcrd
cat > $name.leap << EOF
loadamberparams $name.frcmod
MOL = loadmol2 /projects/gilson-onsager/mufeng/fb/$name.mol2
x = loadpdb conf.pdb
saveamberparm x fb.prmtop fb.inpcrd
quit
EOF
cd ..

cd ..
mkdir -p forcefield
cd forcefield
antechamber -i /home/winter/onsager/tsqm/$com.com -fi gcrt -o $name.mol2 -fo mol2 -at gaff2 -c bcc
#sed -i s/cc/ce/g $name.mol2
rm ANTE* ATOMTYPE* sqm.*
parmchk2 -a Y -i $name.mol2 -f mol2 -o $name.frcmod -s 2
obabel -imol2 $name.mol2 -opdb conf.pdb > conf.pdb     # this step may give lots of warnings but OK.
cp conf.pdb ../targets/scan_dihpyr/conf.pdb
mv conf.pdb ../targets/scan_dihrot/conf.pdb
mv $name.mol2 ../../$name.mol2

echo "!!! Not done yet! You need to manually add things like ; PRM 2 to .frcmod before running FB!!!"

