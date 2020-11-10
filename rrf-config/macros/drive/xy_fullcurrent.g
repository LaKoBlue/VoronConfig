;; In order to consolidate motor current and physics settings,
;; and to enable switching between full- and low-current profiles,
;; these motor settings live in this related set of macros.
;;
;; The "fullcurrent" files specify normal operating values.
;;
;; *ADJUST* all values. What works for you will depend on your build size,
;; motors, and the material of your printed printer parts.

M913 X100 Y100          ; restore motor current percentage to 100%
M906 X1100 Y1100        ; motor drive current

M203 X21000 Y21000      ; maximum speed (mm/min)
M201 X3600 Y3200        ; maximum acceleration (mm/s²)
M566 X240 Y300          ; instantaneous speed change / jerk (mm/min) 
;M205 X4 Y5             ; instantaneous speed change / jerk (mm/s)
M593 F57                ; Dynamic Accelaration : filter 57Hz 