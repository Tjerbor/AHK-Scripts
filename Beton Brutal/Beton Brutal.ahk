#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Client
#SingleInstance force

Run, "C:\Program Files (x86)\Steam\steam.exe" -applaunch 2330500

^Esc::
	exitapp
	return

#IfWinActive ahk_exe BetonBrutal.exe
g::
	RunWait, "cmd.exe" start cmd.exe @cmd /k taskkill /im BetonBrutal.exe /f && "C:\Program Files (x86)\Steam\steam.exe" -applaunch 2330500 && exit
	While not WinExist("ahk_exe BetonBrutal.exe")
	{
		if WinExist("ahk_exe steamwebhelper.exe")
		{
			WinActivate, ahk_exe steamwebhelper.exe
			Click, 430 245
		}
		sleep 200
	}
	return