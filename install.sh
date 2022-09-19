#!/bin/sh

# if [ $(id -u) != 0 ]; then exit; fi;

dir=$(dirname $(realpath $0))

printf "! this process will delete entire of your disk.\n"

read -p "are you sure (y/n) : " confirm

if [ "$confirm" != "y" ]; then
	printf "abort.\n"
	exit 1
fi

printf "here we go...!"

exit

parted -s /dev/sda -- mklabel gpt
parted -a optimal /dev/sda -- mkpart fat32 0% 512M
parted -a optimal /dev/sda -- mkpart ext4 512M 100%
parted -s /dev/sda -- set 1 esp on
parted -s /dev/sda -- name 1 efi
parted -s /dev/sda -- name 2 primary

mkfs.fat -F 32 /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt
mount /dev/sda1 /mnt/boot --mkdir

genfstab -U /mnt > /mnt/etc/fstab

printf "all done.\n"
