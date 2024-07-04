#Requires AutoHotkey v2.0

LWin & WheelDown:: {
    Try {
        WinActivate("ahk_class Shell_TrayWnd")
    }
    Send("^#{Right}")
    return
}

LWin & WheelUp:: {
    Try {
        WinActivate("ahk_class Shell_TrayWnd")
    }
    Send("^#{Left}")
    return
}