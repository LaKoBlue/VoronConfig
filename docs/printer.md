# Printer documentation

This doucment contains information about the printers setup and its wiring.

At the moment of writing, the Voron is a 300mm 2.2. model having a Mobius 3.1 Extruder. Ths Hotend consist of
a E3D V6 clone from Trianglelab containing a *"PT100-style"* thermistor and a 40W heater.

Bed is equipped with a 280mm/600W heater from Keenovo and an additional thermistor to have more consistant readings on
the bed temperature.

As a controller I'm running the Duet2 Wifi / Duex5 combo  (clone by Fysetc). The Duex board is jumpered to provide 12V
to the fans (used for the bottom electronic compartment fan, I wasn't able to source a 120/120/15mm fan with 24V).

## Drives

The Z-Drives are all connected to the Duex-Board, A-Drive, B-Drive and Extruder is connected to the Duet. I'm using 1.8° steppers.

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

## Thermistors and Heaters (Thermal Section)
In line 70 of [config.g](../rrf-config/sys/config.g) the thermal section starts configuring all the heaters and thermosensors.
At first the boards/chips built-in thermal sensore is configured. I measured a difference of 8°K right against room temperature right after switching
on the device. So this is corrected by a M912 command.

Thermistor of the heat pad is connected to the bed temperture port, the second bed thermistor is connected to E1. If you don't use two sensors you can use the single thermistor section which
is commented out in the config.

The heater is connected to the pad connector (H0). I set the PWM frequency to 10Hz. From my impression there is no need to stress the SSR as
the pad heating process is softened by the printing plate anyway.

As I'm using a 600W heat pad I reduced it to 60% via PWM to avoid warping.

Hotend and its thermistor is connected to the appropriate ports for E0.

A DHT22 is connected to the SPI bus of the duex board to check for chambers temperature and humidity.

## Fans
The hotend cooling fan is connected to fan0 and the PWM frequency is set to 20Hz. It is configured to be activated once the hotend temperature exceeds 60°C.

The part cooling fan is connected to fan2 (fan1 seems to bee out of order on my board). PWM frequency is set to 20Hz, too.

At the moment only one additional fan is running and cooling the electronics. It is connected to the duex board which is configured
to supply 12V. The fan is alway on.

## Endstops and Probe
Probe is connected to zprobe.in, only using ground and data from the header. 24v is injected into the probe directly from power connector.
Endstops use their respective connectors on the duet board.
