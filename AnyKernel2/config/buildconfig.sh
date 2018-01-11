#!/sbin/sh
echo "" >> /system/etc/init.qcom.post_boot.sh

echo " # default freq min/max, gov and i/o sched" >> /system/etc/init.qcom.post_boot.sh
echo " echo 652800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> /system/etc/init.qcom.post_boot.sh
echo " echo 2016000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> /system/etc/init.qcom.post_boot.sh
echo " echo \"interactive\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /system/etc/init.qcom.post_boot.sh
echo " echo sio > /sys/block/mmcblk0/queue/scheduler" >> /system/etc/init.qcom.post_boot.sh

echo "" >> /system/etc/init.qcom.post_boot.sh

echo " # gpu" >> /system/etc/init.qcom.post_boot.sh
echo " echo 133000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq" >> /system/etc/init.qcom.post_boot.sh
echo " echo 650000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq" >> /system/etc/init.qcom.post_boot.sh
echo " echo 650000000 > /sys/class/kgsl/kgsl-3d0/max_gpuclk" >> /system/etc/init.qcom.post_boot.sh

echo "" >> /system/etc/init.qcom.post_boot.sh

echo " # This Command For Enable Zram Actived" >> /system/etc/init.qcom.post_boot.sh
echo " swapoff /dev/block/zram0" >> /system/etc/init.qcom.post_boot.sh
echo " echo 1 > /sys/block/zram0/reset" >> /system/etc/init.qcom.post_boot.sh
echo " echo 1073741824 > /sys/block/zram0/disksize" >> /system/etc/init.qcom.post_boot.sh
echo " mkswap /dev/block/zram0" >> /system/etc/init.qcom.post_boot.sh
echo " swapon /dev/block/zram0" >> /system/etc/init.qcom.post_boot.sh

echo "" >> /system/etc/init.qcom.post_boot.sh

