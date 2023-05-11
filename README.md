# OrcaSlicer noVNC Docker Container

## Overview

This is a super basic noVNC build using supervisor to serve OrcaSlicer in your favorite web browser. This was primarily built for users using the [popular unraid NAS software](https://unraid.net), to allow them to quickly hop in a browser, slice, and upload their favorite 3D prints.

A lot of this was branched off of dmagyar's awesome [prusaslicer-vnc-docker](https://hub.docker.com/r/dmagyar/prusaslicer-vnc-docker/) project, but I found it to be a bit complex for my needs and thought this approach would simplify things a lot.

## How to use

**In unraid**

If you're using unraid, open your Docker page and under `Template repositories`, add `https://github.com/helfrichmichael/unraid-templates` and save it. You should then be able to Add Container for orcaslicer-novnc. For unraid, the template will default to 6080 for the noVNC web instance.

**Outside of unraid**

To run this image, you can run the following command: `docker run --detach --volume=orcaslicer-novnc-data:/configs/ --volume=orcaslicer-novnc-prints:/prints/ -p 8080:8080 -e SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt" 
--name=orcaslicer-novnc orcaslicer-novnc`

This will bind `/configs/` in the container to a local volume on my machine named `orcaslicer-novnc-data`. Additionally it will bind `/prints/` in the container to `orcaslicer-novnc-prints` locally on my machine, it will bind port `8080` to `8080`, and finally, it will provide an environment variable to keep OrcaSlicer happy by providing an `SSL_CERT_FILE`.

## Links

[OrcaSlicer](https://github.com/SoftFever/OrcaSlicer)

[Supervisor](http://supervisord.org/)

[GitHub Source](https://github.com/helfrichmichael/orcaslicer-novnc)

[Docker](https://hub.docker.com/r/mikeah/orcaslicer-novnc)

<a href="https://www.buymeacoffee.com/helfrichmichael" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
