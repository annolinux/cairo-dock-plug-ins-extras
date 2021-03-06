#!/bin/bash

function reload_plugin {
	dbus-send --session --dest=org.cairodock.CairoDock /org/cairodock/CairoDock org.cairodock.CairoDock.ActivateModule string:"$1" boolean:false;
	dbus-send --session --dest=org.cairodock.CairoDock /org/cairodock/CairoDock org.cairodock.CairoDock.ActivateModule string:"$1" boolean:true;
}

gksudo -S -g -m "Root password required for installation" date &&
make clean && make -j $(grep -c ^processor /proc/cpuinfo) && 
sudo make install &&
if [ $@ > 0 ];
then reload_plugin "$1"
fi
#sudo make install
#&& reload_plugin "$1"

