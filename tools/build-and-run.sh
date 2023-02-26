#!/bin/env bash

cd ${MESON_SOURCE_ROOT}

echo -e "===\nScript working directory: $(pwd)\n===\n"
if [ ! -d "build" ]; then
	meson setup build
fi

meson compile -C build
if [ $1 == "iso" ]; then
	echo "Running the ISO via qemu-system-i386"
	qemu-system-i386 -cdrom build/BlobOS.iso
elif [[ $1 == "bin" ]]; then
	echo "Running the .bin via qemu-system-i386"
	qemu-system-i386 -kernel build/BlobOS.bin
else
	echo "You screwed up."
	exit 1
fi