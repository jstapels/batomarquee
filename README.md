# batomarquee

Some scripts and utilities to show a marquee in Batocera through a second HDMI port.

For now, this is really just a bit of a hack and should probably be configured in emulation station.

## Installation

Move the existing scripts into their own respective folders under `/userdata`. For example...

- `marquee.sh` --> `/userdata/scripts/marquee.sh`
- `marquee-game.sh` --> `/userdata/config/emulationstation/scripts/marquee-game.sh`

Ensure that you've given both scripts execute permissions (e.g. `chmod +x marquee.sh`).

## Configuration

For now, you set the configuration inside the `marquee.sh` script. Comments have been added to make is easier to understand. To figure out the name of your sway output, you can run the following command:

```console
# swaymsg -t get_outputs | jq '.[].name'
"HDMI-A-1"
"HDMI-A-2"
```

## Usage

Not much you can do directly. By default it will look in `/userdata/marquee/arcade/` for marquees. If it doesn't find it there, it will then fallback to scraped "marquee" image. If _that_ doesn't exist, it will then attempt to load the generic image.

### Troubleshooting

With Batocera v39, retroarch had trouble selecting the correct display to use when the second display was active (causing it to freeze). You may be able to workaround this issue by setting an explicit monitor index in your `batocera.conf` file:

```
global.retroarch.video_monitor_index=2
```
