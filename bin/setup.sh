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

mkdir -p ${TOPDIR}/classes

#########################################################
# usage
#########################################################
usage() {
    echo "usage: $0 [-b repopath | --bhs-deployed-repo repopath ]"
}



#########################################################
# main
#########################################################
BHS_DEPLOYED_REPO=

shortoptions='b:'
longoptions='bhs-deployed-repo:'
getopt=$(getopt -o $shortoptions --longoptions  $longoptions -- "$@")
if [ $? != 0 ]; then
   usage
   exit 1;
fi

eval set -- "$getopt"
while true; do
   case "$1" in
      -h|--help)
         help
         exit 1
      ;;
      -b|--bhs-deployed-repo)
         shift
         BHS_DEPLOYED_REPO=$1
         shift
				 break
      ;;
      *)
				break
      ;;
   esac
done




cat >$TOPDIR/env.xml  <<EOF
<project name="env" default="all" basedir=".">
    <property name="global.classpath" value="${TOPDIR}/classes:${TOPDIR}/dev-init/lib/tpso.jar"/>
    <property name="jar.dir" value="${TOPDIR}/jars-old"/>
    <property name="top.dir" value="${TOPDIR}"/>
    <property name="ant.home" value="${TOPDIR}/dev-init/apps/ant"/>
		<property name="ant.build.javac.target" value="6" />
		<property name="ant.build.javac.source" value="6" />
EOF
if [ -n "$BHS_DEPLOYED_REPO" ] ; then
cat >>$TOPDIR/env.xml  <<EOF
		<property name="bhs.deployed.repo" value="${BHS_DEPLOYED_REPO}" />
EOF
fi

cat >>$TOPDIR/env.xml  <<EOF
</project>
EOF

cat >$TOPDIR/env.sh  <<EOF
export PATH=${TOPDIR}/dev-init/bin:${TOPDIR}/dev-init/apps/ant/bin:${TOPDIR}/dev-init/apps/java/bin:${TOPDIR}/dev-init/apps/gradle/bin:${TOPDIR}/dev-init/apps/maven/bin:$PATH
export ANT_HOME=${TOPDIR}/dev-init/apps/ant
export JAVA_HOME=${TOPDIR}/dev-init/apps/java
export CLASSPATH=.
EOF
