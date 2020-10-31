#!/bin/bash

if [ -n "$SEG_DEBUG" ] ; then
  set -x
  env | sort
fi

cd $WEST_SIM_ROOT
mkdir -pv $WEST_CURRENT_SEG_DATA_REF
cd $WEST_CURRENT_SEG_DATA_REF

ln -sv $WEST_SIM_ROOT/common_files/Snolog1.prmtop .
ln -sv $WEST_SIM_ROOT/common_files/dihedral.restraint .

if [ "$WEST_CURRENT_SEG_INITPOINT_TYPE" = "SEG_INITPOINT_CONTINUES" ]; then
  sed "s/RAND/$WEST_RAND16/g" $WEST_SIM_ROOT/common_files/md.in > md.in
  ln -sv $WEST_PARENT_DATA_REF/seg.rst ./parent.rst
elif [ "$WEST_CURRENT_SEG_INITPOINT_TYPE" = "SEG_INITPOINT_NEWTRAJ" ]; then
  sed "s/RAND/$WEST_RAND16/g" $WEST_SIM_ROOT/common_files/md.in > md.in
  ln -sv $WEST_PARENT_DATA_REF ./parent.rst
fi

# I came up with this easy but nonoptimal way to distribute jobs among multiple (8 for gibbs) gpus. 
# If there are many jobs the distribution should be even enough, but memory could be not enough?
export CUDA_VISIBLE_DEVICES=$((RANDOM % 4))

$PMEMD -O -i md.in -p Snolog1.prmtop -c parent.rst -r seg.rst -x seg.nc -o seg.log -inf seg.mdinfo

COMMAND="         parm $WEST_SIM_ROOT/common_files/Snolog1.prmtop\n" 
COMMAND="$COMMAND trajin $WEST_CURRENT_SEG_DATA_REF/parent.rst\n"
COMMAND="$COMMAND trajin $WEST_CURRENT_SEG_DATA_REF/seg.nc\n"
COMMAND="$COMMAND autoimage anchor :MOL\n"
COMMAND="$COMMAND dihedral distant @3017 @3018 @3002 @3001 out dih.dat\n"
COMMAND="$COMMAND pucker stator @3007 @3006 @3001 @3014 @3013 @3008 cremer amplitude range360 out sta.dat\n"
COMMAND="$COMMAND go"

echo -e "$COMMAND" | cpptraj

paste <(cat dih.dat | tail -n +2 | awk {'print $2'}) <(cat sta.dat | tail -n +2 | awk {'print $2'})>$WEST_PCOORD_RETURN

# Clean up
rm -f $TEMP md.in parent.rst seg.nfo seg.pdb 

