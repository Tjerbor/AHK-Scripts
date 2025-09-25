#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
CoordMode, Mouse, Client
CoordMode, Pixel, Client

;Variables------------------------------------------------------------------------------------------------------------------------------------------------------------
Sleep 1000

;Auto-execute---------------------------------------------------------------------------------------------------------------------------------------------------------

Sleep 1000

while (True)
{
	Loop, Read, messages.txt
	{
		WinActivate, ahk_exe firefox.exe
		WinWaitActive, ahk_exe firefox.exe
		MouseMove, 1697, 977
		Click, 2
		Sleep, 400
		SendInput %A_LoopReadLine%{enter}
		Sleep 1000 * 60 * 8
	}
}

;Hotkeys--------------------------------------------------------------------------------------------------------------------------------------------------------------

;Exit Script
^Esc::
ExitApp, 0
return

#IfWinActive ahk_exe

;Functions------------------------------------------------------------------------------------------------------------------------------------------------------------