G91                             ; relative positioning
M98 P"/macros/drive/xy_downcurrent.g"
G1 H1 X310 F6000                ; +X probe move, fast. (*ADJUST* to 10mm larger than your X size)
M98 P"/macros/drive/xy_fullcurrent.g"
G1 X-1 F300                   ; back off from the endstop
G1 X1.2 F10 H1              ; +X probe move, slow
G1 X-5 F4000                    ; back off from the endstop
