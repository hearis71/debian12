FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:0 \
    LANG=C.UTF-8 \
    HOME=/root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        xorg \
        xvfb \
        jwm \
        x11vnc \
        dbus-x11 \
        firefox-esr \
        xterm \
        git \
        ca-certificates \
        fonts-dejavu \
        tini \
        python3 \
        neofetch \
        ranger \
        htop \
        pcmanfm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/novnc/noVNC.git /opt/novnc \
    && git clone https://github.com/novnc/websockify.git /opt/novnc/utils/websockify

COPY startup.sh /startup.sh
# COPY jwmrc /root/.jwmrc

RUN chmod +x /startup.sh

EXPOSE 6080

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/startup.sh"]
