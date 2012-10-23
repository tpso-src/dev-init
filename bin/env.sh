#!/bin/bash
THISDIR=`readlink $0`
if [ "${THISDIR}" != "" ]
then
   THISDIR=`dirname $THISDIR`
else
   THISDIR=`dirname $0`
fi
function canonicalPath {
   local _path="$1" ; shift
   if [ -d "$_path" ]
   then
      echo "$(cd "$_path" ; pwd)"
   else
      local b=$(basename "$_path")
      local p=$(dirname "$_path")
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
    <property name="ant.home" value="${TOPDIR}/dev-init/apps/ant"/>
</project>
EOF

mkdir -p classes
export PATH=${TOPDIR}/dev-init/apps/ant/bin:${TOPDIR}/dev-init/apps/java/bin:${TOPDIR}/dev-init/apps/gradle/bin:${TOPDIR}/dev-init/apps/maven/bin:$PATH
export ANT_HOME=${TOPDIR}/dev-init/apps/ant
export JAVA_HOME=${TOPDIR}/dev-init/apps/java
export CLASSPATH=.
