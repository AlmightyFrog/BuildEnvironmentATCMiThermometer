#!/bin/bash

docker run --rm -v $PWD:/app -it tc32 -c "cd ATC_MiThermometer/ATC_Thermometer && make $@"
