#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
CoordMode, Mouse, Client
CoordMode, Pixel, Client

;Variables------------------------------------------------------------------------------------------------------------------------------------------------------------
toggle := True
;Auto-execute---------------------------------------------------------------------------------------------------------------------------------------------------------
WinWait, ahk_exe firefox.exe
WinWaitActive, ahk_exe firefox.exe
WinWaitClose, ahk_exe firefox.exe
ExitApp, 0
;Hotkeys--------------------------------------------------------------------------------------------------------------------------------------------------------------

;Exit Script
^Esc::
	{
		ExitApp, 0
		return
	}
f1::
	{
		;normal suspend doesn't work with firefox
		toggle := !toggle
		return
	}

#IfWinActive ahk_exe firefox.exe

	;playback
	z::
		{
			if(toggle)
			{
				SendInput, {shift down}{Left}{Shift Up}
			}
			else
			{
				SendInput, z
			}

			Return
		}
	x::
		{
			if(toggle)
			{
				SendInput, {Left}
			}
			else
			{
				SendInput, x
			}
			Return
		}
	c::
		{
			if(toggle)
			{
				SendInput, {Right}
			}
			else
			{
				SendInput, c
			}
			Return
		}
	v::
		{
			if(toggle)
			{
				SendInput, l
			}
			else
			{
				SendInput, v
			}
			Return
		}
	b::
		{
			if(toggle)
			{
				SendInput, {shift down}{Right}{Shift Up}
			}
			else
			{
				SendInput, b
			}
			Return
		}

	Numpad0::
	NumpadIns::
		{
			SendInput, 0
			Return
		}
	Numpad1::
		{
			SendInput, 1
			Return
		}
	Numpad2::
		{
			SendInput, 2
			Return
		}
	Numpad3::
		{
			SendInput, 3
			Return
		}
	Numpad4::
		{
			SendInput, 4
			Return
		}
	Numpad5::
		{
			SendInput, 5
			Return
		}
	Numpad6::
		{
			SendInput, 6
			Return
		}
	Numpad7::
		{
			SendInput, 7
			Return
		}
	Numpad8::
		{
			SendInput, 8
			Return
		}
	Numpad9::
		{
			SendInput, 9
			Return
		}

;playback: numpad seek

;open current song in new tab
;copy current playback title
;add to dll or djonly list

;Functions------------------------------------------------------------------------------------------------------------------------------------------------------------