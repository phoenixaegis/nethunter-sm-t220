# Build Guide — SM-T220 NetHunter Kernel 4.19.191

## Prerequisites

```bash
sudo apt install -y git bc bison flex libssl-dev make \
    python3 gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu libelf-dev pahole dos2unix
```

## Step 1 — NDK r27c

```bash
wget https://dl.google.com/android/repository/android-ndk-r27c-linux.zip
unzip android-ndk-r27c-linux.zip -d ~/
export PATH="${HOME}/android-ndk-r27c/toolchains/llvm/prebuilt/linux-x86_64/bin:${PATH}"
which clang  # verify
```

## Step 2 — Samsung OSRC Kernel Source

Download SM-T220 Android 14 source from: https://opensource.samsung.com
Extract to: ~/nethunter-sm-t220/kernel-source/

## Step 3 — NetHunter Kernel Builder

```bash
git clone https://gitlab.com/kalilinux/nethunter/build-scripts/kali-nethunter-kernel-builder.git \
    ~/nethunter-sm-t220/kali-nethunter-kernel-builder
```

## Step 4 — Apply Patches (via builder option 4)

Order: wifi-injection → rtl88xxau → ath9k → SKIP fix-yylloc
For conflicts: answer `y` to both prompts.

## Step 5 — Kernel Config

```bash
cd ~/nethunter-sm-t220/kernel-source
cp arch/arm64/configs/gta7litewifi_defconfig .config
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CC=clang olddefconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CC=clang menuconfig
```

Enable in menuconfig: USB Gadget + HID + RNDIS, mac80211, RTL8XXXU.

## Step 6 — Compile

```bash
make -j$(nproc)
ls arch/arm64/boot/  # verify Image.gz-dtb present
```

Expected: 45–60 minutes.

## Known Issues

| Error | Fix |
|:------|:----|
| Kconfig syncconfig Error 1 | `find . -name "Kconfig" -exec dos2unix {} \;` |
| defex_cert.S not found | `touch security/samsung/defex_lsm/cert/pubkey_eng.der` |
| macro redefined | Ignore — vendor warning only |
