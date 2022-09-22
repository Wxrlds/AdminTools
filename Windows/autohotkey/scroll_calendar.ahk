; ############################################
; ## https://github.com/Wxrlds/OSSetupTools ##
; ############################################

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

SetDefaultMouseSpeed, 0

#If MouseIsOver("$Replace_This_String_With_The_Title_Of_Your_Outlook_Window") ; Only activates the scripts when Outlook Calendar is selected and mouse hovered over it. MouseIsOver is a custom function
	WheelDown:: ; Executes the function when Mouse Wheel is scrolled down
		WinActivate, $Replace_This_String_With_The_Title_Of_Your_Outlook_Window ; Activates the Outlook Calendar Window
		WinGetPos, , , outlookWindowWidth, outlookWindowHeight, $Replace_This_String_With_The_Title_Of_Your_Outlook_Window ; Gets dimensions of Outlook Window
		ImageSearch, arrowNextMonthX, arrowNextMonthY, 0, 0, outlookWindowWidth, outlookWindowHeight, C:\Users\$Your_Username_Here\Pictures\outlook_calendar_right_arrow.png ; Searches for right arrow in outlook calendar
		MouseGetPos, MouseX, MouseY ; Saves current mouse position
		Click, %arrowNextMonthX% %arrowNextMonthY% ; Clicks the next month arrow
		MouseMove, MouseX, MouseY ; Moves mouse back to previous position
	return
	WheelUp:: ; Executes the function when Mouse Wheel is scrolled up
		WinActivate, $Replace_This_String_With_The_Title_Of_Your_Outlook_Window ; Activates the Outlook Calendar Window
		WinGetPos, , , outlookWindowWidth, outlookWindowHeight, $Replace_This_String_With_The_Title_Of_Your_Outlook_Window ; Gets dimensions of Outlook Window
		ImageSearch, arrowPrevMonthX, arrowPrevMonthY, 0, 0, outlookWindowWidth, outlookWindowHeight, C:\Users\$Your_Username_Here\Pictures\outlook_calendar_right_arrow.png ; Searches for left arrow in outlook calendar
		arrowPrevMonthX := arrowPrevMonthX - 15
		MouseGetPos, MouseX, MouseY ; Saves current mouse position
		Click, %arrowPrevMonthX% %arrowPrevMonthY% ; Clicks the previous month arrow
		MouseMove, MouseX, MouseY ; Moves mouse back to previous position
	return
#If ; Disabled the #if statement

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