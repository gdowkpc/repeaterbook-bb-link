# RepeaterBook DevKitC-32E experimental firmware (devkitc-r1)

Target: Espressif ESP32-DevKitC-32E, ESP32-WROOM-32E, 4 MB flash, internal PCB antenna. Not for ESP32-S3/C3 or the retail B.B. Link.

Based on Island Magic B.B. Link 0.7.8, commit 137db47ef9a2a1646d4974b507b01b863f0a9c0c. Original copyright and GPLv3-or-later terms retained; see LICENSE and source headers. This is a local RepeaterBook experimental adaptation, not an Island Magic release.

## Changes

- Explicit BB_LINK_DEVKITC_32E target with local hardware ID 128.
- Automatic KISS control defaults OFF on clean preferences and after factory reset. An already stored setting remains honored; verify Allow Radio Control OFF before testing.
- GPIO9 USB-sense initialization restricted to TinyPICO; DevKitC uses USB-only power behavior.
- Original data-service UUIDs, notification/write characteristics and Kenwood raw command forwarding retained.
- Firmware reports upstream protocol version 0.7.8; USB startup banner identifies devkitc-r1.
- Configurator identity reads retained; BLE firmware writes rejected. Update this experimental board over USB only.
- No status LED or user button added; the board's power LED and EN/BOOT buttons retain their hardware roles.

## Build configuration

Arduino-ESP32 2.0.15; ArduinoQueue 1.2.5; ArduinoLog 1.1.1.
FQBN: esp32:esp32:esp32:FlashMode=dio,FlashFreq=40,FlashSize=4M,PartitionScheme=min_spiffs,PSRAM=disabled
Build property: compiler.cpp.extra_flags=-DBB_LINK_DEVKITC_32E
Use min_spiffs (two OTA-sized application slots), not the small default app partition. Hardware updates still use USB.

## Before hardware testing

Compilation is not proof of boot, RF performance, radio control or product compliance. Do not use these images on the original B.B. Link. No device has been flashed by this preparation.

When the purchased board arrives: connect only USB power/data (no external wiring), verify its module label and 4 MB flash, preserve any firmware/settings you need, and identify the correct COM port. Use a Micro-USB DATA cable. Initial flashing overwrites the development board's existing program; do not erase flash or upload to any port until board identity is confirmed.

Pair using Configurator; confirm Allow Radio Control OFF, disconnect Configurator, then test ID\r (49440D), FQ 0\r (465120300D), a frequency change and readback, and restoration. Next test RepeaterBook and reconnect/power cycles. D75 and D750 remain separate model qualifications.

## Reproduce locally

Install Arduino CLI, configure its ESP32 board-manager URL, and install the pinned core and two libraries above. Run tools/build-devkitc.ps1 with -ArduinoCli and -ConfigFile pointing to your isolated installation. The build script compiles only; it never selects a COM port or flashes hardware.

## Configurator compatibility review

The public ios-bblink-config FirmwareUpdater.urlForBoard returns no update URL for unknown board IDs. Our experimental hardware ID 128 therefore does not select a TinyPICO/Pico32 update. The custom firmware additionally rejects BLE firmware-write requests. Pairing and settings still use the original BLE data protocol. Source review is not a test of the installed iOS Configurator app.

## Build result (30 October 2026)

Compilation passed: 1,163,781 bytes program storage (59% of 1,966,080-byte app partition); 39,892 bytes global RAM (12%). The merged factory image was checked against each input segment and the app fits the generated partition table. This verifies packaging only, not operation on a board. The factory image is intended for USB writing at offset 0x0 only after checking the purchased board and port. No flash/erase/upload command has been run.
