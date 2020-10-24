#!/bin/bash

if [ -n "$SEG_DEBUG" ] ; then
  set -x
  env | sort
fi

cd $WEST_SIM_ROOT/common_files

COMMAND="           parm $WEST_SIM_ROOT/common_files/Sccnolog1.prmtop\n" 
COMMAND="$COMMAND trajin $WEST_STRUCT_DATA_REF\n"
COMMAND="$COMMAND autoimage anchor :MOL\n"
COMMAND="$COMMAND dihedral distant @3017 @3018 @3002 @3001 out dih.dat\n"
COMMAND="$COMMAND pucker stator @3007 @3006 @3001 @3014 @3013 @3008 cremer amplitude range360 out sta.dat\n"
COMMAND="$COMMAND go"

echo -e "$COMMAND" | cpptraj

paste <(cat dih.dat | tail -n +2 | awk {'print $2'}) <(cat sta.dat | tail -n +2 | awk {'print $2'})>$WEST_PCOORD_RETURN

if [ -n "$SEG_DEBUG" ] ; then
  head -v $WEST_PCOORD_RETURN
fi



