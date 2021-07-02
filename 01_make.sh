#!/bin/bash
echo \#\#
echo \#\# Build
echo \#\#
if [ -d "ATC_MiThermometer/ATC_Thermometer" ]; then
    docker run --rm -v $PWD:/app -it tc32 -c "cd ATC_MiThermometer/ATC_Thermometer && TEL_PATH=../../SDK make $@"
    echo \#\#
    echo \#\# Built atc1441 ATC_MiThermometer
else
    docker run --rm -v $PWD:/app -it tc32 -c "cd ATC_MiThermometer && TEL_PATH=../SDK make $@"
    echo \#\#
    echo \#\# Built pvvx ATC_MiThermometer \(if you\'re not using windows an error will occor on validation with tl_check_fw2.exe, it\'s okey\)
fi
echo \#\#

mkdir -p firmware
echo \#\#
cp ATC_MiThermometer/ATC_Thermometer.bin firmware/ATC_Thermometer_"$(date +%s)".bin && echo \#\# Here is your awesome firmware: firmware/ATC_Thermometer_"$(date +%s)".bin || echo \#\# No file found
echo  \#\#
