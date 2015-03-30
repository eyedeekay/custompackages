echo "#!/bin/sh
# Defaults for i2pd initscript
# sourced by /etc/init.d/i2pd
# installed at /etc/fbtun/fbtun.config by the maintainer scripts
# reads per-user settings from home/.fbtunservice
. $HOME/.fbtunservice
DAEMON_OPTS=\"--login=\$FB_CONFIG_UNAME --password=\$FB_CONFIG_PASSWD --friend=\$FB_CONFIG_FRIENDSET\"
" > $FBTUNVERSION$under$VERSION/debian/facebook-tunnel.config
echo "etc/apparmor.d/abstractions
" > $FBTUNVERSION$under$VERSION/debian/facebook-tunnel.dirs
echo "#!/bin/sh
### BEGIN INIT INFO
# Provides:          facebook-tunnel
# Required-Start:    \$network \$local_fs \$remote_fs
# Required-Stop:     \$remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: facebook-tunnel router written in C
### END INIT INFO

PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC=Facebook Tunnel                 # Introduce a short description here
NAME=facebook-tunnel                 # Introduce the short server's name here
DAEMON=/usr/sbin/facebook-tunnel     # Introduce the server's location here
DAEMON_OPTS=\"\"            # Arguments to run the daemon with
PIDFILE=/var/run/\$NAME.pid
SCRIPTNAME=/etc/init.d/\$NAME

# Exit if the package is not installed
[ -x \$DAEMON ] || exit 0

[ -r /etc/default/\$NAME ] && . /etc/default/\$NAME
. /lib/init/vars.sh
. /lib/lsb/init-functions

# Function that starts the daemon/service
do_start()
{
  # Return
  #   0 if daemon has been started
  #   1 if daemon was already running
  #   2 if daemon could not be started
  start-stop-daemon --start --quiet --pidfile \$PIDFILE --exec \$DAEMON --test > /dev/null \
    || return 1
  start-stop-daemon --start --quiet --pidfile \$PIDFILE --exec \$DAEMON -- \
    --daemon=1 --log=1 \$DAEMON_OPTS \
    || return 2
}

# Function that stops the daemon/service
do_stop()
{
  # Return
  #   0 if daemon has been stopped
  #   1 if daemon was already stopped
  #   2 if daemon could not be stopped
  #   other if a failure occurred
  start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 --pidfile \$PIDFILE --name \$NAME
  RETVAL=\"\$?\"
  [ \"\$RETVAL\" = 2 ] && return 2
  start-stop-daemon --stop --quiet --oknodo --retry=0/30/KILL/5 --exec \$DAEMON
  [ \"\$?\" = 2 ] && return 2
  rm -f \$PIDFILE
  return \"\$RETVAL\"
}

# Function that sends a SIGHUP to the daemon/service
do_reload() {
  start-stop-daemon --stop --signal 1 --quiet --pidfile \$PIDFILE --name \$NAME
  return 0
}

case \"\$1\" in
  start)
    [ \"\$VERBOSE\" != no ] && log_daemon_msg \"Starting \$DESC \" \"\$NAME\"
    do_start
    case \"\$?\" in
    0|1) [ \"\$VERBOSE\" != no ] && log_end_msg 0 ;;
    2) [ \"\$VERBOSE\" != no ] && log_end_msg 1 ;;
  esac
  ;;
  stop)
  [ \"\$VERBOSE\" != no ] && log_daemon_msg \"Stopping \$DESC\" \"\$NAME\"
  do_stop
  case \"\$?\" in
    0|1) [ \"\$VERBOSE\" != no ] && log_end_msg 0 ;;
    2) [ \"\$VERBOSE\" != no ] && log_end_msg 1 ;;
  esac
  ;;
  status)
       status_of_proc \"\$DAEMON\" \"\$NAME\" && exit 0 || exit \$?
       ;;
  reload|force-reload)
      log_daemon_msg \"Reloading \$DESC\" \"\$NAME\"
      do_reload
      log_end_msg \$?
      ;;
  restart)
  log_daemon_msg \"Restarting \$DESC\" \"\$NAME\"
  do_stop
  case \"\$?\" in
    0|1)
    do_start
    case \"\$?\" in
      0) log_end_msg 0 ;;
      1) log_end_msg 1 ;; # Old process is still running
      *) log_end_msg 1 ;; # Failed to start
    esac
    ;;
    *)
      # Failed to stop
    log_end_msg 1
    ;;
  esac
  ;;
  *)
    echo \"Usage: \$SCRIPTNAME {start|stop|status|restart|force-reload}\" >&2
    exit 3
  ;;
esac

:

" > $FBTUNVERSION$under$VERSION/debian/facebook-tunnel.init
echo " 
" > $FBTUNVERSION$under$VERSION/debian/facebook-tunnel.preinst
echo " 
" > $FBTUNVERSION$under$VERSION/debian/facebook-tunnel.install
echo " 
" > $FBTUNVERSION$under$VERSION/debian/facebook-tunnel.links
echo " FBTUNHOME='/var/lib/fbtun'
FBTUNUSER='fbtun'
" > $FBTUNVERSION$under$VERSION/debian/facebook-tunnel.postinst
echo " 
" > $FBTUNVERSION$under$VERSION/debian/facebook-tunnel.postrm
cp $FBTUNVERSION$under$VERSION/COPYING $FBTUNVERSION$under$VERSION/debian/copyright
echo "" > $FBTUNVERSION.postinst