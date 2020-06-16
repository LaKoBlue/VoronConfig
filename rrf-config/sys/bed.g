M561                            ; clear bed transform

;; Quickly find approximate bed level
M561
M98 P"/macros/homing/scripts/zhop_up.g"
M98 P"/macros/homing/scripts/probe_zi.g"

G90                             ; absolute positioning
G0 X290 Y250 Z15 F99999         ; move just inside the back-right corner, subtracting probe offset

;; Switch to slow probing, and perform multi-pass gantry leveling.
M98 P"/macros/zprobe/use_ifast.g"
M98 P"/macros/homing/scripts/probe_zlevel.g"
M98 P"/macros/zprobe/use_islow.g"
M98 P"/macros/homing/scripts/probe_zlevel.g"
M98 P"/macros/homing/scripts/probe_zlevel.g"
M98 P"/macros/zprobe/use_ifast.g"       ; restore default probe settings

;; Perform mechanical Z-height adjustment,
;; but do it via homeall to correct X and Y after gantry leveling.
M561
G28 Z