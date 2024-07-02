; ##########################################
; ## https://github.com/Wxrlds/AdminTools ##
; ##########################################

#Requires AutoHotkey v2.0

; Sets coordmode to get mouse position over workable area (no taskbar)
CoordMode("Mouse", "Screen")

; Activates when Alt + t is pressed
!t:: {
	; Offset so the terminal doesn't move to the top left corner but instead in the middle of the terminal
	offsetX := 250
	offsetY := 150

	; If command prompt is not open
	if not WinExist("ahk_exe WindowsTerminal.exe") {
		; Opens command prompt and waits for it to open
		Run("wt")
		WinWait("ahk_exe WindowsTerminal.exe")
	}
	; Waits for command prompt to open (a second time for more reliability)
	WinWait("ahk_exe WindowsTerminal.exe")

	; Activates command prompt
	WinActivate("ahk_exe WindowsTerminal.exe")

	; Gets the mouse position
	MouseGetPos(&MouseX, &MouseY)

	; Gets terminal dimensions
	WinGetClientPos(, , &TerminalWidthClient, &TerminalHeightClient, "ahk_exe WindowsTerminal.exe")
	WinGetPos(, , &TerminalWidth, &TerminalHeight, "ahk_exe WindowsTerminal.exe")

	; Gets which screen the monitor is on
	currentScreen := GetMonitorMouse()

	; Gets monitors woring area where the mouse currently is
	MonitorGetWorkArea(currentScreen, &mwaLeft, &mwaTop, &mwaRight, &mwaBottom)

	; Change MouseX coordinates to work with offset
	MouseX := MouseX - offsetX
	MouseY := MouseY - offsetY


	; TerminalClient is an invisible bounding box. (TerminalWith - Client) / 2 adds half of the pixels from the difference to it for better alignment. +/- x at the end is to move it one pixel left/right/up/down
	; If MouseX + width of terminal is bigger than currents monitors right edge then sets it so right edge of terminal aligns with right edge of screen
	if (MouseX + TerminalWidth > mwaRight) {
		NewTerminalPosX := mwaRight - TerminalWidth + ((TerminalWidth - TerminalWidthClient) / 2) - 1

		; If MouseX - offset less than current monitors left edge then sets it to left edge
	} else if (MouseX < mwaLeft) {
		NewTerminalPosX := mwaLeft - ((TerminalWidth - TerminalWidthClient) / 2) + 1


	} else {
		NewTerminalPosX := MouseX
	}

	; If Mousey + height of terminal is bigger than currents monitors bottom edge then sets it so bottom edge of terminal aligns with bottom edge of screen
	if (MouseY + TerminalHeight > mwaBottom) {
		NewTerminalPosY := mwaBottom - TerminalHeight + ((TerminalHeight - TerminalHeightClient) / 2) + 3

		; If MouseY - offset less than current monitors left top then sets it to top edge
	} else if (MouseY < mwaTop) {
		NewTerminalPosY := mwaTop - ((TerminalHeight - TerminalHeightClient) / 2) + 4

		; Otherwise sets Terminal Position to MouseX
	} else {
		NewTerminalPosY := MouseY
	}

	; Moves command prompt to mouse pos
	WinMove(NewTerminalPosX, NewTerminalPosY, , , "ahk_exe WindowsTerminal.exe")
}


GetMonitorMouse() {
	MonitorGetWorkArea(1, &Mon1Left, &Mon1Top, &Mon1Right, &Mon1Bottom) ; Centre screen
	MonitorGetWorkArea(2, &Mon2Left, &Mon2Top, &Mon2Right, &Mon2Bottom) ; Right screen
	MonitorGetWorkArea(3, &Mon3Left, &Mon3Top, &Mon3Right, &Mon3Bottom) ; Left screen

	MouseGetPos(&MouseX, &MouseY)

	if (MouseX < Mon3Right) { ; Monitor 3 (left) check
		return 3
	}
	else if (MouseX >= Mon2Left) { ; Monitor 2 (right) check
		return 2
	}
	else { ; Else uses monitor 1
		return 1
	}
}