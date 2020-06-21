# Printer documentation

This doucment contains information about the printers setup and its wiring.

At the moment of writing, the Voron is a 300mm 2.2. model having a Mobius 3.1 Extruder. Ths Hotend consist of
a E3D V6 clone from Trianglelab containing a *"PT100-style"* thermistor and a 40W heater.

Bed is equipped with a 280mm/600W heater from Keenovo and an additional thermistor to have more consistant readings on
the bed temperature.

As a controller I'm running the Duet2 Wifi / Duex5 combo  (clone by Fysetc). The Duex board is jumpered to provide 12V
to the fans (used for the bottom electronic compartment fan, I wasn't able to source a 120/120/15mm fan with 24V).

The Z-Drives are all connected to the Duex-Board, A-Drive, B-Drive and Extruder is connected to the Duet.

| Drive    | Connector |
|:--------:|:---------:|
|  A       | P0        |
|  B       | P1        |
| Extruder | P4        |
| Z0       | P5        |
| Z1       | P6        |
| Z2       | P7        |
| Z3       | P8        |

Z-Drives are numbered clockwise beginning at the front left corner

```
|-----|-----|
|  6  |  7  |
|-----+-----|
|  5  |  8  |
| ----+-----|
    Front
```

**Attention, when you're flipping over the printer to do electronic motor positions a slighly different !!!**

## Open Issues
- Thermistor connectors
- Heater connectors
- Fan connectors
- endstop connection
- probe connection