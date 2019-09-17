#!/bin/bash

echo ============================
echo Starting up...
export MCU_FOLDER=`find /usr/local/OpenStm32/plugins -maxdepth 3 -type d -name 'st-gnu-arm-gcc*' -print -quit`
export PATH=$MCU_FOLDER/bin:$PATH
echo Current PATH: $PATH
echo

echo ============================
echo Import project from src..
/usr/local/OpenStm32/eclipse -nosplash -no-indexer -consoleLog -debug -application org.eclipse.cdt.managedbuilder.core.headlessbuild --launcher.suppressErrors -data /workspace -import /src
echo
echo ============================
echo Start build...
/usr/local/OpenStm32/eclipse -nosplash -no-indexer -consoleLog -debug -application org.eclipse.cdt.managedbuilder.core.headlessbuild --launcher.suppressErrors -data /workspace -build all