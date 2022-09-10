; ############################################
; ## https://github.com/Wxrlds/OSSetupTools ##
; ############################################

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

SetDefaultMouseSpeed, 0

#If MouseIsOver("Date and Time Information") ; Only activates the scripts when the calendar from the task bar is selected and mouse hovered over it.
WheelDown:: ; Executes the function when Mouse Wheel is scrolled down
MouseGetPos, MouseX, MouseY ; Saves current mouse position
Click, 320 135 ; Clicks the next month arrow
MouseMove, MouseX, MouseY ; Moves mouse back to previous position
Return
WheelUp:: ; Executes the function when Mouse Wheel is scrolled up
    MouseGetPos, MouseX, MouseY ; Saves current mouse position
    Click, 270 135 ; Clicks the previous month arrow
    MouseMove, MouseX, MouseY ; Moves mouse back to previous position
return
#If ; Disabled the #if statement

MouseIsOver(vWinTitle:="", vWinText:="", vExcludeTitle:="", vExcludeText:="")
{
    MouseGetPos,,, hWnd ; Saves the window ID of the hovered window hWnd is the variable name of the window
return WinExist(vWinTitle (vWinTitle=""?"":" ") "ahk_id " hWnd, vWinText, vExcludeTitle, vExcludeText) ; Returns the result of WinExist of the window ID in a variable to be used in MouseIsOver function
}