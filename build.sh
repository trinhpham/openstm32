#!/bin/bash

echo Import project from src..
/usr/local/OpenStm32/eclipse -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild -data /workspace -import /src

echo Start build...
/usr/local/OpenStm32/eclipse -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild -data /workspace -cleanBuild all