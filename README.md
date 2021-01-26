# Docker noVNC graphic applications launch

This repository provides a minimal debian base docker container with noVNC and i3 clients.  

## Image Contents

* [noNVC](https://kanaka.github.io/noVNC/) - A HTML5 canvas vnc viewer
* [supervisord](http://supervisord.org) - to keep it all running
* [Xvfb](http://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml) - X11 in a virtual framebuffer
* [x11vnc](http://www.karlrunge.com/x11vnc/) - A VNC server that scrapes the above X11 server
* [i3](https://i3wm.org/) - dynamic tiling window manager
* [xterm](http://invisible-island.net/xterm/) - as a demo and to interact

## Usage

### Variables

You can specify the following variables:
* `DISPLAY_WIDTH=<width>` (1920)
* `DISPLAY_HEIGHT=<height>` (1080)

### Run stand-alone

You can run this image as follows and through xterm inside the container you can install and run any application.  

```bash
$ docker run -it --rm -p 8080:8080 issogr/novnc
```

### Run with your apps

Per non dover installare manualmente i programmi ad ogni avvio con xterm, consiglio questa personalizzazione.  

Create your Dockerfile as below and build it.  
To add a program, just install it and add the required lines in the supervisord.conf file.

```Dockerfile
FROM issogr/novnc
RUN \
    # Install gedit
    apt-get --no-install-recommends -y install gedit && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    # Append gedit entry to supervisord.conf
    cd /etc/supervisor/conf.d && \
    echo '[program:gedit]' >> supervisord.conf && \
    echo 'command=gedit' >> supervisord.conf && \
    echo 'autorestart=true' >> supervisord.conf
```

Build and run the custom image.

## Have Fun

Open the browser http://localhost:8080/vnc.html.  
Click 'Connect'.
