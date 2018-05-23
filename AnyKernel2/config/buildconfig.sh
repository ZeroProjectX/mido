#!/sbin/sh
echo "" >> /tmp/anykernel/patch/init.qcom.post_boot.sh

echo " # default freq min/max, gov and i/o sched" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " echo 652800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " echo 1958400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " echo \"interactive\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " echo cfq > /sys/block/mmcblk0/queue/scheduler" >> /tmp/anykernel/patch/init.qcom.post_boot.sh

echo "" >> /tmp/anykernel/patch/init.qcom.post_boot.sh

echo " # gpu" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " echo 133000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " echo 650000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " echo 650000000 > /sys/class/kgsl/kgsl-3d0/max_gpuclk" >> /tmp/anykernel/patch/init.qcom.post_boot.sh

echo "" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
