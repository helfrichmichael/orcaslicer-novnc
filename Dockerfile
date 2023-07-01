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

# # Get all of the remaining dependencies for the OS and VNC.
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends lxterminal nano wget openssh-client rsync ca-certificates xdg-utils htop tar xzip gzip bzip2 zip unzip && \
    rm -rf /var/lib/apt/lists

RUN apt update && apt install -y --no-install-recommends --allow-unauthenticated \
        lxde gtk2-engines-murrine gnome-themes-standard gtk2-engines-pixbuf gtk2-engines-murrine arc-theme libwebkit2gtk-4.0-37 \
        freeglut3 libgtk2.0-dev libwxgtk3.0-gtk3-dev libwx-perl libxmu-dev libgl1-mesa-glx libgl1-mesa-dri \
        xdg-utils locales pcmanfm libgtk-3-dev libglew-dev libudev-dev libdbus-1-dev zlib1g-dev locales locales-all \
        libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base \
        gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools \
        gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio \
        jq curl git firefox-esr \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Install OrcaSlicer and its dependencies.
# Many of the commands below were derived and pulled from previous work by dmagyar on GitHub.
# Here's their Dockerfile for reference https://github.com/dmagyar/prusaslicer-vnc-docker/blob/main/Dockerfile.amd64
WORKDIR /orcaslicer
ADD get_release_info.sh /orcaslicer

RUN mkdir -p /orcaslicer/orcaslicer-dist
RUN chmod +x /orcaslicer/get_release_info.sh

# Retrieve and unzip all of the OrcaSlicer bits using variable.
RUN latestOrcaslicer=$(/orcaslicer/get_release_info.sh url) \
&& echo ${latestOrcaslicer} \
&& orcaslicerReleaseName=$(/orcaslicer/get_release_info.sh name) \
&& curl -sSL ${latestOrcaslicer} > ${orcaslicerReleaseName} \
&& rm -f /orcaslicer/releaseInfo.json \
&& mkdir -p /orcaslicer/orcaslicer-dist \
&& unzip ${orcaslicerReleaseName} -d /orcaslicer/orcaslicer-dist \
&& chmod 775 /orcaslicer/orcaslicer-dist/OrcaSlicer_ubu64.AppImage \
&& /orcaslicer/orcaslicer-dist/OrcaSlicer_ubu64.AppImage --appimage-extract \
&& rm -f /orcaslicer/${orcaslicerReleaseName}

RUN rm -rf /var/lib/apt/lists/*
RUN apt-get autoclean 
RUN chmod -R 777 /orcaslicer/
RUN groupadd orcaslicer
RUN useradd -g orcaslicer --create-home --home-dir /home/orcaslicer orcaslicer
RUN mkdir -p /orcaslicer
RUN mkdir -p /configs 
RUN mkdir -p /prints/ 
RUN chown -R orcaslicer:orcaslicer /orcaslicer/ /home/orcaslicer/ /prints/ /configs/ 
RUN locale-gen en_US 
RUN mkdir /configs/.local 
RUN mkdir -p /configs/.config/ 
RUN ln -s /configs/.config/ /home/orcaslicer/
RUN mkdir -p /home/orcaslicer/.config/
RUN mkdir -p /home/orcaslicer/.config/OrcaSlicer/
# We can now set the Download directory for Firefox and other browsers. 
# We can also add /prints/ to the file explorer bookmarks for easy access.
RUN echo "XDG_DOWNLOAD_DIR=\"/prints/\"" >> /home/orcaslicer/.config/user-dirs.dirs 
RUN echo "file:///prints prints" >> /home/orcaslicer/.gtk-bookmarks 

COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY menu.xml /etc/xdg/openbox/

COPY supervisord.conf /etc/
EXPOSE 8080

VOLUME /configs/
VOLUME /prints/

# It's time! Let's get to work! We use /configs/ as a bindable volume for OrcaSlicers configurations.  We use /prints/ to provide a location for STLs and GCODE files.
CMD ["bash", "-c", "chown -R orcaslicer:orcaslicer /configs/ /home/orcaslicer/ /prints/ /dev/stdout && exec gosu orcaslicer supervisord"]