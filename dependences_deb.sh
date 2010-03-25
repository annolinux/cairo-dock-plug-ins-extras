#!/bin/bash

NEEDED="ruby1.8-dev ruby1.8 ri1.8 rdoc1.8 irb1.8 libreadline-ruby1.8 libruby1.8 rubygems1.8 acpi python"

NORMAL="\\033[0;39m"
BLEU="\\033[1;34m"
VERT="\\033[1;32m" 
ROUGE="\\033[1;31m"

for tested in $NEEDED
do
	dpkg -s $tested |grep installed |grep "install ok" > /dev/null
	if [ $? -eq 1 ]; then
		echo -e "$ROUGE""This package $tested isn't installed : Installation""$NORMAL"""
		sudo apt-get install -qq $tested  >> $LOG_CAIRO_DOCK
	fi
done

	# RubyBattery
sudo apt-get install ruby1.8-dev ruby1.8 ri1.8 rdoc1.8 irb1.8 libreadline-ruby1.8 libruby1.8 rubygems1.8 acpi python
if ! test -e '../.gem'; then
	sudo gem install rbus
	sudo gem install parseconfig
	touch '../.gem'
fi
