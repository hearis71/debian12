#!/bin/sh
set -e

export DISPLAY=:0
export HOME=/root

mkdir -p /root/.icewm

if [ ! -f /root/.icewm/preferences ]; then
cat <<EOF > /root/.icewm/preferences
ShowTaskBar=1
ShowClock=1
EOF
fi

Xvfb :0 -screen 0 1280x800x24 &
sleep 2

dbus-launch icewm-session &

x11vnc \
  -display :0 \
  -localhost \
  -nopw \
  -forever \
  -shared \
  -rfbport 5900 &

/opt/novnc/utils/novnc_proxy \
  --vnc localhost:5900 \
  --listen 0.0.0.0:6080
