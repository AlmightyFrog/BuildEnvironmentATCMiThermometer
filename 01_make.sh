#!/bin/bash

DEVICE_TYPE="LYWSD03MMC" # LYWSD03MMC, MHO_C401 or CGG1

echo \#\#
echo \#\# Build
echo \#\#
if [ -d "ATC_MiThermometer/ATC_Thermometer" ]; then
    docker run --rm -v $PWD:/app -it tc32 -c "cd ATC_MiThermometer/ATC_Thermometer && TEL_PATH=../../SDK make $@"
    echo \#\#
    echo \#\# Built atc1441 ATC_MiThermometer
else
    sed -i '' -E "s/#define DEVICE_TYPE.*\/\//#define DEVICE_TYPE\t\t\tDEVICE_$DEVICE_TYPE \/\//g" ATC_MiThermometer/src/app_config.h
    docker run --rm -v $PWD:/app -it tc32 -c "cd ATC_MiThermometer && TEL_PATH=../SDK make $@"
    echo \#\#
    echo \#\# Built pvvx ATC_MiThermometer \(if you\'re not using windows an error will occor on validation with tl_check_fw2.exe, it\'s okey\)
fi
echo \#\#

mkdir -p firmware
echo \#\#
firmware_out=firmware/ATC_Thermometer_"$DEVICE_TYPE"_"$(date +%s)".bin
cp ATC_MiThermometer/ATC_Thermometer.bin $firmware_out && echo \#\# Here is your awesome firmware: $firmware_out || echo \#\# No file found
echo  \#\#
