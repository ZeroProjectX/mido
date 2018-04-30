# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=Zero ProjectX
do.devicecheck=0
do.modules=1
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

#add init script
insert_line init.rc "init.zpx.rc" before "import /init.usb.rc" "import /init.zpx.rc";
cp /tmp/init.inferno.sh /tmp/anykernel/ramdisk/init.inferno.sh
chmod 0750 /tmp/anykernel/ramdisk/init.inferno.sh

# end ramdisk changes

write_boot;

## end install

