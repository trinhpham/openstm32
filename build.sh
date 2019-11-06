#!/bin/bash

echo ============================
echo Starting up...
export PLUGIN_PATH=`find /usr/local/OpenStm32/plugins -maxdepth 1 -type d -name 'fr.ac6.mcu.externaltools.arm-none.linux64*' -print -quit`
export PATH=$PLUGIN_PATH/tools/compiler/bin:$PATH
echo Current PATH: $PATH
echo

echo ============================
echo Import project from src..
/usr/local/OpenStm32/eclipse -nosplash -no-indexer -consoleLog -debug -application org.eclipse.cdt.managedbuilder.core.headlessbuild --launcher.suppressErrors -data /workspace -import /src
echo
echo ============================
echo Start build...
/usr/local/OpenStm32/eclipse -nosplash -no-indexer -consoleLog -debug -application org.eclipse.cdt.managedbuilder.core.headlessbuild --launcher.suppressErrors -data /workspace -build all -printErrorMarkers
