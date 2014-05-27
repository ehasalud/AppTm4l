#!/bin/bash 

# change the working directory to the directory where script is stored
cd "$(dirname "$0")"
java -Djava.library.path=/usr/lib/jni -jar ij.jar -macro AppTm4l.ijm
