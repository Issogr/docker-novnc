FROM debian:buster-slim

COPY . /app

RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get --no-install-recommends -y install i3 \
  supervisor \
  xvfb \
  x11vnc \
  xterm \
  novnc && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV HOME=/root \
  DEBIAN_FRONTEND=noninteractive \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US.UTF-8 \
  LC_ALL=C.UTF-8 \
  DISPLAY=:0.0 \
  DISPLAY_WIDTH=1920 \
  DISPLAY_HEIGHT=1080

CMD ["/app/entrypoint.sh"]
EXPOSE 8080