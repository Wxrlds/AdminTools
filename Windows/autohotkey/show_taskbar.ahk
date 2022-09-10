############################################
## https://github.com/Wxrlds/OSSetupTools ##
############################################

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

CoordMode, Mouse, screen

; Shows taskbar when pressing alt + y
; Only useful if taskbar is set to auto hide and on the top of the screen
; Moves mouse to top middle of main screen
!y:: 
    MouseGetPos, MouseX, MouseY ; Gets the Mouse Position
    MouseMove, A_ScreenWidth/2, 0, 0 ; Moves mouse to top of middle screen with a 0ms delay
    Sleep, 100 ; Waits there for 100ms
    MouseMove, MouseX, MouseY, 0 ; Goes back to previous position with a 0ms delay