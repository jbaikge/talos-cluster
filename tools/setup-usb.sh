#!/usr/bin/env bash

set -e

if [ -z "$2" ]; then
    echo "This tool assumes Ventoy is already set up on the USB drives"
    echo "referenced in the arguments"
    echo
    echo "Usage: $0 path/to/image.iso /dev/sdX [/dev/sdX ...]"
    exit 1
fi

IMAGE_PATH="$1"
IMAGE_FILE=$(basename "$IMAGE_PATH")
DISKS=( ${@:2} )
VENTOY_CONFIG=/tmp/ventoy.json
TALOS_KEY=/tmp/talos-secure-boot.pem
EFI_MOUNT_DIR=/tmp/ventoy-efi
ISO_MOUNT_DIR=/tmp/ventoy-iso

cat <<EOF > $VENTOY_CONFIG
{
  "control": [
    { "VTOY_MENU_TIMEOUT": "10" },
    { "VTOY_DEFAULT_IMAGE": "/$IMAGE_FILE" },
    { "VTOY_SECONDARY_TIMEOUT": "10" }
  ]
}
EOF

if [ ! -f "$TALOS_KEY" ]; then
    curl "https://factory.talos.dev/secureboot/signing-cert.pem" --output "$TALOS_KEY"
fi

mkdir -p "$EFI_MOUNT_DIR" "$ISO_MOUNT_DIR"

for I in ${!DISKS[@]}; do
    DISK=${DISKS[$I]}
    ISO_PART=${DISK}1
    EFI_PART=${DISK}2

    mount $EFI_PART "$EFI_MOUNT_DIR"
    cp -v "$TALOS_KEY" "$EFI_MOUNT_DIR"
    umount "$EFI_MOUNT_DIR"

    mount $ISO_PART "$ISO_MOUNT_DIR"
    cp -v "$IMAGE_PATH" "$ISO_MOUNT_DIR"
    mkdir -p "$ISO_MOUNT_DIR/ventoy"
    cp -v "$VENTOY_CONFIG" "$ISO_MOUNT_DIR/ventoy"
    umount "$ISO_MOUNT_DIR"
done

rmdir "$EFI_MOUNT_DIR" "$ISO_MOUNT_DIR"
