#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
CoordMode, Mouse, Client
CoordMode, Pixel, Client

;Variables------------------------------------------------------------------------------------------------------------------------------------------------------------
extra_pixels := 30

;Auto-execute---------------------------------------------------------------------------------------------------------------------------------------------------------
WinWait, ahk_exe waterfox.exe
WinWaitActive, ahk_exe waterfox.exe
WinWaitClose, ahk_exe JDownloader2.exe
ExitApp, 0 
;Hotkeys--------------------------------------------------------------------------------------------------------------------------------------------------------------

;Exit Script
^Esc::
	ExitApp, 0
	return
	
^e::
	Run, "C:\Program Files\Waterfox\private_browsing.exe" "https://forums.e-hentai.org/index.php?act=Reg&CODE=00"
	WinWait, ahk_exe waterfox.exe
	WinActivate, ahk_exe waterfox.exe
	Sleep, 5000
	WinGetPos, X, Y, W, H, ahk_exe waterfox.exe
	ImageSearch, FoundX, FoundY, 0, 0, W, H, rect.png
	MouseMove, %FoundX%, %FoundY%
	Click
	Sleep, 550
	
	ImageSearch, FoundX, FoundY, 0, 0, W, H, reg.png
	MouseMove, %FoundX%, %FoundY%
	Click
	Sleep, 550
	
	InputBox, Code, Enter Code, Please Image Code:, , 300, 150
	
	WinActivate, ahk_exe waterfox.exe
	name_pass := pseudo_random_word()
	
	ImageSearch, FoundX, FoundY, 0, 0, W, H, img.png
	MouseMove % FoundX, FoundY + extra_pixels
	Click
	Sleep, 50
	SendInput % Code
	
	ImageSearch, FoundX, FoundY, 0, 0, W, H, logi.png
	MouseMove % FoundX, FoundY + extra_pixels
	Click
	Sleep, 50
	SendInput % name_pass
	
	ImageSearch, FoundX, FoundY, 0, 0, W, H, disp.png
	MouseMove % FoundX, FoundY + extra_pixels
	Click
	Sleep, 50
	SendInput % name_pass
	
	ImageSearch, FoundX, FoundY, 0, 0, W, H, ur ps.png
	MouseMove % FoundX, FoundY + extra_pixels
	Click
	Sleep, 50
	SendInput % name_pass
	SendInput % name_pass
	
	ImageSearch, FoundX, FoundY, 0, 0, W, H, cf ps.png
	MouseMove % FoundX, FoundY + extra_pixels
	Click
	Sleep, 50
	SendInput % name_pass
	SendInput % name_pass
	
	ImageSearch, FoundX, FoundY, 0, 0, W, H, ur e.png
	MouseMove % FoundX, FoundY + extra_pixels
	Click
	Sleep, 50
	SendInput % name_pass
	SendInput {RAW}@gmail.com
	
	ImageSearch, FoundX, FoundY, 0, 0, W, H, cf e.png
	MouseMove % FoundX, FoundY + extra_pixels
	Click
	Sleep, 50
	SendInput % name_pass
	SendInput {RAW}@gmail.com
	SendInput {Enter}
	Sleep, 50
	
	ImageSearch, FoundX, FoundY, 0, 0, W, H, sub.png
	MouseMove % FoundX, FoundY + extra_pixels
	Click
	return

#IfWinActive ahk_exe waterfox.exe


;Functions------------------------------------------------------------------------------------------------------------------------------------------------------------
pseudo_random_word()
{
	word := 0
	while (word < 10000000)
	{
		Random, rand, 1, 1000000000
		word := word + rand
	}
	word := word "s"
	clipboard := word
	return word
}