; ############################################
; ## https://github.com/Wxrlds/OSSetupTools ##
; ############################################

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; Sets coordmode to get mouse position over workable area (no taskbar)
CoordMode, Mouse, Screen

; Activates when Alt + t is pressed
!t::

; Offset so the terminal doesn't move to the top left corner but instead in the middle of the terminal
offsetX := 250
offsetY := 150

	; If command prompt is not open
	if not WinExist("ahk_exe WindowsTerminal.exe") {
		; Opens command prompt and waits for it to open
		Run, wt
		WinWait, ahk_exe WindowsTerminal.exe
	}
	; Waits for command prompt to open (a second time for more reliability)
	WinWait, ahk_exe WindowsTerminal.exe

	; Activates command prompt
	WinActivate, ahk_exe WindowsTerminal.exe

	; Gets the mouse position
	MouseGetPos, MouseX, MouseY

	; Gets terminal dimensions
	; Code from window spy for client area of programm
	GetClientSize(WinExist("ahk_exe WindowsTerminal.exe"), TerminalWidthClient, TerminalHeightClient)
	GetClientSize(hWnd, ByRef w := "", ByRef h := "")
	{
		VarSetCapacity(rect, 16)
		DllCall("GetClientRect", "ptr", hWnd, "ptr", &rect)
		w := NumGet(rect, 8, "int")
		h := NumGet(rect, 12, "int")
	}
	WinGetPos, , , TerminalWidth, TerminalHeight, ahk_exe WindowsTerminal.exe

	; Gets which screen the monitor is on
	currentScreen := GetMonitorMouse()
	GetMonitorMouse() {
		SysGet, Mon1, MonitorWorkArea, 1 ; Centre screen
		SysGet, Mon2, MonitorWorkArea, 2 ; Right screen
		SysGet, Mon3, MonitorWorkArea, 3 ; Left screen

		MouseGetPos, MouseX, MouseY

		if(MouseX < Mon3Right) { ; Monitor 3 (left) check
			return 3
		}
		else if (MouseX >= Mon2Left) { ; Monitor 2 (right) check
			return 2
		}
		else { ; Else uses monitor 1
			return 1
		}
	}
	; Gets monitors woring area where the mouse currently is
	SysGet, mwa, MonitorWorkArea, %currentScreen%

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
	WinMove, ahk_exe WindowsTerminal.exe, , %NewTerminalPosX%, %NewTerminalPosY%