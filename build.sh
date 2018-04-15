#!/bin/bash
#
# Copyright (C) 2017 Ashish Malik (im.ashish994@gmail.com)
# Copyright (C) 2018 Rahif M (faizel326@gmail.com)
# Copyright (C) 2018 Yudi Widiyanto (yudiwidiyanto7@gmail.com)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

#colors
red='\033[0;31m'
green='\033[0;32m'
brown='\033[0;33m'
blue='\033[0;34m'
purple='\033[1;35m'
cyan='\033[0;36m'
nc='\033[0m'

#directories
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/out/arch/arm64/boot/Image.gz
DTB1=$KERNEL_DIR/out/arch/arm64/boot/dts/qcom/msm8953-qrd-sku3-mido-nt.dtb
DTB2=$KERNEL_DIR/out/arch/arm64/boot/dts/qcom/msm8953-qrd-sku3-mido.dtb
ZIP_DIR=$KERNEL_DIR/AnyKernel2
CONFIG_DIR=$KERNEL_DIR/arch/arm64/configs

#export
export KBUILD_BUILD_USER="Cangkuls"
export KBUILD_BUILD_HOST="ZeroProjectX"
export CROSS_COMPILE="$(command -v ccache) /root/aarch64-linux-android-4.9/bin/aarch64-linux-android-"
export ARCH=arm64
export SUBARCH=arm64

#misc
CONFIG=inferno_defconfig
THREAD="-j$(grep -c ^processor /proc/cpuinfo)"

#main script
while true; do
echo -e "\n$green[1]Build kernel"
echo -e "[2]Regenerate defconfig"
echo -e "[3]Source cleanup"
echo -e "[4]Generate flashable zip"
echo -e "[5]Quit$nc"
echo -ne "\n$blue(i)Please enter a choice[1-5]:$nc "

read choice

if [ "$choice" == "1" ]; then
  BUILD_START=$(date +"%s")
  DATE=`date`
  echo -e "\n$cyan#######################################################################$nc"
  echo -e "$brown(i)Build started at $DATE$nc"
  make $CONFIG $THREAD O=out/
  make $THREAD O=out/
  spin[0]="$blue-"
  spin[1]="\\"
  spin[2]="|"
  spin[3]="/$nc"

  echo -ne "$blue[...] ${spin[0]}$nc"
  while kill -0 $pid &>/dev/null
  do
    for i in "${spin[@]}"
    do
          echo -ne "\b$i"
          sleep 0.1
    done
  done
  if ! [ -a $KERN_IMG ]; then
    echo -e "\n$red(!)Kernel compilation failed.$nc"
    echo -e "$red#######################################################################$nc"
    exit 1
  fi
  BUILD_END=$(date +"%s")
  DIFF=$(($BUILD_END - $BUILD_START))
  echo -e "\n$brown(i)Kernel compiled successfully.$nc"
  echo -e "$cyan#######################################################################$nc"
  echo -e "$purple(i)Total time elapsed: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nc"
  echo -e "$cyan#######################################################################$nc"
fi


if [ "$choice" == "2" ]; then
  echo -e "\n$cyan#######################################################################$nc"
  make $CONFIG
  cp .config arch/arm64/configs/$CONFIG
  echo -e "$purple(i)Defconfig generated.$nc"
  echo -e "$cyan#######################################################################$nc"
fi


if [ "$choice" == "3" ]; then
  echo -e "\n$cyan#######################################################################$nc"
  rm -f $KERN_IMG
  rm -f $ZIP_DIR/anykernel/Image.gz
  rm -f $ZIP_DIR/anykernel/treble-unsupported/*.dtb
  rm -f $ZIP_DIR/anykernel/treble-supported/*.dtb
  rm -f $ZIP_DIR/anykernel/*.zip*
  make clean
  make mrproper
  make clean O=out/
  make mrproper O=out/
  echo -e "$purple(i)Kernel source cleaned up.$nc"
  echo -e "$cyan#######################################################################$nc"
fi


if [ "$choice" == "4" ]; then
  echo -e "\n$cyan#######################################################################$nc"
  cd $ZIP_DIR
  make clean &>/dev/null
  cp $KERN_IMG $ZIP_DIR/anykernel
  cp $DTB1 $ZIP_DIR/anykernel/treble-unsupported/msm8953-qrd-sku3-mido.dtb
  cp $DTB2 $ZIP_DIR/anykernel/treble-supported
  make &>/dev/null
  cd ..
  echo -e "$purple(i)Flashable zip generated under $ZIP_DIR.$nc"
  echo -e "$cyan#######################################################################$nc"
fi


if [ "$choice" == "5" ]; then
 exit 1
fi
done
