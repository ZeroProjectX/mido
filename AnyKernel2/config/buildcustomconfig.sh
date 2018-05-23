#!/sbin/sh

echo "  # min freq" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
cpu0=`grep selected.1 /tmp/aroma/cpu0.prop | cut -d '=' -f2`
if [ $cpu0 = 1 ]; then
echo "  echo 652800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $cpu0 = 2 ]; then
echo "  echo 1036800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
else
echo "  echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
fi

echo "" >> /tmp/anykernel/patch/init.qcom.post_boot.sh

echo "  # max freq" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
cpu0=`grep selected.2 /tmp/aroma/cpu0.prop | cut -d '=' -f2`
if [ $cpu0 = 1 ]; then
echo "  echo 2016000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $cpu0 = 2 ]; then
echo "  echo 1958400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $cpu0 = 3 ]; then
echo "  echo 1804800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
else
echo "  echo 1689600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
fi

echo "" >> /tmp/anykernel/patch/init.qcom.post_boot.sh

echo "  # set cpu governor" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
gov=`grep selected.0 /tmp/aroma/gov.prop | cut -d '=' -f2`
if [ $gov = 1 ]; then
echo "  echo \"conservative\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $gov = 2 ]; then
echo "  echo \"impulse\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $gov = 3 ]; then
echo "  echo \"interactive\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $gov = 4 ]; then
echo "  echo \"lionfish\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $gov = 5 ]; then
echo "  echo \"ondemand\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $gov = 6 ]; then
echo "  echo \"performance\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $gov = 7 ]; then
echo "  echo \"powersave\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
else
echo "  echo \"userspace\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
fi

echo "" >> /tmp/anykernel/patch/init.qcom.post_boot.sh

echo "  # set io scheduler" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
SCHED=`grep selected.1 /tmp/aroma/sched.prop | cut -d '=' -f2`
if [ $SCHED = 1 ]; then
echo "  echo bfq > /sys/block/mmcblk0/queue/scheduler" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $SCHED = 2 ]; then
echo "  echo cfq > /sys/block/mmcblk0/queue/scheduler" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $SCHED = 3 ]; then
echo "  echo deadline > /sys/block/mmcblk0/queue/scheduler" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $SCHED = 4 ]; then
echo "  echo fiops > /sys/block/mmcblk0/queue/scheduler" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $SCHED = 5 ]; then
echo "  echo maple > /sys/block/mmcblk0/queue/scheduler" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $SCHED = 6 ]; then
echo "  echo noop > /sys/block/mmcblk0/queue/scheduler" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $SCHED = 7 ]; then
echo "  echo sio > /sys/block/mmcblk0/queue/scheduler" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $SCHED = 8 ]; then
echo "  echo sioplus > /sys/block/mmcblk0/queue/scheduler" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
else
echo "  echo zen > /sys/block/mmcblk0/queue/scheduler" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
fi

echo "  # read ahead tune up" >> /tmp/anykernel/patch/init.qcom.post_boot.sh

SCHED=`grep selected.2 /tmp/aroma/sched.prop | cut -d '=' -f2`
if [ $SCHED = 1 ]; then
echo "  echo 128 > /sys/block/sda/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 128 > /sys/block/sda/queue/nr_requests" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 128 > /sys/block/dm-0/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 128 > /sys/block/dm-1/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $SCHED = 2 ]; then
echo "  echo 256 > /sys/block/sda/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 256 > /sys/block/sda/queue/nr_requests" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 256 > /sys/block/dm-0/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 256 > /sys/block/dm-1/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $SCHED = 3 ]; then
echo "  echo 512 > /sys/block/sda/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 512 > /sys/block/sda/queue/nr_requests" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 512 > /sys/block/dm-0/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 512 > /sys/block/dm-1/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $SCHED = 4 ]; then
echo "  echo 768 > /sys/block/sda/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 768 > /sys/block/sda/queue/nr_requests" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 768 > /sys/block/dm-0/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 768 > /sys/block/dm-1/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
else
echo "  echo 1024 > /sys/block/sda/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 1024 > /sys/block/sda/queue/nr_requests" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 1024 > /sys/block/dm-0/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 1024 > /sys/block/dm-1/queue/read_ahead_kb" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
fi

echo "" >> /tmp/anykernel/patch/init.qcom.post_boot.sh

