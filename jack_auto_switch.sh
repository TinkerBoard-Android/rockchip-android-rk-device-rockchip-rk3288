#! /system/bin/sh

projectid=`cat /proc/projectid`
boardid=`cat /proc/boardid`
echo project=${projectid};
echo boardid=${boardid};

if [ "${projectid}" == "7" ]; then
	if [ "${boardid}" == "0" ]; then
		exit 0
	elif [ "${boardid}" == "1" ]; then
		exit 0
	elif [ "${boardid}" == "2" ]; then
		exit 0
	fi
fi

source /system/etc/audio.conf

if [ "${jack_auto_switch}" == "on" ]; then

if [ "$1" == "in" ]; then
	su 0 setprop persist.audio.output 2
fi

if [ "$1" == "out" ]; then
	case "${jack_remove_device}" in
		"1") su 0 setprop persist.audio.output 0 ;;
		"2") su 0 setprop persist.audio.output 1 ;;
		*) exit 0 ;;
	esac
fi

fi
