; ##########################################
; ## https://github.com/Wxrlds/AdminTools ##
; ##########################################

#Requires AutoHotkey v2.0

;STRG+g
^g:: {
    Sleep(5000)
    Loop Parse, A_Clipboard
    {
        Send("{Raw}" A_Loopfield)
        Send("{Alt Up}{Shift Up}{CTRL Up}{RAlt Up}")
        Sleep(100)
    }
    MsgBox("Done")
    ExitApp()
}