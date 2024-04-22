#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

toggle := false

^Esc::
	exitapp
	return

#IfWinActive ahk_exe SUMMERHOUSE.exe
MButton::
	toggle := !toggle
	return

WheelUp::
	if(toggle){
		SendEvent, {WheelUp down}
		sleep 15
		SendEvent, {WheelUp up}
	}
	else 
	{
		SendEvent, {e down}
		sleep 15
		SendEvent, {e up}
	}
	return
	
WheelDown::
	if(toggle){
		SendEvent, {WheelDown down}
		sleep 15
		SendEvent, {WheelDown up}
	}
	else 
	{
		SendEvent, {q down}
		sleep 15
		SendEvent, {q up}
	}
	return
