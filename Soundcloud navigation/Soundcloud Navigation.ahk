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
	z:: ;previous
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
	x:: ;open in new tab
		{
			if(toggle)
			{
				MouseGetPos, xpos, ypos
				MouseMove, 1280, 1025
				SendInput, {Ctrl Down}
				Click
				SendInput, {Ctrl Up}
				MouseMove, %xpos%, %ypos%
			}
			else
			{
				SendInput, x
			}
			Return
		}
	c:: ;repost
		{
			if(toggle)
			{
				SendInput, r
			}
			else
			{
				SendInput, c
			}
			Return
		}
	v:: ;like
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
	b:: ;next
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

	n:: ;copy current playback title
		{
			if(toggle)
			{
				clipboard := ""
				MouseGetPos, xpos, ypos
				MouseMove, 1270, 1025
				SendInput, {LButton down}
				MouseMove, 1455, 1030
				SendInput, {LButton Up}
				SendInput, {Ctrl Down}c{Ctrl up}
				ClipWait
				MouseMove, 30, 1025
				Click
				MouseMove, %xpos%, %ypos%
				Clipboard := StrReplace(Clipboard, "`r`n")
			}
			else
			{
				SendInput, n
			}
			Return
		}

	d:: ;create and add to dll playlist
		{
			if(toggle)
			{
				Create_add_to_playlist("dll.png","dll")
			}
			else
			{
				SendInput, d
			}
			Return
		}
	f:: ;create and add to dll playlist
		{
			if(toggle)
			{
				Create_add_to_playlist("djonly.png","djonly")
			}
			else
			{
				SendInput, f
			}
			Return
		}

	;volume control
	RButton & WheelUp::
		{
			if(toggle)
			{
				SendInput, {shift down}{Up}{Shift up}
			}
			Return
		}
	RButton & WheelDown::
		{
			if(toggle)
			{
				SendInput, {shift down}{Down}{Shift up}
			}
			Return
		}

	;playback: numpad seek
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

		;Functions------------------------------------------------------------------------------------------------------------------------------------------------------------

		Create_add_to_playlist(playlist_image, playlist_name)
		{
			;open new tab and switch to it
			MouseGetPos, xpos, ypos
			MouseMove, 1280, 1025
			SendInput, {Ctrl Down}
			Click
			SendInput, {Ctrl Up}
			Sleep, 100
			SendInput, {Ctrl Down}{Tab}{Ctrl up}

			;search for three dots
			Loop, 7
			{
				Sleep, 1000
				ImageSearch, FoundX, FoundY, 340, 160, 1200, 850, dots.png
				if (ErrorLevel = 1 and %A_Index% = 7) ;not found
				{
					SendInput, {Ctrl Down}w{Ctrl up}
					MsgBox Coult not find 3 dots.
					Return
				}
				else if(ErrorLevel = 1) ; not found yet
				{
					continue
				}
				else ; found the 3 dots
				{
					break
				}
			}
			MouseMove % FoundX + 25, FoundY + 20
			Click
			sleep, 50
			MouseMove % FoundX + 25, FoundY + 60
			Click
			sleep, 50

			;search for playlist
			index := 0
			While(index < 3)
			{
				index := index + 1
				ImageSearch, FoundX, FoundY, 680, 190, 1320, 900, %playlist_image%
				if (ErrorLevel = 1 and index = 3) ;playlist image not found
				{
					;create the playlist
					MouseMove, 1050, 230
					Click
					sleep 150
					Click, 720, 320
					clipboard := playlist_name
					SendInput {Ctrl Down}v{Ctrl up}{Enter}
					Sleep, 1000
					SendInput, {Ctrl Down}w{Ctrl up}
					return
				}
				else if(ErrorLevel = 1) ; not found yet
				{
					Sleep, 1000
					continue
				}
				else ; found the 3 dots
				{

					MouseMove % 1130, FoundY + 20
					Click
					sleep, 50
					SendInput, {Ctrl Down}w{Ctrl up}
					break
				}
			}

			MouseMove, %xpos%, %ypos%
			Return
		}