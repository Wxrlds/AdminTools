#Requires AutoHotkey v2.0

; https://stackoverflow.com/questions/75874849/how-to-get-current-file-or-folder-path-and-filename-with-ahk2-x
; https://mythofechelon.co.uk/blog/2021/3/20/windows-apps-for-an-efficient-workflow
; Create a group of the windows that contain files and/or folders:
; ahk_group ExplorerDesktopGroup
GroupAdd("ExplorerDesktopGroup", "ahk_class ExploreWClass")
GroupAdd("ExplorerDesktopGroup", "ahk_class CabinetWClass")
GroupAdd("ExplorerDesktopGroup", "ahk_class Progman")
GroupAdd("ExplorerDesktopGroup", "ahk_class WorkerW")

return

#HotIf WinActive("ahk_group ExplorerDesktopGroup")

; Press Win+P in explorer or desktop
; to get the path of the selected items in a message box

+!c:: A_Clipboard := Explorer_GetSelection() ; Shift + Alt + c

#HotIf

Explorer_GetSelection() {
    ; https://www.autohotkey.com/boards/viewtopic.php?style=17&t=60403#p255169
    result := ""
    winClass := WinGetClass("ahk_id" . hWnd := WinExist("A"))
    if !(winClass ~= "^(Progman|WorkerW|(Cabinet|Explore)WClass)$")
        Return
    shellWindows := ComObject("Shell.Application").Windows
    if (winClass ~= "Progman|WorkerW")
        shellFolderView := shellWindows.Item(ComValue(VT_UI4 := 0x13, SWC_DESKTOP := 0x8)).Document
    else {
        for window in shellWindows
            if (hWnd = window.HWND) && (shellFolderView := window.Document)
                break
    }
    for item in shellFolderView.SelectedItems
        result .= (result = "" ? "" : "`n") . item.Path
    Return result
}