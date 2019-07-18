#!/bin/sh

# From https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/latest
JDK_URL=https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.4%2B11/OpenJDK11U-jdk_x64_linux_hotspot_11.0.4_11.tar.gz
JDK_FILE=OpenJDK11U-jdk_x64_linux_hotspot_11.0.4_11.tar.gz
JDK_DIR=jdk-11.0.4+11
JVM_DIR=jvm
JVM_FILE=jvm-11-linux.tar.gz

# change work directory
cd "$(dirname "$0")"

if [ -f "$JDK_FILE" ]
then
	echo "Using cached $JDK_FILE.."
else
	echo "Downloading openjdk from $JDK_URL.."
	wget $JDK_URL || exit 1
fi

echo "Unzipping openjdk"
tar -xf $JDK_FILE

echo "Building Java Runtime.."
./$JDK_DIR/bin/jlink \
--output $JVM_DIR \
--compress 2 \
--no-man-pages \
--add-modules java.base,java.desktop,java.management,java.logging,jdk.unsupported,java.naming \
|| exit 2

echo "Creating an archive.."
tar -czf $JVM_FILE jvm/

echo "Cleaning up.."
rm -fr $JDK_DIR
rm -fr $JVM_DIR

echo "Done!"
