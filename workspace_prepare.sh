#!/bin/bash
set -euo pipefail

WORKSPACE_DIR="$HOME/eclipse_prepare/workspace"
MAVEN_TOOL_CMD="$HOME/dev/tools/apache-maven-3.9.4/bin/mvn"

METADATA_DIR="$WORKSPACE_DIR/.metadata/.plugins"
SETTINGS_DIR="$METADATA_DIR/org.eclipse.core.runtime/.settings"
LAUNCH_DIR="$METADATA_DIR/org.eclipse.debug.core/.launches"

#rm -rf $WORKSPACE_DIR
mkdir -p $SETTINGS_DIR
mkdir -p $LAUNCH_DIR

echo "Setting $SETTINGS_DIR/org.eclipse.ui.prefs"
cat >> $SETTINGS_DIR/org.eclipse.ui.prefs << EOF
defaultPerspectiveId=org.eclipse.jdt.ui.JavaPerspective
showIntro=false
EOF

echo "Setting $SETTINGS_DIR/org.eclipse.ui.editors.prefs"
cat >> $SETTINGS_DIR/org.eclipse.ui.editors.prefs << EOF
lineNumberRuler=true
spellingEnabled=false
tabWidth=2
textDragAndDropEnabled=false
EOF

echo "Setting $SETTINGS_DIR/org.eclipse.debug.ui.prefs"
cat >> $SETTINGS_DIR/org.eclipse.debug.ui.prefs << EOF
org.eclipse.debug.ui.RelaunchAndTerminateLaunchAction=true
EOF

echo "Setting $SETTINGS_DIR/org.eclipse.wildwebdeveloper.prefs"
cat >> $SETTINGS_DIR/org.eclipse.wildwebdeveloper.prefs << EOF
html.hover.documentation=false
html.hover.references=false
html.validate.scripts=false
html.validate.styles=false
EOF

echo "Setting $SETTINGS_DIR/org.eclipse.wildwebdeveloper.xml.prefs"
cat >> $SETTINGS_DIR/org.eclipse.wildwebdeveloper.xml.prefs << EOF
org.eclipse.wildwebdeveloper.xml.codeLens.enabled=false
org.eclipse.wildwebdeveloper.xml.validation.enabled=false
org.eclipse.wildwebdeveloper.xml.validation.namespaces.enabled=never
org.eclipse.wildwebdeveloper.xml.validation.noGrammar=ignore
EOF

echo "Creating Maven Launch in $LAUNCH_DIR"
cat > $LAUNCH_DIR/Maven.launch << EOF
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<launchConfiguration type="org.eclipse.ui.externaltools.ProgramLaunchConfigurationType">
    <booleanAttribute key="org.eclipse.debug.core.ATTR_FORCE_SYSTEM_CONSOLE_ENCODING" value="false"/>
    <stringAttribute key="org.eclipse.ui.externaltools.ATTR_LOCATION" value="$MAVEN_TOOL_CMD"/>
    <stringAttribute key="org.eclipse.ui.externaltools.ATTR_TOOL_ARGUMENTS" value="generate-sources"/>
    <stringAttribute key="org.eclipse.ui.externaltools.ATTR_WORKING_DIRECTORY" value="\${container_loc}"/>
</launchConfiguration>
EOF
