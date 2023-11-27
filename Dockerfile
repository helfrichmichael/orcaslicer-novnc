# Get and install Easy noVNC.
FROM golang:bullseye AS easy-novnc-build
WORKDIR /src
RUN go mod init build && \
    go get github.com/geek1011/easy-novnc@v1.1.0 && \
    go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

# Get TigerVNC and Supervisor for isolating the container.
FROM debian:bullseye
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openbox tigervnc-standalone-server supervisor gosu && \
    rm -rf /var/lib/apt/lists && \
    mkdir -p /usr/share/desktop-directories

# Get all of the remaining dependencies for the OS and VNC.
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends lxterminal nano wget openssh-client rsync ca-certificates xdg-utils htop tar xzip gzip bzip2 zip unzip && \
    rm -rf /var/lib/apt/lists/*

# Install cc-vnc dependencies
RUN apt update && apt install -y --no-install-recommends --allow-unauthenticated \

# Clean up
RUN apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Install cc-vnc

# Add installation steps for cc-vnc here

# Copy noVNC and TigerVNC from the build stage.
COPY --from=easy-novnc-build /bin/easy-novnc /bin/easy-novnc

# Bind volumes for configuration and data.
VOLUME /etc/supervisor/conf.d
VOLUME /etc/xdg/openbox

# Expose the noVNC port.
EXPOSE 8080

CMD ["bash", "-c", "cc-vnc"]
