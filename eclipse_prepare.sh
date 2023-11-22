#!/bin/bash
#
# Eclipse platform prepare script
#
# Steps:
# 1. Choose an ECLIPSE_PREPARE_DIR dir containing the Eclipse directory (default $HOME/eclipse_prepare/)
# 2. Copy the new Eclipse.app into the ECLIPSE_PREPARE_DIR dir
# 3. Update the VERSION and RELEASE vars in the script
# 4. Run this script (doh!)

# Change these settings for every Eclipse version
 
VERSION="4.29"
RELEASE="2023-09"

# Change this value if the ECLIPSE_PREPARE_DIR is not the default one 
ECLIPSE_PREPARE_DIR="$HOME/eclipse_prepare"

# MacOSX command
CMD="$ECLIPSE_PREPARE_DIR/Eclipse.app/Contents/MacOS/eclipse -application org.eclipse.equinox.p2.director "

# DEFAULT ECLIPSE REPOS
eclipse_updates=https://download.eclipse.org/eclipse/updates/$VERSION/
eclipse_releases=https://download.eclipse.org/releases/$RELEASE/
eclipse_epp_packages=https://download.eclipse.org/technology/epp/packages/$RELEASE/

# SVN CUSTOM REPOS
svn_repo=https://download.eclipse.org/technology/subversive/4.8/release/latest/
connectors_repo=https://osspit.org/eclipse/subversive-connectors/

repos=$eclipse_updates,$eclipse_releases,$eclipse_epp_packages,$svn_repo,$connectors_repo

# FEATURES
jdt=org.eclipse.jdt.feature.group
svn=org.eclipse.team.svn.feature.group
connectors=org.polarion.eclipse.team.svn.connector,org.polarion.eclipse.team.svn.connector.svnkit1_10
wildwebdevelopers=org.eclipse.wildwebdeveloper.feature.feature.group

features=$jdt,$svn,$connectors,$wildwebdevelopers

echo "+======================================================"
echo "| PROVISIONING ECLIPSE IDE"
echo "|   Version: $VERSION"
echo "|   Release: $RELEASE"
echo "| FROM THESE REPOS:"
echo  $repos | tr ',' '\n' | xargs printf "|  %s\n"
echo "| WITH THESE FEATURES:"
echo  $features | tr ',' '\n' | xargs printf "|  %s\n"
echo "+======================================================"

$CMD -r $repos -i $features -profile SDKProfile -profileProperties org.eclipse.update.install.features=true

echo ""
echo "+======================================================"
echo "| LISTING INSTALLED FEATURES"
echo "+======================================================"

$CMD -lir
