#!/usr/bin/env bash

set -e

if [ -z "$2" ]; then
    echo "This tool assumes Ventoy is already set up on the USB drives"
    echo "referenced in the arguments"
    echo
    echo "Usage: $0 path/to/image.iso /dev/sdX1 [/dev/sdX1 ...]"
    exit 1
fi

IMAGE_PATH="$1"
IMAGE_FILE=$(basename "$IMAGE_PATH")
DISKS=( ${@:2} )
VENTOY_CONFIG=/tmp/ventoy.json
MOUNT_DIR=/tmp/ventoy-mnt

cat <<EOF > $VENTOY_CONFIG
{
  "control": [
    { "VTOY_DEFAULT_IMAGE": "/$IMAGE_FILE" }
  ]
}
EOF

mkdir -p "$MOUNT_DIR"

for I in ${!DISKS[@]}; do
    DISK=${DISKS[$I]}
    mount $DISK "$MOUNT_DIR"
    cp -v "$IMAGE_PATH" "$MOUNT_DIR"
    mkdir -p "$MOUNT_DIR/ventoy"
    cp -v "$VENTOY_CONFIG" "$MOUNT_DIR/ventoy"
    umount "$MOUNT_DIR"
done

rmdir "$MOUNT_DIR"
