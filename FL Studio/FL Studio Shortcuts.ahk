#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force
CoordMode, Mouse, Screen
	
Loop
{
	Process, Exist, FL64.exe
	{
		If ! ErrorLevel
		{
			ExitApp
		}
	}
	Sleep 3000
}

#IfWinActive ahk_class TFruityLoopsMainForm
Numpad8::
{
	winactivate ahk_class TFruityLoopsMainForm
		MouseGetPos, PosX, PosY
		Click, 685 60 right
		Click, 700 200 
		MouseMove, %PosX%, %PosY%
	return
}

