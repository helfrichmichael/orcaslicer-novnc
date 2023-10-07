#!/bin/bash

TMPDIR="$(mktemp -d)"

curl -SsL https://api.github.com/repos/SoftFever/OrcaSlicer/releases/latest > $TMPDIR/latest.json

url=$(jq -r '.assets[] | select(.browser_download_url|test("_Linux.*.AppImage$"))| .browser_download_url' $TMPDIR/latest.json)
name=$(jq -r '.assets[] | select(.browser_download_url|test("_Linux.*.AppImage$"))| .name' $TMPDIR/latest.json)
version=$(jq -r .tag_name $TMPDIR/latest.json)

if [ $# -ne 1 ]; then
  echo "Wrong number of params"
  exit 1
else
  request=$1
fi

case $request in

  url)
    echo $url
    ;;

  name)
    echo $name
    ;;

  version)
    echo $version
    ;;

  *)
    echo "Unknown request"
    ;;
esac

exit 0
