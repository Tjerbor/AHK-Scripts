#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
CoordMode, Mouse, Client
CoordMode, Pixel, Client

;Variables------------------------------------------------------------------------------------------------------------------------------------------------------------

;Auto-execute---------------------------------------------------------------------------------------------------------------------------------------------------------
WinWait, ahk_exe
 
WinWaitActive, ahk_exe
ExitApp, 0 
;Hotkeys--------------------------------------------------------------------------------------------------------------------------------------------------------------

;Exit Script
^Esc::
	ExitApp, 0dasdasdasdasdasdasdasd
	return

#IfWinActive ahk_exeasdasdasdasdasd 

;Functions------------------------------------------------------------------------------------------------------------------------------------------------------------