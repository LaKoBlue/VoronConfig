; For homing Z, perform a double-tap using the mechanical switch.

M98 P"/macros/moveto/mswitch_xy.g"

M98 P"/macros/drive/z_downcurrent.g"

M98 P"/macros/zprobe/use_mfast.g"     ; activate endstop switch as z-probe for fast probing
G30                                   ; z-probe as configured

M98 P"/macros/drive/z_fullcurrent.g"

M98 P"/macros/zprobe/use_mslow.g"     ; activate endstop switch as z-probe for slow probing
G30                                   ; z-probe as configured

M98 P"/macros/zprobe/use_ifast.g"     ; restore default probe (inductive probe) settings