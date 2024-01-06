#!/usr/bin/env bash

# The sway output to set the background on.
hdmi="HDMI-A-2"

# The folder where your own custom ROM images are stored.
marqueeDir="/userdata/marquee/arcade"

# The generic marquee to use when nothing is found.
genericImage="${marqueeDir}/generic.png"

# The fill type for swaybg, valid options are:
# "stretch", "fill", "fit", "center", "tile"
fill="fill"

# A file to store last marquee set, to prevent setting
# it again (reduces flickering)
tmpFile="/tmp/lastMarquee.txt"

findMarquee () {
    declare romFile="$1"

    romDir=${romFile%/*}
    romName=${romFile##*/}
    romId=${romName%.*}

    marqueeImage="${marqueeDir}/${romId}.png"

    if [ ! -f $marqueeImage ]; then
        marqueeImage="${romDir}/images/${romId}-marquee.png"
    fi
    if [ ! -f $marqueeImage ]; then
        marqueeImage="$genericImage"
    fi

    echo $marqueeImage
}

displayMarquee () {
    declare img="$1"

    if [ ! -f $img ]; then
        return
    fi

    if [ "$img" = "$(cat $tmpFile)" ]; then
        return
    fi

    swaymsg output $hdmi enable bg $img $fill
    echo -n $img > $tmpFile
}

case "$1" in
    "gameStart")
        imageFile=$(findMarquee $5)
        ;;
    "gameSelect")
        imageFile=$(findMarquee $2)
        ;;
    "systemSelect")
        # FIX ME
        imageFile="$genericImage"
	;;
    *)
        imageFile="$genericImage"
	;;
esac

displayMarquee $imageFile
