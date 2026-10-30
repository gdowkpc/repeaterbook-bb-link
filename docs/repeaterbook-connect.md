# RepeaterBook Connect integration

## BLE endpoints

| Purpose | UUID | Operation |
| --- | --- | --- |
| Service | 00000001-ba2a-46c9-ae49-01b0961f68bb | Discover advertised service |
| App to adapter | 00000002-ba2a-46c9-ae49-01b0961f68bb | Write Without Response |
| Adapter to app | 00000003-ba2a-46c9-ae49-01b0961f68bb | Subscribe to notifications |

## Establish radio readiness

Finish subscribing before sending commands. BLE connected is not the same as radio connected. Send each request separately and wait for its reply.

1. Query adapter radio-link state using binary C0 06 F1 C0. Decode complete KISS-framed/escaped replies; C0 06 F1 01 ... C0 indicates a connected radio, while 00 indicates disconnected. The remaining fields are six address bytes and the radio name.
2. Once connected, send raw ASCII ID followed by carriage return: 49 44 0D. A D74 replies ID TH-D74 followed by CR. This confirms the complete app/adapter/radio round trip.
3. Query Band A frequency using FQ 0 plus CR (46 51 20 30 0D).
4. A tested D74 setting example is FQ 0,0146520000 plus CR, for 146.520 MHz. Read it back and restore the original frequency after testing. This result was established on the original B.B. Link; the new DevKitC still needs testing.

Kenwood commands are raw ASCII ending in CR (0D), without a KISS wrapper. Buffer replies through CR because notifications may split replies. Adapter management responses are binary frames and need their own decoder. A write completing is not a radio acknowledgement.

Allow Radio Control should be OFF. C0 06 F2 00 C0 disables automatic packet setup and persists without an acknowledgement. It does not exit an already active KISS session; C0 FF C0 is the separate three-byte KISS-exit sequence. Do not concatenate adapter setup and radio writes or send them as a burst; queued adapter work can cause raw writes to be dropped.

Reset ready state after disconnect or command timeout. Require a fresh identity reply before enabling tuning; never automatically replay an earlier setting change after reconnect.

Full repeater offsets and tones require further model-specific verification beyond these basic identity/frequency examples.
