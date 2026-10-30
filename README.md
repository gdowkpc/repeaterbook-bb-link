# RepeaterBook Bluetooth Bridge

Open-source adaptation of [Island Magic B.B. Link](https://github.com/islandmagic/bb-link) for Kenwood VFO control from RepeaterBook Connect on iOS.

**Target board: Espressif ESP32-DevKitC-32E (ESP32-WROOM-32E, 4 MB flash).**

## Current status

- VFO control with RepeaterBook Connect and an original B.B. Link has been confirmed by the project owner on a TH-D74.
- The DevKitC-specific experimental firmware compiles and its USB image layout has been checked.
- **The DevKitC has not yet been flashed or tested.** Booting, pairing, VFO control and reconnect/power-cycle behavior still require hardware verification.
- TH-D75 and TM-D750 qualification remain separate future tests. This project does not establish regulatory approval for a finished product.

## Start here

- [DevKitC build, changes and first-board checks](DEVKITC-README.md)
- [BLE interface and app connection checks](docs/repeaterbook-connect.md)
- [Experimental downloads](https://github.com/gdowkpc/repeaterbook-bb-link/releases)
- [Original upstream instructions](UPSTREAM-README.md) - describes original hardware; do not use those images or board settings for this target.

The board uses Bluetooth Classic SPP to the radio and BLE to the iPhone. USB provides power and initial programming. No custom PCB is required for development.

The devkitc-r1 build defaults automatic packet/KISS control OFF on clean preferences and after reset, keeps the existing BLE service, and allows firmware updates over USB only. Stored settings are preserved; confirm Allow Radio Control is OFF during VFO testing. Do not flash this image onto an original B.B. Link, ATOM Lite or an ESP32-S3/C3 board.

## Build

Use Arduino CLI with Arduino-ESP32 **2.0.15**, ArduinoQueue **1.2.5** and ArduinoLog **1.1.1**. Configure Espressif's board-manager URL:

https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json

Install these exact versions using Arduino CLI core/lib install. Then run the Windows build script, passing your CLI path and configuration file:

~~~powershell
powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -File tools/build-devkitc.ps1 -ArduinoCli C:/path/to/arduino-cli.exe -ConfigFile C:/path/to/arduino-cli.yaml
~~~

The script only compiles. It never selects a USB port, erases or flashes a device. The manual GitHub Actions build also produces an application binary; it is not a merged factory image.

## Credits and license

Based on B.B. Link 0.7.8, upstream commit 137db47ef9a2a1646d4974b507b01b863f0a9c0c, by Island Magic Co. Original copyright notices remain in the source. Distributed under the existing [GPL license](LICENSE); source headers specify GPLv3 or later. RepeaterBook modifications are documented in DEVKITC-README.md.

This is an independent experimental adaptation, not an Island Magic release or a transfer of the original hardware design.
