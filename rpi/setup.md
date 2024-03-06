# Setup of Raspberry pi 5 using arch arm (aarch64)

see [this guide](https://kiljan.org/2023/11/24/arch-linux-arm-on-a-raspberry-pi-5-model-b/) for guidance on pi 5 specifics,
follow the [pi 4 guide](https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-4) for the rest, as there is none for pi 5 for now.


Once the sd card is formatted and the file system is set up and the partitions are mounted, download and extract the aarch64 image:
The root partition is mounted on `/mnt/root` and the boot partition on `/mnt/root/boot`.

```shell
export MOUNT_DIR=/mnt/root

wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-aarch64-latest.tar.gz
bsdtar -xpf ArchLinuxARM-rpi-aarch64-latest.tar.gz -C $MOUNT_DIR

# remove u-boot and add rpi headers
rm -rf /mnt/root/boot/*
```

We patch our boot partition with the [linux-rpi kernel](https://archlinuxarm.org/packages/aarch64/linux-rpi).

```shell
wget https://mirror.archlinuxarm.org/aarch64/core/linux-rpi-<version>.pkg.tar.xz
tar xf linux-rpi-<version>.pkg.tar.xz --directory=<tmp-dir>
cp -rf <tmp-dir>/boot/* /mnt/root/boot/
```
Patching is finished, remove the SD card:

```shell
sync && umount -R /mnt/root
```

