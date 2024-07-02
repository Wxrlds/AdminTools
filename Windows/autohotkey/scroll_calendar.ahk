; ##########################################
; ## https://github.com/Wxrlds/AdminTools ##
; ##########################################

#Requires AutoHotkey v2.0

SetDefaultMouseSpeed(0)

#HotIf MouseIsOver("$Replace_This_String_With_The_Title_Of_Your_Outlook_Kalendar_Window") ; Only activates the scripts when Outlook Calendar is selected and mouse hovered over it. MouseIsOver is a custom function
WheelDown:: { ; Executes the function when Mouse Wheel is scrolled down
    WinActivate("$Replace_This_String_With_The_Title_Of_Your_Outlook_Kalendar_Window") ; Activates the Outlook Calendar Window
    WinGetPos(, , &outlookWindowWidth, &outlookWindowHeight, "$Replace_This_String_With_The_Title_Of_Your_Outlook_Kalendar_Window") ; Gets dimensions of Outlook Window
    ErrorLevel := !ImageSearch(&arrowNextMonthX, &arrowNextMonthY, 0, 0, outlookWindowWidth, outlookWindowHeight, "C:\Users\$Your_Username\Pictures\outlook_calendar_right_arrow_365.png") ; Searches for right arrow in outlook calendar
    MouseGetPos(&MouseX, &MouseY) ; Saves current mouse position
    Click(arrowNextMonthX " " arrowNextMonthY) ; Clicks the next month arrow
    belowArrowNextMonthY := arrowNextMonthY + 45 ; Move mouse below the next button
    Click(arrowNextMonthX " " belowArrowNextMonthY)  ; Clicks somewhere else to deselect the arrow button
    MouseMove(MouseX, MouseY) ; Moves mouse back to previous position
    return
}

WheelUp:: { ; Executes the function when Mouse Wheel is scrolled up
    WinActivate("$Replace_This_String_With_The_Title_Of_Your_Outlook_Kalendar_Window") ; Activates the Outlook Calendar Window
    WinGetPos(, , &outlookWindowWidth, &outlookWindowHeight, "$Replace_This_String_With_The_Title_Of_Your_Outlook_Kalendar_Window") ; Gets dimensions of Outlook Window
    ErrorLevel := !ImageSearch(&arrowPrevMonthX, &arrowPrevMonthY, 0, 0, outlookWindowWidth, outlookWindowHeight, "C:\Users\$Your_Username\Pictures\outlook_calendar_right_arrow_365.png") ; Searches for left arrow in outlook calendar
    arrowPrevMonthX := arrowPrevMonthX - 15
    MouseGetPos(&MouseX, &MouseY) ; Saves current mouse position
    Click(arrowPrevMonthX " " arrowPrevMonthY) ; Clicks the previous month arrow
    belowArrowPrevMonthY := arrowPrevMonthY + 45 ; Move mouse below the next button
    Click(arrowPrevMonthX " " belowArrowPrevMonthY)  ; Clicks somewhere else to deselect the arrow button
    MouseMove(MouseX, MouseY) ; Moves mouse back to previous position
    return
}
#HotIf ; Disabled the #hotif statement in line 5

#HotIf MouseIsOver("Datums- und Uhrzeitinformationen") ; Only activates the scripts when Outlook Calendar is selected and mouse hovered over it. MouseIsOver is a custom function
WheelDown:: { ; Executes the function when Mouse Wheel is scrolled down
    MouseGetPos(&MouseX, &MouseY) ; Saves current mouse position
    Click("320 135") ; Clicks the next month arrow
    MouseMove(MouseX, MouseY) ; Moves mouse back to previous position
    return
}
WheelUp:: { ; Executes the function when Mouse Wheel is scrolled up
    MouseGetPos(&MouseX, &MouseY) ; Saves current mouse position
    Click("270 135") ; Clicks the previous month arrow
    MouseMove(MouseX, MouseY) ; Moves mouse back to previous position
    return
}
#HotIf ; Disabled the #hotif statement in line 32

MouseIsOver(vWinTitle := "", vWinText := "", vExcludeTitle := "", vExcludeText := "")
{
    MouseGetPos(, , &hWnd) ; Saves the window ID of the hovered window hWnd is the variable name of the window
    return WinExist(vWinTitle (vWinTitle = "" ? "" : " ") "ahk_id " hWnd, vWinText, vExcludeTitle, vExcludeText) ; Returns the result of WinExist of the window ID in a variable to be used in MouseIsOver function
}