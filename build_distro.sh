#!/bin/sh
#
# build_3Z_NIX script
#
# 
#
#
# 3Z-NIX -- build folder
# preparation  -- preparation files
#
#
# Step 1: -Variables are awesome
#
WKDIR="$(pwd)"
#
#
# Step 2: - cd to the build staging folder
#
#

mkdir -p $WKDIR/3Z-NIX

cd 3Z-NIX
#
#
# step 3: - Set up build environment
#
lb config --binary-images iso-hybrid --mode debian --architectures amd64 --linux-flavours amd64 --distribution stretch --archive-areas "main contrib non-free" --updates true --security true --cache true --apt-recommends true --debian-installer live --debian-installer-gui false --win32-loader false --iso-application 3Z-NIXOS --iso-preparer 3Z-NIX --iso-publisher 3Z-NIX --iso-volume 3Z-NIX
#
#
#
# Step 4: packages

echo task-xfce-desktop > $WKDIR/3Z-NIX/config/package-lists/desktop.list.chroot
#
#
echo haveged less gdebi galculator grsync psensor net-tools arping nmap wireshark gparted flac faad faac mjpegtools x265 x264 ffmpeg sox mencoder dvdauthor twolame lame asunder geany filezilla vlc cdrdao htop jfsutils xfsprogs ntfs-3g mtools gthumb testdisk partimage numix-gtk-theme xorriso p7zip-full p7zip-rar hardinfo inxi gnome-disk-utility firefox-esr thunderbird arc-theme gstreamer1.0-plugins-bad lightdm-gtk-greeter-settings gnome-system-tools dos2unix dialog faenza-icon-theme liferea python-glade2 rar unrar ssh cifs-utils gvfs-backends gvfs-bin pciutils squashfs-tools syslinux syslinux-common dosfstools isolinux live-build fakeroot linux-headers-amd64 lsb-release menu gksu build-essential dkms curl wget apt-transport-https dirmngr openvpn network-manager-openvpn openvpn-systemd-resolved libqt5opengl5 > $WKDIR/3Z-NIX/config/package-lists/packages.list.chroot
#
#
# Phase 5: - Copy files into chroot
#
#
mkdir -p $WKDIR/3Z-NIX/config/includes.chroot/usr/share/3Z-NIX
#
cp -r $WKDIR/preparation $WKDIR/3Z-NIX/config/includes.chroot/usr/share/3Z-NIX/preparation
#
#
cp -r $WKDIR/preparation/bootloaders $WKDIR/3Z-NIX/config/bootloaders
#
#
cp $WKDIR/preparation/misc64/* $WKDIR/3Z-NIX/config/packages.chroot/
#
#
mkdir -p $WKDIR/3Z-NIX/config/hooks/normal
#
cp $WKDIR/preparation/hooks/* $WKDIR/3Z-NIX/config/hooks/normal/
#
#
#
#
mkdir -p $WKDIR/3Z-NIX/config/includes.chroot/etc/skel/.config
#
cp -r $WKDIR/preparation/xfce4 $WKDIR/3Z-NIX/config/includes.chroot/etc/skel/.config/xfce4
#
#
mkdir -p $WKDIR/3Z-NIX/config/includes.chroot/usr/share/images/desktop-base
#
cp $WKDIR/preparation/backgrounds/* $WKDIR/3Z-NIX/config/includes.chroot/usr/share/images/desktop-base/
#
#
mkdir -p $WKDIR/3Z-NIX/config/includes.chroot/usr/share/icons/default
#
#cp $WKDIR/preparation/icons/* $WKDIR/3Z-NIX/config/includes.chroot/usr/share/icons/default/
#
#
#mkdir -p $WKDIR/3Z-NIX/config/includes.chroot/usr/local/bin
#
#cp $WKDIR/preparation/scripts/* $WKDIR/3Z-NIX/config/includes.chroot/usr/local/bin/
#
#
#
#
#
mkdir -p $WKDIR/3Z-NIX/config/includes.chroot/etc/skel/Desktop
#
#ln -s /usr/share/doc/3Z-NIX $WKDIR/3Z-NIX/config/includes.chroot/etc/skel/Desktop/
#
#
# Phase 6: - Start the build process
#
lb build
