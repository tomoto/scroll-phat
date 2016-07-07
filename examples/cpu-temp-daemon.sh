#!/bin/sh
#
# Put the line below in /etc/rc.local to run cpu-temp.py automatically at boot time:
# /home/pi/Pimoroni/scrollphat/cpu-temp-daemon.sh start
#

set -e

if [ `id -u` -ne 0 ]
then
    echo "Use sudo to run."
    exit 1
fi

NAME=cpu-temp
PIDFILE=/var/run/$NAME.pid
DAEMON=/home/pi/Pimoroni/scrollphat/cpu-temp.py
DAEMON_OPTS=

export PATH="${PATH:+$PATH:}/usr/sbin:/sbin"

case "$1" in
    start)
	echo -n "Starting daemon: "$NAME
	start-stop-daemon --start --background --make-pidfile --quiet --pidfile $PIDFILE --exec $DAEMON -- $DAEMON_OPTS
	echo "."
	;;
    stop)
	echo -n "Stopping daemon: "$NAME
	start-stop-daemon --stop --signal INT --quiet --oknodo --pidfile $PIDFILE
	echo "."
	;;
    restart)
	echo -n "Restarting daemon: "$NAME
	start-stop-daemon --stop --signal INT --quiet --oknodo --retry 30 --pidfile $PIDFILE
	start-stop-daemon --start --background --make-pidfile --quiet --pidfile $PIDFILE --exec $DAEMON -- $DAEMON_OPTS
	echo "."
	;;

    *)
	echo "Usage: "$1" {start|stop|restart}"
	exit 1
esac

exit 0