echo "  # KCAL " >> /tmp/anykernel/patch/init.qcom.post_boot.sh
misc=`grep selected.1 /tmp/aroma/misc.prop | cut -d '=' -f2`
if [ $misc = 2 ]; then
echo "  echo 217 215 255 > /sys/devices/platform/kcal_ctrl.0/kcal" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 265 > /sys/devices/platform/kcal_ctrl.0/kcal_sat" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 253 > /sys/devices/platform/kcal_ctrl.0/kcal_val" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 250 > /sys/devices/platform/kcal_ctrl.0/kcal_cont" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 0 > /sys/devices/platform/kcal_ctrl.0/kcal_hue" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $misc = 3 ]; then
echo "  echo 223 223 255 > /sys/devices/platform/kcal_ctrl.0/kcal" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 271 > /sys/devices/platform/kcal_ctrl.0/kcal_sat" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 255 > /sys/devices/platform/kcal_ctrl.0/kcal_val" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 255 > /sys/devices/platform/kcal_ctrl.0/kcal_cont" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 0 > /sys/devices/platform/kcal_ctrl.0/kcal_hue" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $misc = 4 ]; then
echo "  echo 232 237 256 > /sys/devices/platform/kcal_ctrl.0/kcal" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 300 > /sys/devices/platform/kcal_ctrl.0/kcal_sat" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 255 > /sys/devices/platform/kcal_ctrl.0/kcal_val" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 255 > /sys/devices/platform/kcal_ctrl.0/kcal_cont" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 0 > /sys/devices/platform/kcal_ctrl.0/kcal_hue" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $misc = 5 ]; then
echo "  echo 230 232 255 > /sys/devices/platform/kcal_ctrl.0/kcal" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 274 > /sys/devices/platform/kcal_ctrl.0/kcal_sat" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 247 > /sys/devices/platform/kcal_ctrl.0/kcal_val" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 268 > /sys/devices/platform/kcal_ctrl.0/kcal_cont" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 0 > /sys/devices/platform/kcal_ctrl.0/kcal_hue" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $misc = 6 ]; then
echo "  echo 232 228 255 > /sys/devices/platform/kcal_ctrl.0/kcal" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 251 > /sys/devices/platform/kcal_ctrl.0/kcal_sat" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 254 > /sys/devices/platform/kcal_ctrl.0/kcal_val" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 256 > /sys/devices/platform/kcal_ctrl.0/kcal_cont" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 1515 > /sys/devices/platform/kcal_ctrl.0/kcal_hue" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $misc = 7 ]; then
echo " # Check panel_name" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " panel_model = \`cat /sys/class/graphics/fb0/msm_fb_panel_info | grep panel_name\`" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " default_color = \`getprop vendor.display.enable_default_color_mode\`" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " if [ \"$"panel_model"\" == \"panel_name=nt35596 tianma fhd video mode dsi panel\" ]; then" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " 	if [ \"$"default_color"\" == \"1\"]; then" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " 		setprop vendor.display.enable_default_color_mode 0" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " 	fi" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " 		echo 237 237 237 > /sys/devices/platform/kcal_ctrl.0/kcal" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " 		echo 258 > /sys/devices/platform/kcal_ctrl.0/kcal_sat" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo " fi" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
else
echo "  echo 256 256 256 > /sys/devices/platform/kcal_ctrl.0/kcal" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 255 > /sys/devices/platform/kcal_ctrl.0/kcal_sat" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
fi

echo "" >> /tmp/anykernel/patch/init.qcom.post_boot.sh

echo "  # set vibrator intensity" >> /tmp/anykernel/patch/init.qcom.post_boot.sh

misc=`grep selected.2 /tmp/aroma/misc.prop | cut -d '=' -f2`
if [ $misc = 1 ]; then
echo "  echo 1322 > /sys/class/timed_output/vibrator/vtg_level" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $misc = 2 ]; then
echo "  echo 1908 > /sys/class/timed_output/vibrator/vtg_level" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
else
echo "  echo 3045 > /sys/class/timed_output/vibrator/vtg_level" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
fi

echo "" >> /tmp/anykernel/patch/init.qcom.post_boot.sh

echo "  # This Command For Enable Zram Actived" >> /tmp/anykernel/patch/init.qcom.post_boot.sh

misc=`grep selected.3 /tmp/aroma/misc.prop | cut -d '=' -f2`
if [ $misc = 1 ]; then
echo "  swapoff /dev/block/zram0" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $misc = 2 ]; then
echo "  swapoff /dev/block/zram0" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 1 > /sys/block/zram0/reset" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 824180736 > /sys/block/zram0/disksize" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  mkswap /dev/block/zram0" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  swapon /dev/block/zram0" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $misc = 3 ]; then
echo "  swapoff /dev/block/zram0" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 1 > /sys/block/zram0/reset" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 1073741824 > /sys/block/zram0/disksize" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  mkswap /dev/block/zram0" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  swapon /dev/block/zram0" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
elif [ $misc = 4 ]; then
echo "  swapoff /dev/block/zram0" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 1 > /sys/block/zram0/reset" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 1610612736 > /sys/block/zram0/disksize" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  mkswap /dev/block/zram0" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  swapon /dev/block/zram0" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
else
echo "  swapoff /dev/block/zram0" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 1 > /sys/block/zram0/reset" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  echo 2147483648 > /sys/block/zram0/disksize" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  mkswap /dev/block/zram0" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
echo "  swapon /dev/block/zram0" >> /tmp/anykernel/patch/init.qcom.post_boot.sh
fi

