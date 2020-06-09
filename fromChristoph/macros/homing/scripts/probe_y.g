
G91                             ; relative positioning
M98 P"/macros/drive/xy_downcurrent.g"
G1 Y310 F6000 H1                ; +Y probe move, fast (*ADJUST* to 10mm more than your Y size)
M98 P"/macros/drive/xy_fullcurrent.g"
G91
G1 Y-1 F300                    ; back off from the endstop
G1 Y1.2 F10 H1                ; +Y probe move, slow
G1 Y-5 F4000                    ; back off from the endstop
