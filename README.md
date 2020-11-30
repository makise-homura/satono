# satono - serial terminal over network

## Requirements

* tmux
* minicom
* MOXA npreal2 driver (if you use MOXA serial-to-ethernet terminal servers)
* systemd (to run it automatically on startup)

## Installation

* Copy `*.conf` files to `/etc/satono` (create if needed).
* Copy `satono` to `/usr/bin`.
* If you have `systemd`, copy `satono.service` to `/lib/systemd/system/`.
* Edit `*.conf` files as you need.

## Configuration

### satono.conf

* `PORTTYPE`: Prefix of serial ports to use. Examples may be `ttyS`, `ttyUSB`, `ttyACM`, etc. For MOXA server, it's `ttyr`. These ports should exist under `/dev`.
* `USE_SERVER`: `yes` or `no`; whether to use MOXA server, or directly deal with local serial ports.
* `LOGPATH`: Where to store logs. A subdirectory named `satono` will be created, and logs will be put there.
* `TMPPATH`: Where to store temporary scripts. A subdirectory named `satono` will be created, and such scripts will be put there. Should NOT be mounted with `-o noexec`!

### server.conf

Only used if `USE_SERVER=yes` and you use MOXA terminal server.

* `SERVERNAME`: hostname or IP of MOXA terminal server.
* `PORTS`: number of ports on MOXA terminal server.

Note: you may run `satono -r` to reconfigure server, if you have trouble with its ports (e.g., you've just changed server IP/hostname).

### computers.conf

Should consist of lines in format like `N-hostname`, where `N` is a number of port to which machine named `hostname` is connected.

For example, if you have connected `ttyS3` to `some-machine`, you should write `3-some-machine` (and `PORTTYPE` in `satono.conf` should be `ttyS`). 

Note: you can't omit leading zeros. E.g., if you have `ttyS03` instead of `ttyS3`, you should specify `03-some-machine` instead of `3-some-machine`.

Hostnames are not required to match actual hostnames; they just used for informational purposes like tmux status bar and names of log files.

Order of computers specified will correspond to order as they appear in tmux.

## Running

Manual start: run `satono`.

Manual stop: run `tmux kill-session -t satono`, or `tmux kill-server` (if you have no other tmux sessions).

Once `satono` is started, you may attach to it using `tmux attach` command (to detach, press Ctrl+B D).

If you have `systemd`, you may run `systemctl start satono` and `systemctl stop satono` correspondingly instead.

To make `satono` run on system startup, run `systemctl enable satono` (and `systemctl disable satono` if you don't wish it anymore).

## Trivia

Named after [Satono Nishida](https://en.touhouwiki.net/wiki/Satono_Nishida), Okina Matara's servant. Hope `satono` will be a good servant for all your serial terminals over network needs.
