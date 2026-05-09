# nethunter-sm-t220

NetHunter kernel build system for the Samsung Galaxy Tab A7 Lite (SM-T220).

Custom kernel 4.19.191 with USB HID attacks, 802.11 monitor mode + packet injection,
and external USB WiFi adapter support. Reproducible build from Samsung OSRC source.

## Device

| Parameter | Value |
|:----------|:------|
| Model | Samsung Galaxy Tab A7 Lite (SM-T220) — WiFi variant |
| Codename | gta7litewifi |
| SoC | MediaTek MT8768T (12nm, octa-core ARMv8-A) |
| Kernel | 4.19.191 (Samsung OSRC base) |
| Compiler | Android NDK Clang r27c (LLVM 18.0.0) |

## Capabilities

| Capability | Status |
|:-----------|:-------|
| USB HID keyboard/mouse injection | ✅ Enabled |
| 802.11 monitor mode | ✅ Enabled |
| Packet injection | ✅ Enabled |
| Realtek USB WiFi adapters | ✅ Enabled |
| RNDIS network tethering | ✅ Enabled |

## Quick Start

```bash
# 1. Install prerequisites (Kali Linux build machine)
sudo apt install -y git bc bison flex libssl-dev make \
    python3 gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu libelf-dev pahole dos2unix

# 2. Clone this repo
git clone https://github.com/phoenixaegis/nethunter-sm-t220.git
cd nethunter-sm-t220

# 3. Download Android NDK r27c and Samsung OSRC kernel source (SM-T220, Android 14)
#    NDK: https://developer.android.com/ndk/downloads
#    Source: https://opensource.samsung.com

# 4. Run build
./build.sh
```

See [docs/BUILD.md](docs/BUILD.md) for the full step-by-step guide.
See [docs/FLASH.md](docs/FLASH.md) for Heimdall + TWRP flash procedures.

## Patch Application Order

| Order | Patch | Purpose |
|:------|:------|:--------|
| 1 | add-wifi-injection-4.14.patch | Monitor mode + packet injection |
| 2 | add-rtl88xxau-5.6.4.2-drivers.patch | Realtek USB adapter |
| 3 | fix-ath9k-naming-conflict.patch | Symbol resolution |
| 4 | SKIP fix-yylloc | Not applicable |

## License

Apache 2.0. Not affiliated with Kali Linux, Samsung, or Offensive Security.
