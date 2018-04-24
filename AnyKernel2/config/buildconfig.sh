#!/sbin/sh
echo "" >> /tmp/init.inferno.sh

echo "#!/system/bin/sh" >> /tmp/init.inferno.sh

echo " # default freq min/max, gov and i/o sched" >> /tmp/init.inferno.sh
echo " echo 652800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> /tmp/init.inferno.sh
echo " echo 1958400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> /tmp/init.inferno.sh
echo " echo \"interactive\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /tmp/init.inferno.sh
echo " echo cfq > /sys/block/mmcblk0/queue/scheduler" >> /tmp/init.inferno.sh

echo "" >> /tmp/init.inferno.sh

echo " # gpu" >> /tmp/init.inferno.sh
echo " echo 133000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq" >> /tmp/init.inferno.sh
echo " echo 650000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq" >> /tmp/init.inferno.sh
echo " echo 650000000 > /sys/class/kgsl/kgsl-3d0/max_gpuclk" >> /tmp/init.inferno.sh

echo "" >> /tmp/init.inferno.sh
