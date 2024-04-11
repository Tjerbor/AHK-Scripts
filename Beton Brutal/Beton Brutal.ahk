#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Client
#SingleInstance force

Run, "C:\Program Files (x86)\Steam\steam.exe" -applaunch 2330500
Goto, Closing

Closing:
WinWaitClose, ahk_exe BetonBrutal.exe
sleep 30000
if WinExist("ahk_exe BetonBrutal.exe")
{
	Goto, Closing
}
Exitapp
return

^Esc::
	exitapp
	return

#IfWinActive ahk_exe BetonBrutal.exe
g::
	RunWait, "cmd.exe" start cmd.exe @cmd /k taskkill /im BetonBrutal.exe /f && "C:\Program Files (x86)\Steam\steam.exe" -applaunch 2330500 && exit
	While not WinExist("ahk_exe BetonBrutal.exe")
	{
		if WinExist("Steam Dialog")
		{
			WinActivate, Steam Dialog
			WinWaitActive, Steam Dialog
			WinGetActiveStats, OutTitle, OutWidth, OutHeight, OutX, OutY
			if ( Abs((648 / 287) - (OutWidth / OutHeight)) > 0.1)
			{
				break
			}
			Click, 430 245
		}
		sleep 200
	}
	return