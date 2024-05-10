#
# Copyright 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

# SDK
BOARD_SYSTEMSDK_VERSIONS := 32

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a-branchprot
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo385

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a75

# Bootloader
TARGET_NO_BOOTLOADER := false
TARGET_USES_UEFI := true
TARGET_USES_REMOTEPROC := true

# Kernel/Ramdisk
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
BOARD_KERNEL_IMAGE_NAME := kernel
BOARD_RAMDISK_USE_LZ4 := true
TARGET_PREBUILT_KERNEL := $(COMMON_PATH)/prebuilt/$(BOARD_KERNEL_IMAGE_NAME)

# Partition Info
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

BOARD_USES_VENDOR_DLKMIMAGE := true
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_KERNEL-GKI_BOOTIMAGE_PARTITION_SIZE := $(BOARD_BOOTIMAGE_PARTITION_SIZE)
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_USERDATAIMAGE_PARTITION_SIZE := 233871900672
BOARD_PERSISTIMAGE_PARTITION_SIZE := 67108864
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_METADATAIMAGE_PARTITION_SIZE := 16777216
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)

# Dynamic/Logical Partitions
BOARD_SUPER_PARTITION_SIZE := 10871635968
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 16936005632 # BOARD_SUPER_PARTITION_SIZE - 4MB
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm

BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600

# Workaround for error copying vendor files to recovery ramdisk
TARGET_COPY_OUT_VENDOR := vendor



# Testing Flags
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs



# Rules
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_NINJA_USES_ENV_VARS += RTIC_MPGEN

# KEYSTONE(If43215c7f384f24e7adeeabdbbb1790f174b2ec1,b/147756744)
BUILD_BROKEN_NINJA_USES_ENV_VARS += SDCLANG_AE_CONFIG SDCLANG_CONFIG SDCLANG_SA_ENABLE

BUILD_BROKEN_USES_BUILD_HOST_SHARED_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_STATIC_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_EXECUTABLE := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true

# Recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hidl.allocator@1.0 \
    android.hidl.memory@1.0 \
    android.hidl.memory.token@1.0 \
    libdmabufheap \
    libhidlmemory \
    libion \
    libnetutils \
    vendor.display.config@1.0 \
    vendor.display.config@2.0 \
    libdebuggerd_client
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/recovery.fstab

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

# AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Encryption
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Extras
TARGET_SYSTEM_PROP += $(COMMON_PATH)/system.prop
TARGET_VENDOR_PROP += $(COMMON_PATH)/vendor.prop

# TWRP specific build flags
TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TW_THEME := portrait_hdpi
TW_CUSTOM_CPU_TEMP_PATH := "/sys/devices/virtual/thermal/thermal_zone31/temp"
TW_BRIGHTNESS_PATH := "/sys/devices/platform/soc/ae00000.qcom,mdss_mdp/backlight/panel0-backlight/brightness"
TW_STATUS_ICONS_ALIGN := center
TW_CUSTOM_CPU_POS := "50"
TW_CUSTOM_CLOCK_POS := "600"
TW_CUSTOM_BATTERY_POS := "800"
TW_SCREEN_BLANK_ON_BOOT := true
TW_DEFAULT_BRIGHTNESS := 2500
TW_QCOM_ATS_OFFSET := 1666528204500
TW_EXCLUDE_APEX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_CRYPTO := false
TW_NO_EXFAT_FUSE := true
TW_INCLUDE_RESETPROP := true
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
TW_OVERRIDE_SYSTEM_PROPS := \
    "ro.build.fingerprint=ro.vendor.build.fingerprint;ro.build.version.incremental"
RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.allocator@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.memory@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.memory.token@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libdmabufheap.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libhidlmemory.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libnetutils.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libdebuggerd_client.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so
TW_LOAD_VENDOR_MODULES += "goodix_brl_mmi.ko mmi_relay.ko panel_event_notifier.ko sensors_class.ko touchscreen_mmi.ko qti_battery_charger.ko hwmon.ko adsp_loader_dlkm.ko rproc_qcom_common.ko q6_dlkm.ko qcom_q6v5.ko qcom_q6v5_pas.ko qcom_esoc.ko qcom_sysmon.ko qcom-hv-haptics.ko haptic_feedback.ko"
# TW_LOAD_VENDOR_MODULES += " adsp_loader_dlkm.ko adsp_sleepmon.ko altmode-glink.ko audio_pkt_dlkm.ko audio_prm_dlkm.ko audpkt_ion_dlkm.ko aw862x_haptic_nv_v1.ko aw882xx_dlkm.ko awinic_sar.ko bam_dma.ko bcl_soc.ko bm_adsp_ulog.ko boot_stats.ko bt_fm_slim.ko btpower.ko camcc-crow.ko camera.ko cdsp-loader.ko cdsprm.ko cfg80211.ko charger-ulog-glink.ko cnss_nl.ko cnss_prealloc.ko cnss_utils.ko con_dfpar.ko core_hang_detect.ko coresight-csr.ko coresight-cti.ko coresight-dummy.ko coresight-funnel.ko coresight-hwevent.ko coresight-remote-etm.ko coresight-replicator.ko coresight-stm.ko coresight-tgu.ko coresight-tmc.ko coresight-tpda.ko coresight-tpdm.ko coresight.ko cpu_voltage_cooling.ko cpufreq_stats_scmi.ko cpufreq_stats_vendor.ko ddr_cdev.ko debugcc-crow.ko debugcc-kalama.ko dmesg_dumper.ko dwc3-msm.ko ehset.ko ep_pcie_drv.ko eud.ko f_fs_ipc_log.ko frpc-adsprpc.ko fsa4480-i2c.ko gh_irq_lend.ko gh_mem_notifier.ko gh_tlmm_vm_mem_access.ko glink_pkt.ko glink_probe.ko goodix_brl_mmi.ko goodix_fod_mmi.ko gpr_dlkm.ko gpucc-crow.ko gpucc-kalama.ko gsim.ko hdcp_qseecom_dlkm.ko hdmi_dlkm.ko heap_mem_ext_v01.ko hung_task_enh.ko hvc_gunyah.ko hwmon.ko i2c-msm-geni.ko i3c-master-msm-geni.ko icc-test.ko icnss2.ko industrialio-buffer-cb.ko ipa_clientsm.ko ipa_fmwk.ko ipam.ko ipanetm.ko kunit.ko leds-qpnp-vibrator-ldo.ko leds-qti-flash.ko leds-qti-tri-led.ko llcc_perfmon.ko lpass_cdc_dlkm.ko lpass_cdc_rx_macro_dlkm.ko lpass_cdc_tx_macro_dlkm.ko lpass_cdc_va_macro_dlkm.ko lpass_cdc_wsa2_macro_dlkm.ko lpass_cdc_wsa_macro_dlkm.ko lt9611uxc.ko mac80211.ko machine_dlkm.ko max31760_fan.ko mbhc_dlkm.ko mcp25xxfd.ko memlat.ko memlat_scmi.ko memlat_vendor.ko mhi.ko mhi_cntrl_qcom.ko mhi_dev_drv.ko mhi_dev_dtr.ko mhi_dev_net.ko mhi_dev_netdev.ko mhi_dev_satellite.ko mhi_dev_uci.ko microdump_collector.ko mmi_annotate.ko mmi_charger.ko mmi_info.ko mmi_lpd_mitigate.ko mmi_relay.ko mmi_sys_temp.ko mmrm_test_module.ko moto_f_usbnet.ko moto_mm.ko moto_mmap_fault.ko moto_sched.ko moto_swap.ko msm-mmrm.ko msm_drm.ko msm_ext_display.ko msm_geni_serial.ko msm_gpi.ko msm_hw_fence.ko msm_kgsl.ko msm_lmh_dcvs.ko msm_memshare.ko msm_performance.ko msm_sharedmem.ko msm_show_epoch.ko msm_show_resume_irq.ko msm_sysstats.ko msm_video.ko nb7vpq904m.ko nvmem_qfprom.ko nxp-nci.ko panel_event_notifier.ko pci-msm-drv.ko pdr_interface.ko phy-generic.ko phy-msm-m31-eusb2.ko phy-msm-snps-eusb2.ko phy-msm-ssusb-qmp.ko phy-qcom-emu.ko phy-qcom-ufs-qmp-v4-khaje.ko phy-qcom-ufs-qmp-v4-kona.ko phy-qcom-ufs-qmp-v4-lahaina.ko phy-qcom-ufs-qmp-v4-waipio.ko phy-qcom-ufs-qmp-v4.ko pinctrl-spmi-gpio.ko pinctrl-spmi-mpp.ko pinctrl_lpi_dlkm.ko plh_scmi.ko plh_vendor.ko pm8941-pwrkey.ko pmic-glink-debug.ko pmic-pon-log.ko pmic_glink.ko policy_engine.ko ps5169.ko pwm-qti-lpg.ko q6_dlkm.ko q6_notifier_dlkm.ko q6_pdr_dlkm.ko qbt_handler.ko qca_cld3_qca6750.ko qce50_dlkm.ko qcedev-mod_dlkm.ko qcom-cpufreq-hw-debug.ko qcom-hv-haptics.ko qcom-i2c-pmic.ko qcom-pon.ko qcom-spmi-adc5-gen3.ko qcom-spmi-temp-alarm.ko qcom-vadc-common.ko qcom_cpuss_sleep_stats.ko qcom_edac.ko qcom_esoc.ko qcom_glink.ko qcom_glink_smem.ko qcom_glink_spss.ko qcom_iommu_debug.ko qcom_ipc_lite.ko qcom_lpm.ko qcom_pil_info.ko qcom_q6v5.ko qcom_q6v5_pas.ko qcom_ramdump.ko qcom_smd.ko qcom_spss.ko qcom_sysmon.ko qcom_va_minidump.ko qcrypto-msm_dlkm.ko qdss_bridge.ko qfprom-sys.ko qmi_helpers.ko qpnp-amoled-regulator.ko qpnp_adaptive_charge.ko qrng_dlkm.ko qrtr-gunyah.ko qrtr-mhi.ko qrtr-smd.ko qsee_ipc_irq_bridge.ko qseecom_proxy.ko qti-fixed-regulator.ko qti-glink-adc.ko qti-ocp-notifier.ko qti_amoled_ecm.ko qti_battery_charger.ko qti_battery_debug.ko qti_cpufreq_cdev.ko qti_devfreq_cdev.ko qti_glink_charger.ko qti_qmi_cdev.ko qti_qmi_sensor_v2.ko qti_userspace_cdev.ko rdbg.ko reboot-mode.ko redriver.ko repeater-i2c-eusb2.ko repeater-qti-pmic-eusb2.ko repeater.ko rimps_log.ko rmnet_aps.ko rmnet_core.ko rmnet_ctl.ko rmnet_offload.ko rmnet_perf.ko rmnet_perf_tether.ko rmnet_sch.ko rmnet_shs.ko rmnet_wlan.ko rndisipam.ko rproc_qcom_common.ko rq_stats.ko sdpm_clk.ko sensors_class.ko sg.ko slim-qcom-ngd-ctrl.ko slimbus.ko smcinvoke_dlkm.ko smp2p.ko smp2p_sleepstate.ko snd-soc-hdmi-codec.ko snd-usb-audio-qmi.ko snd_event_dlkm.ko soc_sleep_stats.ko spcom.ko spf_core_dlkm.ko spi-msm-geni.ko spmi-pmic-arb-debug.ko sps_drv.ko spss_utils.ko st21nfc.ko st54spi_gpio.ko stm_console.ko stm_core.ko stm_ftrace.ko stm_p_basic.ko stm_p_ost.ko stmvl53l3.ko stub_dlkm.ko subsystem_sleep_stats.ko suspend_marker.ko swr_ctrl_dlkm.ko swr_dlkm.ko swr_dmic_dlkm.ko swr_haptics_dlkm.ko sx937x_sar.ko sync_fence.ko synx-driver.ko sys_pm_vx.ko sysmon_subsystem_stats.ko touchscreen_mmi.ko tz_log_dlkm.ko ucsi_glink.ko usb_bam.ko usb_f_ccid.ko usb_f_cdev.ko usb_f_diag.ko usb_f_gsi.ko usb_f_qdss.ko usbmon.ko utags.ko videocc-crow.ko wakeup_sources.ko watchdogtest.ko wcd937x_dlkm.ko wcd937x_slave_dlkm.ko wcd938x_dlkm.ko wcd938x_slave_dlkm.ko wcd939x_dlkm.ko wcd939x_slave_dlkm.ko wcd9xxx_dlkm.ko wcd_core_dlkm.ko wcd_usbss_i2c.ko wl2864c.ko wl2868c.ko wlan_firmware_service.ko wsa883x_dlkm.ko wsa884x_dlkm.ko"
TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true

# TWRP Debug Flags
#TWRP_EVENT_LOGGING := true
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
TARGET_RECOVERY_DEVICE_MODULES += debuggerd
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/debuggerd
TARGET_RECOVERY_DEVICE_MODULES += strace
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/strace
#TARGET_RECOVERY_DEVICE_MODULES += twrpdec
#RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/twrpdec

#
# For local builds only
#
# TWRP zip installer
ifneq ($(wildcard bootable/recovery/installer/.),)
    USE_RECOVERY_INSTALLER := true
    RECOVERY_INSTALLER_PATH := bootable/recovery/installer
endif
# end local build flags
#