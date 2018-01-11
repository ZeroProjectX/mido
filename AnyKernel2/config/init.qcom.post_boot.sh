#!/system/bin/sh
# Copyright (c) 2012-2013, 2016, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Modified by Yudi Widiyanto (yudiwidiyanto7@gmail.com)
#

  # scheduler settings
  echo 3 > /proc/sys/kernel/sched_window_stats_policy
  echo 3 > /proc/sys/kernel/sched_ravg_hist_size

  # task packing settings
  echo 0 > /sys/devices/system/cpu/cpu0/sched_static_cpu_pwr_cost
  echo 0 > /sys/devices/system/cpu/cpu1/sched_static_cpu_pwr_cost
  echo 0 > /sys/devices/system/cpu/cpu2/sched_static_cpu_pwr_cost
  echo 0 > /sys/devices/system/cpu/cpu3/sched_static_cpu_pwr_cost
  echo 0 > /sys/devices/system/cpu/cpu4/sched_static_cpu_pwr_cost
  echo 0 > /sys/devices/system/cpu/cpu5/sched_static_cpu_pwr_cost
  echo 0 > /sys/devices/system/cpu/cpu6/sched_static_cpu_pwr_cost
  echo 0 > /sys/devices/system/cpu/cpu7/sched_static_cpu_pwr_cost

  # init task load, restrict wakeups to preferred cluster
  echo 15 > /proc/sys/kernel/sched_init_task_load
  # spill load is set to 100% by default in the kernel
  echo 3 > /proc/sys/kernel/sched_spill_nr_run
  # Apply inter-cluster load balancer restrictions
  echo 1 > /proc/sys/kernel/sched_restrict_cluster_spill

  # interactive setting
  echo "19000 1401600:39000" > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
  echo 80 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
  echo 20000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
  echo 1401600 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
  echo 1 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
  echo "85 1401600:80" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
  echo 39000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
  echo 40000 > /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor

  # enable thermal & BCL core_control now
  echo 1 > /sys/module/msm_thermal/core_control/enabled

  # Bring up all cores online
  echo 1 > /sys/devices/system/cpu/cpu1/online
  echo 1 > /sys/devices/system/cpu/cpu2/online
  echo 1 > /sys/devices/system/cpu/cpu3/online
  echo 1 > /sys/devices/system/cpu/cpu4/online
  echo 1 > /sys/devices/system/cpu/cpu5/online
  echo 1 > /sys/devices/system/cpu/cpu6/online
  echo 1 > /sys/devices/system/cpu/cpu7/online

  # Enable low power modes
  echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

  # SMP scheduler
  echo 85 > /proc/sys/kernel/sched_upmigrate
  echo 85 > /proc/sys/kernel/sched_downmigrate
  echo 19 > /proc/sys/kernel/sched_upmigrate_min_nice

  # Enable sched guided freq control
  echo 1 > /sys/devices/system/cpu/cpufreq/interactive/use_sched_load
  echo 1 > /sys/devices/system/cpu/cpufreq/interactive/use_migration_notif
  echo 200000 > /proc/sys/kernel/sched_freq_inc_notify
  echo 200000 > /proc/sys/kernel/sched_freq_dec_notify

  # Post-setup services
  echo 512 > /sys/block/mmcblk0/bdi/read_ahead_kb
  echo 512 > /sys/block/dm-0/queue/read_ahead_kb
  echo 512 > /sys/block/dm-1/queue/read_ahead_kb

  # Set Memory paremeters.
  #
  # Set per_process_reclaim tuning parameters
  # 2GB 64-bit will have aggressive settings when compared to 1GB 32-bit
  # 1GB and less will use vmpressure range 50-70, 2GB will use 10-70
  # 1GB and less will use 512 pages swap size, 2GB will use 1024
  #
  # Set Low memory killer minfree parameters
  # 32 bit all memory configurations will use 15K series
  # 64 bit all memory configurations will use 18K series
  #
  # Set ALMK parameters (usually above the highest minfree values)
  # 32 bit will have 53K & 64 bit will have 81K
  #

  arch_type=`uname -m`
  MemTotalStr=`cat /proc/meminfo | grep MemTotal`
  MemTotal=${MemTotalStr:16:8}
  MEMORY_THRESHOLD=1048576
  IsLowMemory=MemTotal<MEMORY_THRESHOLD ? 1 : 0

  # Read adj series and set adj threshold for PPR and ALMK.
  # This is required since adj values change from framework to framework.
  adj_series=`cat /sys/module/lowmemorykiller/parameters/adj`
  adj_1="${adj_series#*,}"
  set_almk_ppr_adj="${adj_1%%,*}"

  # PPR and ALMK should not act on HOME adj and below.
  # Normalized ADJ for HOME is 6. Hence multiply by 6
  # ADJ score represented as INT in LMK params, actual score can be in decimal
  # Hence add 6 considering a worst case of 0.9 conversion to INT (0.9*6).
  set_almk_ppr_adj=$(((set_almk_ppr_adj * 6) + 6))
  echo $set_almk_ppr_adj > /sys/module/lowmemorykiller/parameters/adj_max_shift
  echo $set_almk_ppr_adj > /sys/module/process_reclaim/parameters/min_score_adj

  # VM Tune Up
  echo 1 > /sys/module/process_reclaim/parameters/enable_process_reclaim
  echo 70 > /sys/module/process_reclaim/parameters/pressure_max
  echo 30 > /sys/module/process_reclaim/parameters/swap_opt_eff
  echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
  echo 50 > /sys/module/process_reclaim/parameters/pressure_min
  echo 512 > /sys/module/process_reclaim/parameters/per_swap_size
  echo 81250 > /sys/module/lowmemorykiller/parameters/vmpressure_file_min
  echo '80' > /proc/sys/vm/overcommit_ratio
  echo '400' > /proc/sys/vm/vfs_cache_pressure
  echo '24300' > /proc/sys/vm/extra_free_kbytes
  echo '128' > /proc/sys/kernel/random/read_wakeup_threshold
  echo '256' > /proc/sys/kernel/random/write_wakeup_threshold
  echo '0' > /sys/block/mmcblk0/queue/iostats
  echo '1' > /sys/block/mmcblk0/queue/add_random
  echo '0' > /sys/block/mmcblk1/queue/iostats
  echo '1' > /sys/block/mmcblk1/queue/add_random
  echo '4096' > /proc/sys/vm/min_free_kbytes
  echo '0' > /proc/sys/vm/oom_kill_allocating_task
  echo '90' > /proc/sys/vm/dirty_ratio
  echo '70' > /proc/sys/vm/dirty_background_ratio
  chmod 666 /sys/module/lowmemorykiller/parameters/minfree
  chown root /sys/module/lowmemorykiller/parameters/minfree
  echo '21816,29088,36360,43632,50904,65448' > /sys/module/lowmemorykiller/parameters/minfree

