#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
CoordMode, Mouse, Client
CoordMode, Pixel, Client

;Variables------------------------------------------------------------------------------------------------------------------------------------------------------------

;Auto-execute---------------------------------------------------------------------------------------------------------------------------------------------------------
WinWait, ahk_exe  firefox.exe
 
WinWaitActive, ahk_exe firefox.exe
WinWaitClose, ahk_exe firefox.exe
ExitApp, 0 
;Hotkeys--------------------------------------------------------------------------------------------------------------------------------------------------------------

;Exit Script
^Esc::
	ExitApp, 0
	return

#IfWinActive ahk_exe firefox.exe

^I::
{
	clicked := true
	
	while clicked
	{
		clicked := false
		WinGetPos, X, Y, W, H, ahk_exe firefox.exe
		ImageSearch, FoundX, FoundY, 0, 0, W, H, the_image.png
		
		if ErrorLevel
		{
			ImageSearch, FoundX, FoundY, 0, 0, W, H, report.png
			if not ErrorLevel
			{
				SendEvent, {Esc}
				Sleep, 500
			}
			else
			{
				break
			}
		}
		
		clicked := true
		MouseMove, %FoundX%, %FoundY%
		Click
		Sleep, 750
		ImageSearch, FoundX, FoundY, 0, 0, W, H, click1.png
		MouseMove % FoundX + 10 , FoundY - 5
		Click
		Sleep, 250
	}	
	
}

^O::
{
	clicked := true
	
	while clicked
	{
		clicked := false
		WinGetPos, X, Y, W, H, ahk_exe firefox.exe
		ImageSearch, FoundX, FoundY, 0, 0, W, H, mix.png
		
		if ErrorLevel
		{
			break
		}
		
		clicked := true
		MouseMove, %FoundX%, %FoundY%
		Click
		Sleep, 550
		ImageSearch, FoundX, FoundY, 0, 0, W, H, mix_ignore.png
		MouseMove % FoundX + 10 , FoundY + 5
		Click
		Sleep, 250
	}	
	
}

;Functions------------------------------------------------------------------------------------------------------------------------------------------------------------