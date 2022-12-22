#!/bin/sh
### BEGIN INIT INFO
# Provides:          satono
# Required-Start:    $syslog $local_fs $network $named
# Required-Stop:     $syslog $local_fs $network $named
# Default-Start:     3 4 5
# Default-Stop:      0 1 2 6
# Short-Description: satono - serial terminal over network
# Description:       Provides serial terminal over network using tmux and minicom, and probably MOXA driver
### END INIT INFO

. "/etc/sysconfig/rc"
. "${rc_functions}"

SATONO="/usr/bin/satono"

case "${1}" in
	start)
		boot_mesg "Starting satono..."
		"$SATONO"
		evaluate_retval
		;;
	stop)
		boot_mesg "Stopping satono..."
		"$SATONO" --kill
		evaluate_retval
		;;
	restart)
		${0} stop
		sleep 1
		${0} start
		;;
	*)
		echo "Usage: ${0} {start|stop|restart}"
		exit 1
		;;
esac
