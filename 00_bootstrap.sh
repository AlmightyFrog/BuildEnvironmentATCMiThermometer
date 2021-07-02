#!/bin/bash
$MAKE_COMMAND

if [ ! -d "ATC_MiThermometer" ]; then
    read -p "Select flavor of firmware, 'atc1441' or 'pvvx' [atc1441]: " FLAVOR
fi
FLAVOR=${FLAVOR:-atc1441}


echo \#\# First prepare build environment
if [ ! -f "docker/tc32_gcc.tar.bz2" ]; then
    curl  http://shyboy.oss-cn-shenzhen.aliyuncs.com/readonly/tc32_gcc_v2.0.tar.bz2 > docker/tc32_gcc.tar.bz2
fi
docker buildx build --platform linux/amd64 ./docker/ -t tc32

if [ ! -d "SDK" ]; then
    echo \#\# Now download Telink 825X SDK
    git clone --depth=1 https://github.com/Ai-Thinker-Open/Telink_825X_SDK SDK
fi

if [ ! -d "ATC_MiThermometer" ]; then
    echo \#\# Download ATC_MiThermometer project
    git clone "https://github.com/$FLAVOR/ATC_MiThermometer" ATC_MiThermometer
fi


echo \#\# Done, to change flavor delate folder ATC_MiThermometer and run again
echo \#\# run sh 01_make.sh to build the firmware