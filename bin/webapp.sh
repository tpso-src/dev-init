#!/bin/bash
THISDIR=`readlink $0`
if [ "${THISDIR}" != "" ]
then
   THISDIR=`dirname $THISDIR`
else
   THISDIR=`dirname $0`
fi
cd $THISDIR/../../classes
jar cf ../dev-init/lib/tpso.jar com/tps/javasource  com/tps/interp com/tps/remotecall com/tps/sml com/tps/pub com/tps/dbutil com/tps/utils/ddlgen com/tps/net/html com/tps/webapp  com/tps/config com/tps/sql com/tps/xml com/tps/util com/tps/init com/tps/regexp com/tps/math com/tps/viewer com/tps/print  com/tps/io/ 
