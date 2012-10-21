#!/bin/bash
THISDIR=`readlink $0`
if [ "${THISDIR}" != "" ]
then
   THISDIR=`dirname $THISDIR`
else
   THISDIR=`dirname $0`
fi
function canonicalPath {
   local path="$1" ; shift
   if [ -d "$path" ]
   then
      echo "$(cd "$path" ; pwd)"
   else
      local b=$(basename "$path")
      local p=$(dirname "$path")
      echo "$(cd "$p" ; pwd)/$b"
   fi
}


export TOPDIR=$(canonicalPath "$THISDIR/../../")
echo "TOPDIR:$TOPDIR"

cat >$TOPDIR/env.xml  <<EOF
<project name="env" default="all" basedir=".">
    <property name="global.classpath" value="${TOPDIR}/classes:${TOPDIR}/dev-init/lib/tpso.jar"/>
    <property name="jar.dir" value="${TOPDIR}/jars-old"/>
    <property name="top.dir" value="${TOPDIR}"/>
</project>
EOF

mkdir -p classes
#export PATH=${TOPDIR}/dev-init/apps/ant/bin:${TOPDIR}/dev-init/apps/java/bin:$PATH
#export CLASSPATH=/tmp/xerces-2_11_0/xml-apis.jar:/tmp/xerces-2_11_0/xercesImpl.jar
