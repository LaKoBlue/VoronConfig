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
M208 X0 Y0 Z- S1	        ; S1 = set axes minima
M208 X292.5 Y296.4 Z280 S0  ; S0 = set axes maxima
M574 X2 Y2 Z0 S1            ; endstops


;; velocity, acceleration, and current settings are in these macros
M98 P"/macros/drive/xy_fullcurrent.g"
M98 P"/macros/drive/z_fullcurrent.g"
M98 P"/macros/drive/e_fullcurrent.g"


;; firmware retraction -------------------------------------

;; Choose one as your default:
M98 P"/macros/retraction/quiet_nozhop.g
;M98 P"/macros/retraction/quiet_zhop.g
;M98 P"/macros/retraction/pa_nozhop.g"
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
M569 P5 S0      ; Z-- motor direction
M569 P6 S1      ; Z+- motor direction
M569 P7 S0      ; Z++ motor direction
M569 P8 S1      ; Z++ motor direction
M569 P4 S0      ; E0 motor direction

M84 S3600                           ; motor idle timeout
M350 X16 Y16 Z16 E16 I1             ; set microstepping
M92 X80 Y80 Z400 E553            	; set microsteps per mm

; endstops
M574 X2 S1 P"xstop"   ; X min active low endstop switch
M574 Y2 S1 P"ystop"   ; Y min active low endstop switch
M574 Z1 S1 P"zstop"   ; Z min active low endstop switch

; Bed leveling params
M671 X-45:-45:348:348 Y7:373:373:7 S20	; Z leadscrews positions
M557 X50:250 Y50:250 S50                ; Bed mesh grid


; thermal section ----------------------------------------------
M308 S3 Y"mcu-temp" A"Board" ; Board thermal sensor
M912 P0 S-8                  ; MCU tempurature sensor correction (subtract 8°K)

;Bed heater not used
M308 S0 P"bedtemp" Y"thermistor" T100000 B3950 A"Bed Pad"  ; configure sensor 0 as thermistor on pin temp0
M950 H0 C"bedheat" T0                                      ; create bed heater output on out0 and map it to sensor 0
M143 H0 S120                                               ; set temperature limit for heater 0 to 120C
M307 H0 B0 S0.6                                            ; disable bang-bang mode for the bed heater and set PWM limit
M140 P0 H0                                                 ; Mark heater h0 as bed heater (for DWC)

;Bed heater dual thermistor setup
;M308 S0 P"bedtemp" Y"thermistor" T100000 B3950 A"Bed Pad"   ; configure sensor 0 as thermistor on pin bedtemp (pad sensor)
;M308 S2 P"e1temp" Y"thermistor" T100000 B3950  A"Bed Plate" ; configure sensor 2 as thermistor on pin e1temp (plate sensor)
;M950 H0 C"bedheat" T0 Q10                                   ; create bed heater output on out0 and map it to sensor 2 (plate sensor). Set PWM frequency to 10Hz
;M143 H0 P100 T0 A2 S110 C0                                  ; Regulate(A2) bed heater (H0) to have pad sensor below 110°C. Use Heater monitor 100 for it
;M143 H0 P101 T1 A1 S120 C0                                  ; Shut off (A1) bed heater (H0) if pad sensor exceeds 120°C. Use Heater monito 101 for it
;M143 H0 S120                                                ; Set bed heater max temperature to 120°C
;M307 H0 B1 S0.6                                             ; Enable Bang Bang mode and set PWM to 60% to avoid warping
;M140 P0 H0                                                  ; Mark heater h0 as bed heater (for DWC)

;HotEnd
M308 S1 P"e0temp" Y"thermistor" T100000 B4700 C7.060000e-8 A"Hotend" ; configure sensor 1 as thermistor
M950 H1 C"e0heat" T1                                                 ; create nozzle heater output on e0heat and map it to sensor 1
M143 H1 S300                                                         ; set temperature limit for heater 1 to 300°C
;M307 H1 B0 S1.00                                                    ; disable bang-bang mode for the nozzle heater and set PWM limit

;Chamber sensor (DHT22)
M308 S10 P"spi.cs6" Y"dht22"       A"Chamber Temp"       ; define DHT22 temperature sensor
M308 S11 P"S10.1" Y"dhthumidity" A"Chamber Hum[%]"       ; Attach DHT22 humidity sensor to secondary output of temperature senso

; fans ----------------------------------------------------
; part cooler
M950 F0 C"fan2" Q20           ; part cooler, set to 500Hz PWM
M106 P0 C"PartCooler"        ; part cooler PWMED down

;Hot End
M950 F1 C"fan0" Q20          ; hotend fan, set to 500Hz PWM
M106 P1 T60 H1  C"toolfan" ; attach hotend fan to heater 1 and set activation temperature to 60°C

;Electronics
M950 F2 C"^duex.fan3"        ; 12V fan on duex. Needs pullup because duex switches ground
M106 P2 S255 C"Boardfan"

; tools ---------------------------------------------------
M563 P0 D0 H1       ; bind tool 0 to drive and heater
G10 P0 X0 Y0 Z0     ; tool offset
G10 P0 S0 R0        ; tool active and standby temp

T0                  ; activate tool 0


; paneldue --------------------------
M575 P1 S1 B57600   ; activate paneldue


; z-probe offset
;G31 Z3.58


; read config-override.g
M501