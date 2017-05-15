#!/usr/bin/bash

if [ $(whoami) != 'root' ]; then 
	echo "Must be root to run $0";
	echo "run as sudo"
	exit
fi
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install build-essential ruby-dev libpcap-dev -y
function pyInstall(){
	sudo pip install $1 -y
}
function Install(){
	sudo gem install $1 -y
}
pack=(rubysl-open3 twilio-ruby shellex)
dep=(pysqlite selenium requests html2text )
for i in "${pack[@]}"
do
   Install $i
done
for i in "${dep[@]}"
do
   pyInstall $i
done

sudo apt-cache search beautifulsoup
sudo apt-get install  -y
sudo python config.py






