# satono - serial terminal over network

## Requirements

* tmux
* minicom
* MOXA npreal2 driver (if you use MOXA serial-to-ethernet terminal servers)
* systemd (to run it automatically on startup)

## Installation

* Copy `*.conf` files to `/etc/satono` (create if needed).
* Copy `satono` to `/usr/bin`.
* If you have `systemd`, copy `satono.service` to `/lib/systemd/system/` directory.
* If you have `sysvinit`, copy `satono.init.d` as `/etc/init.d/satono` file.
* Edit `*.conf` files as you need.

## Configuration

### satono.conf

* `PORTTYPE`: Prefix of serial ports to use. Examples may be `ttyS`, `ttyUSB`, `ttyACM`, etc. For MOXA server, it's `ttyr`. These ports should exist under `/dev`.
* `USE_SERVER`: `yes` or `no`; whether to use MOXA server, or directly deal with local serial ports.
* `LOGPATH`: Where to store logs. A subdirectory named `satono` will be created, and logs will be put there.
* `TMPPATH`: Where to store temporary scripts. A subdirectory named `satono` will be created, and such scripts will be put there. Should NOT be mounted with `-o noexec`!

### server.conf

Only used if `USE_SERVER=yes` and you use MOXA terminal server.

* `SERVERS`: list of MOXA terminal servers (hostname/IP and number of ports of each server should be separated by colon, and such records should be separated by spaces).

Example:

    SERVERS="moxaserver1.local.lan:16 moxaserver2.local.lan:4"

If you use only one server, you might use (deprecated) legacy variables:

* `SERVERNAME`: hostname or IP of MOXA terminal server.
* `PORTS`: number of ports on MOXA terminal server.

Example:

    SERVERNAME=moxaserver.local.lan
    PORTS=32

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

Once `satono` is started, you may attach to it using `tmux attach` command (or `tmux attach -t satono`, if you have another tmux sessions). To detach, press Ctrl+B D.

Or, instead, you may run `systemctl start satono` and `systemctl stop satono` (if you have `systemd`), or `service satono start` and `service satono stop` (if you have `sysvinit`) correspondingly.

To make `satono` run on system startup, with `systemd`, run `systemctl enable satono` (and `systemctl disable satono` if you don't wish it anymore); or `chkconfig satono on` (and `chkconfig satono off`), with `sysvinit`.

## Trivia

Named after [Satono Nishida](https://en.touhouwiki.net/wiki/Satono_Nishida), Okina Matara's servant. Hope `satono` will be a good servant for all your serial terminals over network needs.
