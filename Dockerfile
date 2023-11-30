# Get and install Easy noVNC.
FROM golang:bullseye AS easy-novnc-build
WORKDIR /src
RUN go mod init build && \
    go get github.com/geek1011/easy-novnc@v1.1.0 && \
    go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

# Get TigerVNC and Supervisor for isolating the container.
FROM ubuntu
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    openbox tigervnc-standalone-server supervisor gosu \
    lxterminal nano wget openssh-client rsync software-properties-common ca-certificates xdg-utils htop tar xzip gzip bzip2 zip unzip && \
    rm -rf /var/lib/apt/lists && \
    mkdir -p /usr/share/desktop-directories

# Install cc-novnc dependencies
RUN apt update && apt install -y --no-install-recommends --allow-unauthenticated \
    nodejs npm

# Clean up
RUN apt autoclean -y && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Install cc-novnc
COPY /app /app
RUN cd /app && npm install && npm run build
RUN mkdir -p /cc-novnc && cp -r /app/dist/* /cc-novnc
COPY --from=easy-novnc-build /bin/easy-novnc /bin/easy-novnc

# Make directories for volumes
RUN mkdir -p /etc/supervisor/conf.d /etc/xdg/openbox /cc-novnc/save

# Bind volumes for configuration and data
VOLUME /etc/supervisor/
VOLUME /etc/xdg/openbox
VOLUME /cc-novnc/save

# Expose the noVNC port
EXPOSE 8080

# Modified code for cc-novnc
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    fuse libfuse2 libnss3

RUN apt-get install libasound2 libgbm-dev -y

# Create user
RUN useradd -ms /bin/bash cc-novnc && \
    mkdir -p /home/cc-novnc && \
    chown -R cc-novnc:cc-novnc /home/cc-novnc && \
    mkdir -p /var/log/supervisor && \
    touch /var/log/supervisor/supervisord.log && \
    chown -R cc-novnc:cc-novnc /var/log/supervisor

RUN chown -R cc-novnc:cc-novnc /cc-novnc
RUN chown -R cc-novnc:cc-novnc /etc/supervisor/conf.d
RUN touch /supervisord.log
RUN chown cc-novnc:cc-novnc /supervisord.log

CMD ["bash", "-c", "chown -R cc-novnc:cc-novnc /cc-novnc/CookieClicker-1.0.0.AppImage && exec gosu cc-novnc supervisord -c /etc/supervisor/supervisord.conf"]
