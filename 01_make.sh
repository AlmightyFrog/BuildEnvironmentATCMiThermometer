#!/bin/bash

DEVICE_TYPE="LYWSD03MMC" # LYWSD03MMC, MHO_C401 or CGG1
DOCKER_COMMAND="cd ATC_MiThermometer/ATC_Thermometer && TEL_PATH=../../SDK make"
ATC_MITHERMOMETER_FLAVOR="atc1411"

echo \#\#
echo \#\# Build
echo \#\#
if [ ! -d "ATC_MiThermometer/ATC_Thermometer" ]; then
    sed -i '' -E "s/#define DEVICE_TYPE.*\/\//#define DEVICE_TYPE\t\t\tDEVICE_$DEVICE_TYPE \/\//g" ATC_MiThermometer/src/app_config.h
    DOCKER_COMMAND="cd ATC_MiThermometer && TEL_PATH=../SDK make"
    ATC_MITHERMOMETER_FLAVOR="pvvx"
fi
docker run --rm -v $PWD:/app -it tc32 -c "$DOCKER_COMMAND  $@"
echo \#\#
echo \#\# Built $ATC_MITHERMOMETER_FLAVOR ATC_MiThermometer
echo \#\#

mkdir -p firmware
echo \#\#
firmware_out=firmware/ATC_Thermometer_"$ATC_MITHERMOMETER_FLAVOR"_"$DEVICE_TYPE"_"$(date +%s)".bin
cp ATC_MiThermometer/ATC_Thermometer.bin $firmware_out && echo \#\# Here is your awesome firmware: $firmware_out || echo \#\# No file found
echo  \#\#
