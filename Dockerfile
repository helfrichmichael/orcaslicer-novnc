# Stage 1: Build Easy noVNC
FROM golang:bullseye AS easy-novnc-build

WORKDIR /src

# Install and build Easy noVNC
RUN go mod init build && \
    go get github.com/geek1011/easy-novnc@v1.1.0 && \
    go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

# Install necessary packages
FROM ubuntu
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    openbox tigervnc-standalone-server supervisor gosu \
    lxterminal nano wget openssh-client rsync software-properties-common ca-certificates xdg-utils htop tar xzip gzip bzip2 zip unzip && \
    rm -rf /var/lib/apt/lists && \
    mkdir -p /usr/share/desktop-directories

# Install cc-novnc dependencies
RUN apt update && apt install -y --no-install-recommends --allow-unauthenticated \
    nodejs npm \
    # Dependencies for electron
    libnss3-dev libgdk-pixbuf2.0-dev libgtk-3-dev libxss-dev libasound2

# Clean up
RUN apt autoclean -y && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Copy Easy noVNC binary from the previous stage
COPY --from=easy-novnc-build /bin/easy-novnc /bin/easy-novnc

# Install cc-novnc application and electron
COPY /app /cc-novnc
RUN cd /cc-novnc && \
    npm install && \
    npm install -g electron@latest

# Create directories for volumes
RUN mkdir -p /cc-novnc/save

# Bind volumes for configuration and data
VOLUME /cc-novnc/save

# Create a user
RUN useradd -ms /bin/bash cc-novnc

# Create supervisord log file
RUN touch /supervisord.log && \
    chown cc-novnc:cc-novnc /supervisord.log

# Copy startup script and set permissions
COPY /cc-novnc.sh /cc-novnc/cc-novnc.sh
RUN chmod +x /cc-novnc/cc-novnc.sh

# Copy supervisord configuration
COPY /supervisord.conf /cc-novnc/config/supervisord.conf

# Expose ports
EXPOSE 8080

# Start supervisord with specified configuration
CMD ["bash", "-c", "exec gosu cc-novnc supervisord -c /cc-novnc/config/supervisord.conf"]
