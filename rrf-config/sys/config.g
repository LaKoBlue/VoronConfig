;; system and network --------------------------------------
M111 S0                 ; Debug off
M550 PDuetTest			; Machine name and Netbios name (can be anything you like)
M551 Preprap            ; Machine password (used for FTP)

M552 S1			        ; start network module (must have been configured first with M587)
M586 P2 S1 T0	        ; enable telnet
M586 P1 S1 T0	        ; enable ftp

M555 P2					; Set output to look like Marlin
G21						; Work in millimetres
G90						; Send absolute coordinates...
M83						; ...but relative extruder moves

;; geometry ------------------------------------------------

M667 S1                     ; corexy mode
M208 X0 Y0 Z-1 S1.   	    ; S1 = set axes minima
M208 X294.4 Y305.7 Z280 S0  ; S0 = set axes maxima
M574 X2 Y2 Z0 S1            ; endstops


;; velocity, acceleration, and current settings are in these macros
M98 P"/macros/drive/xy_fullcurrent.g"
M98 P"/macros/drive/z_fullcurrent.g"
M98 P"/macros/drive/e_fullcurrent.g"


;; firmware retraction -------------------------------------

;; Choose one as your default:
;M98 P"/macros/retraction/quiet_nozhop.g
;M98 P"/macros/retraction/quiet_zhop.g
M98 P"/macros/retraction/pa_nozhop.g"
;M98 P"/macros/retraction/pa_zhop.g"


; drive ---------------------------------------------------
;   ----+----   Z-Drives
;   | 6 | 7 |
;   ----+----
;   | 5 | 8 |
;   ----+----
;     Front

M584 X0 Y1 Z5:6:7:8 E4				; motor bindings

M569 P0 S0      ; X motor direction
M569 P1 S0      ; Y motor direction
M569 P5 S0      ; Z0 motor direction
M569 P6 S1      ; Z1 motor direction
M569 P7 S0      ; Z2 motor direction
M569 P8 S1      ; Z3 motor direction
M569 P4 S0      ; E0 motor direction

M84 S3600                           ; motor idle timeout
M350 X16 Y16 Z16 E16 I1             ; set microstepping
M92 X80 Y80 Z400 E426           	; set microsteps per mm

; endstops
M574 X2 S1 P"xstop"   ; X min active low endstop switch
M574 Y2 S1 P"ystop"   ; Y min active low endstop switch
M574 Z1 S1 P"zstop"   ; Z min active low endstop switch

; Bed leveling params
M671 X-46:-46:342:342 Y-11:370.5:370.5:-11 S20	; Z leadscrews positions
M557 X25:275 Y25:250 S25                        ; Bed mesh grid


; thermal section ----------------------------------------------
M308 S3 Y"mcu-temp" A"Board" ; Board thermal sensor
M912 P0 S-8                  ; MCU tempurature sensor correction (subtract 8°K)

;Bed heater single thermistor setup, not used
;M308 S0 P"bedtemp" Y"thermistor" T100000 B3950 A"Bed Pad"  ; configure sensor 0 as thermistor on pin temp0
;M950 H0 C"bedheat" T0                                      ; create bed heater output on out0 and map it to sensor 0
;M143 H0 S120                                               ; set temperature limit for heater 0 to 120C
;M307 H0 B0 S0.6                                            ; disable bang-bang mode for the bed heater and set PWM limit
;M140 P0 H0                                                 ; Mark heater h0 as bed heater (for DWC)

;Bed heater dual thermistor setup
M308 S0 P"bedtemp" Y"thermistor" T100000 B3950 A"Bed Pad"   ; configure sensor 0 as thermistor on pin bedtemp (pad sensor)
M308 S2 P"e1temp" Y"thermistor" T100000 B3950 A"Bed Plate"  ; configure sensor 2 as thermistor on pin e1temp (plate sensor)
M950 H0 C"bedheat" T2 Q10                                   ; create bed heater output on out0 and map it to sensor 2 (plate sensor). Set PWM frequency to 10Hz
M140 P0 H0                                                  ; Mark heater H0 as bed heater (for DWC)
M143 H0 P1 T0 A2 S110 C0                                    ; Regulate (A2) bed heater (H0) to have pad sensor (T0) below 110°C. Use Heater monitor 1 for it
M143 H0 P2 T0 A1 S120 C0                                    ; Shut off (A1) bed heater (H0) if pad sensor (T0) exceeds 120°C. Use Heater monitor 2 for it
M143 H0 S120                                                ; Set bed heater max temperature to 120°C, use implict monitor 0 which is implicitly configured for heater fault
M307 H0 B1 S0.6                                             ; Enable Bang Bang mode and set PWM to 60% to avoid warping


;HotEnd
;M308 S1 P"e0temp" Y"thermistor" T100000 B4685 C6.5338987554e-08 A"Hotend"
M308 S1 P"e0temp" Y"thermistor" T100000 B4725 C7.060000e-8 A"Hotend" ; configure sensor 1 as thermistor (ATC Semitec 104GT2)
M950 H1 C"e0heat" T1                                                 ; create nozzle heater output on e0heat and map it to sensor 1
M143 H1 S300                                                         ; set temperature limit for heater 1 to 300°C
;M307 H1 B0 S1.00                                                    ; disable bang-bang mode for the nozzle heater and set PWM limit

;Chamber sensor (DHT22)
M308 S7 P"spi.cs6" Y"dht22"    A"Chamber Temp"          ; define DHT22 temperature sensor
M308 S8 P"S7.1" Y"dhthumidity" A"Chamber Hum[%]"        ; Attach DHT22 humidity sensor to secondary output of temperature senso

; fans ----------------------------------------------------
; part cooler
M950 F0 C"fan2" Q20               ; part cooler, set to 20Hz PWM
M106 P0 C"PartCooler"             ; Name it "PartCooler"

;Hot End
M950 F1 C"fan0" Q20               ; hotend fan, set to 20Hz PWM
M106 P1 T60 H1 C"ToolFan"         ; attach hotend fan to heater 1 and set activation temperature to 60°C

; controller / electronics fan
M950 F2 C"duex.fan5" Q20            ; electronics compartment fan on duex, set to 20Hz PWM
M106 P2 H3 T35:50 C"ElectronicsFan" ; fan is activated when MCU reports 35°C; runs on full speed from 50°C on


; chamber Fan
M950 F3 C"duex.fan4" Q20          ; chamber fan on duex, set to 20Hz PWM
M106 P3 T40:45 H7 C"ChamberFan"   ; Chamberfan is activated when chamber thermistor reached 40°C; runs on full speed from 45°C on


; tools ---------------------------------------------------
M563 P0 D0 H1       ; bind tool 0 to drive and heater
G10 P0 X0 Y0 Z0     ; tool offset
G10 P0 S0 R0        ; tool active and standby temp

T0                  ; activate tool 0


; paneldue --------------------------
M575 P1 S1 B57600   ; activate paneldue


; define the z-probe, unsure, might not been needed
M558 P5 C"zprobe.in" I1 A5 H1.45 R0.1 F65 T7000 A5 S0.01 B1

; read config-override.g
M501