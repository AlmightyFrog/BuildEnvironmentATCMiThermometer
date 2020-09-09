# Build environment setup for ATC_MiThermometer

This is a tc32_gcc custom tailored build environment for https://github.com/atc1441/ATC_MiThermometer according to referenced instructions there for linux but in a docker container.

It shall work on both Linux and macOS with following dependencies installed:
* curl
* docker
* git
* sed 

**00_bootstrap.sh** does only need to be run once which does multiple things

* build docker image containing tc32_gcc similar like mentioned in https://github.com/Ai-Thinker-Open/Telink_825X_SDK/blob/master/start_linux.md
* fetches https://github.com/Ai-Thinker-Open/Telink_825X_SDK as SDK
* fetches https://github.com/atc1441/ATC_MiThermometer and patches makefile to be able to run with this build environment using custom SDK location

Afterwards you can simply use **01_make.sh** to compile ATC_MiThermometer. If you want you can also add parameter like "**./01_make.sh clean**" to it.

There is also **02_tc32_shell.sh** which opens the docker container build environment as a shell.


Please note, that UID and GID of the docker build can be altered as parameter, default is 1000:1000.
The build environment itself is generic, so you also might want to check out your own project besides ATC_MiThermometer and use it with adapted path in make command.

