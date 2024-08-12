#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Client

#SingleInstance force
Run, "C:\Program Files (x86)\OneTagger\onetagger.exe"

WinWait, ahk_exe onetagger.exe
WinWaitActive, ahk_exe onetagger.exe
WinMaximize, ahk_exe onetagger.exe

WinWaitClose, ahk_exe onetagger.exe
Exitapp

#IfWinActive ahk_exe onetagger.exe
^RButton Up::
	SendInput, {Esc}
	MouseMove, 380, 940
	return
	
^LButton Up::
	SendInput, {Esc}
	MouseMove, 255, 940
	return