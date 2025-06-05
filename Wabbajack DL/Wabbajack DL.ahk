#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
CoordMode, Mouse, Client
CoordMode, Pixel, Client

;Variables------------------------------------------------------------------------------------------------------------------------------------------------------------

;Auto-execute---------------------------------------------------------------------------------------------------------------------------------------------------------
WinWaitClose, ahk_exe Wabbajack.exe
ExitApp, 0 
;Hotkeys--------------------------------------------------------------------------------------------------------------------------------------------------------------

;Exit Script
^Esc::
	ExitApp, 0
	return


^D::
repeat:	
	not_found := True
	While(not_found)
	{
		WinActivate ahk_exe Wabbajack.exe
		WinWaitActive ahk_exe Wabbajack.exe
		Click 1 1
		Sleep 150
		ImageSearch, FoundX, FoundY, 0, 0, 1400, 680, dl.png
		if (ErrorLevel = 1){
			SendInput {Down}
			Sleep 100
			SendInput {Down}
			Sleep 100
			SendInput {Down}
			Sleep 100
			SendInput {Down}
			Sleep 100
			SendInput {Down}
			Sleep 100
		}
		else{
			not_found := False
			Click %FoundX% %FoundY%.
			Sleep 20000
			Goto, repeat
			;MsgBox The icon was found at %FoundX%x%FoundY%.
			}
	}
	return

;Functions------																																		------------------------------------------------------------------------------------------------------------------------------------------------------