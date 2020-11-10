;; Activate the mechanical probe in "slow" mode.
;; Used to finely calibrate the nozzle height
;; after using "fast" to quickly get down to approximate switch height.
;;
;; *ADJUST* this file for:
;;  Your mechanical switch pins ("M558 P*")
;;  Your Z-height tuning ("G31 Z*")
;;
;; !!! This is the only place to edit overall Z-height !!!

;M558 P7 C"e0stop" I0 H0.3 R0.1 F25 T99999 A5 S0.01 B1


M574 Z0 C"nil" ; no Z endstop switch, free up Z endstop input
M558 P5 C"zstop" I0 H0.3 R0.1 F25 T99999 A5 S0.01 B1
G31 P1000 X0 Y0 Z-1.35                                        ; set the probe trigger value to 1000
                                                              ; as the switch is touched with the nozzle, we're defining x:0, y:0 as offset;
                                                              ; z offset is the position of the switch relative to the plate. If its below
                                                              ; the printing plate, it is negative. If the switch is above the plate the value
                                                              ; is positive
                                                              ; please note that the axis minima needs to include the probe level. You cannot reach a 
                                                              ; probe at -.5 when z-min is 0.
