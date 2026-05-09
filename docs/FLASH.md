# Flash Guide — SM-T220 NetHunter Kernel

## Prerequisites
- Unlocked bootloader (OEM LOCK: OFF confirmed in Download Mode)
- TWRP recovery installed
- Magisk root active

## Method A — Heimdall

```bash
# Boot to Download Mode: Vol Up + Vol Down + USB cable → press Vol Up
heimdall detect          # Device detected
heimdall flash --KERNEL ~/nethunter-sm-t220/kernel-output/Image.gz-dtb --no-reboot
# Reboot: hold Vol Down + Power
```

## Method B — TWRP AnyKernel ZIP

1. Copy anykernel-NetHunter.zip to device
2. Boot TWRP → Install → Flash → Reboot

## Validation

```bash
adb shell uname -r           # verify kernel version
adb shell ls /sys/kernel/config/usb_gadget/  # verify USB gadget support
```

- [ ] USB HID injection works
- [ ] External adapter detected (lsusb)
- [ ] Monitor mode: airmon-ng start wlan1
- [ ] Root persists after reboot
