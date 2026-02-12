#!/bin/sh
set -e

export DISPLAY=:0
export HOME=/root

Xvfb :0 -screen 0 1280x800x24 &
sleep 2

dbus-launch jwm &

sleep 1

firefox-esr --no-remote --new-instance about:blank &

x11vnc \
  -display :0 \
  -localhost \
  -nopw \
  -forever \
  -shared \
  -rfbport 5900 &

exec /opt/novnc/utils/novnc_proxy \
  --vnc localhost:5900 \
  --listen 0.0.0.0:6080
