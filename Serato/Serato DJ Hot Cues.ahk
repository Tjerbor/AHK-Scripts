#SingleInstance Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Client
CoordMode, Pixel, Client
FormatTime, CurrentDateTime,, yyyy-MM-dd_HH-mm

;Variables-----------------------------------------------------------------------------------------------------------------------------------
hotcues := []
colours := {}
last_accessed := 0
hotcue_text_offset := 0
rec_toggle := True
hotcuePos := []
stage := 1
the_sound := False

Quantize := [167, 15]
EQ := [473, 15]

;Record Settings
RecBtn := [320, 15]
RecName := [1177, 420]
RecSave := [1330, 420]
Settings := [1745, 15]
DJ_perferences := [800, 55]
lock_playing_deck := [710, 135]
stop_time_on := [1140, 210, 1140, 178]
stop_time_off := [1140, 210, 1140, 420]
library_display := [940, 55]
one_decimal := [1077, 276]
two_decimal := [1077, 297]
;Auto-execute--------------------------------------------------------------------------------------------------------------------------------
Run, "C:\Program Files\Serato\Serato DJ Pro\Serato DJ Pro.exe"
WinWait, ahk_class Qt5QWindowOwnDCIcon
WinWaitActive, ahk_class Qt5QWindowOwnDCIcon

Goto, init

init:
if !FileExist("settings.ini")
{
	Goto, seratoPixel
}
import_settings()

Loop, 5
{
	if WinActive(ahk_class Qt5QWindowOwnDCIcon)
	{	
		MouseGetPos, PosX, PosY
		if (check_for_colour(EQ.1, EQ.2,"0x0067A9", 7, 3))
		{
			Click % EQ.1 " " EQ.2
		}
		if (not check_for_colour(Quantize.1, Quantize.2,"0x0067A9", 7, 3))
		{
			Click % Quantize.1 " " Quantize.2
		}
		MouseMove, %PosX%, %PosY%
	}
	sleep 3000
}

WinWaitActive, ahk_class Qt5QWindowOwnDCIcon
MouseGetPos, PosX, PosY
if (check_for_colour(EQ.1, EQ.2,"0x0067A9", 7, 3))
{
	Click % EQ.1 " " EQ.2
}
if (not check_for_colour(Quantize.1, Quantize.2,"0x0067A9", 7, 3))
{
	Click % Quantize.1 " " Quantize.2
}
MouseMove, %PosX%, %PosY%

;If Serato is closed, script exits.
WinWaitClose, ahk_exe Serato DJ Pro.exe
Exitapp
;Hotkeys-------------------------------------------------------------------------------------------------------------------------------------

;Exit Script
^Esc::
	ExitApp, 0
	return

#IfWinActive ahk_class Qt5QWindowOwnDCIcon
f1::
	suspend
	the_sound := not the_sound
	if(the_sound) 	;Pause
	{
		Soundplay, %A_WorkingDir%\KERO_Impulse.mp3
	}
	else			;ENGANE
	{
		Soundplay, %A_WorkingDir%\KERO_Yoink.mp3
	}
	return
	
!Space::
	SendInput, !{Space}
	return

^g::
	SendEvent % "{Click " RecBtn.1 " " RecBtn.2 " Down}{Click " RecBtn.1 " " RecBtn.2 " Up}"
	return


;HOT CUES
1::
	hotcue_exec(1)
	return
2::
	hotcue_exec(2)
	return
3::
	hotcue_exec(3)
	return
4::
	hotcue_exec(4)
	return
5::
	hotcue_exec(5)
	return
6::
	hotcue_exec(6)
	return
7::
	hotcue_exec(7)
	return
8::
	hotcue_exec(8)
	return

;Change colour of most recently used hotcue
y::
	change_colour("dark_green","y")
	return
x::
	change_colour("green","x")
	return
c::
	change_colour("blue","c")
	return
v::
	change_colour("orange","v")
	return
b::
	change_colour("dark_orange","b")
	return
n::
	change_colour("yellow","n")
	return
m::
	change_colour("red","m")
	return
,::
	change_colour("pink",",")
	return
.::
	change_colour("purple",".")
	return
	
;Change Text of most recently used hotcue
Space & c::
	change_text("4 Bars")
	return

Space & v::
	change_text("Vocal")
	return
	
Space & b::
	change_text("Break")
	return
	
; 3 Beat Loop
!L::
	SetKeyDelay, 100, 100
	MouseGetPos, PosX, PosY
	Loop, 7
	{
		SendEvent {Click 760 157}
	}
	Loop, 2
	{
		SendEvent {Click 502 157}
	}
	SendEvent {Click 75 172}
	SendEvent {Click 543 157}
	SendEvent {Click 253 109}
	SendEvent {O}
	Loop, 3
	{
		SendEvent {Click 702 176}
	}
	SendEvent {P}
	SendEvent {Click 253 109}
	sleep 10
	SendEvent {Click 253 109}
	SendInput, 3 Beat Loop
	sleep 20
	SendInput {Enter}
	SendEvent {Click 443 110}
	SendEvent {Click 75 110}
	Loop, 2
	{
		SendEvent {Click 760 157}
	}
	SendEvent {Click 720 157}
	MouseMove, %PosX%, %PosY%
	SetKeyDelay, -1, -1 , -1
	return

;Comfirm deletion
!del::
^del::
{
	MsgBox, 4, Warning, Are you sure you want to delete the selected songs/crates?
	IfMsgBox, Yes
		{
			SendInput, ^{del}
		}
	return
}

;Toggle preferred recording settings
!r::
{	MouseGetPos, PosX, PosY 
	if (check_for_colour(Settings.1, Settings.2,"0x0067A9", 7, 3))
	{
		Click % Settings.1 " " Settings.2 ;settings
		sleep 500
	}
	
	if(rec_toggle) ;Turn Recording Settings on
	{
		if (not check_for_colour(RecBtn.1, RecBtn.2,"0x0067A9", 7, 3))
		{
			SendEvent % "{Click " RecBtn.1 " " RecBtn.2 " Down}{Click " RecBtn.1 " " RecBtn.2 " Up}"
			sleep 1000
		}
		Click % RecName.1 " " RecName.2 " " 2
		SendInput %CurrentDateTime%
		SendInput {Esc}
		
		sleep 80
	
		Click % Settings.1 " " Settings.2 ;settings
		sleep 80
		
		Click % DJ_perferences.1 " " DJ_perferences.2 ;dj perferences
		sleep 80
		if (not check_for_colour(lock_playing_deck.1, lock_playing_deck.2,"0x000000", 5, 0))
		{
			Click % lock_playing_deck.1 " " lock_playing_deck.2 ;lock playing deck
			sleep 80
		}
		
		SendEvent % "{Click " stop_time_off.1 " " stop_time_off.2 " Down}{Click " stop_time_off.3 " " stop_time_off.4 " Up}"
		SendEvent % "{Click " stop_time_on.1 " " stop_time_on.2 " Down}{Click " stop_time_on.3 " " stop_time_on.4 " Up}"
		sleep 80
		
		Click % library_display.1 " " library_display.2 ;library + display
		sleep 80
		
		Click % one_decimal.1 " " one_decimal.2 ;deck bpm display
	}
	;------------------------------------------
	else ;Turn Recording Settings off
	{
		if (check_for_colour(RecBtn.1, RecBtn.2,"0x0067A9", 7, 3))
		{
			Click % RecSave.1 " " RecSave.2
			sleep 350
			SendEvent % "{Click " RecBtn.1 " " RecBtn.2 " Down}{Click " RecBtn.1 " " RecBtn.2 " Up}"
			sleep 80
		}
	
		Click % Settings.1 " " Settings.2 ;settings
		sleep 80
		
		Click % DJ_perferences.1 " " DJ_perferences.2 ;dj perferences
		sleep 80
		if (check_for_colour(lock_playing_deck.1, lock_playing_deck.2,"0x000000", 5, 0))
		{
			Click % lock_playing_deck.1 " " lock_playing_deck.2 ;lock playing deck
			sleep 80
		}
		
		SendEvent % "{Click " stop_time_off.1 " " stop_time_off.2 " Down}{Click " stop_time_off.3 " " stop_time_off.4 " Up}"
		sleep 80
		
		Click % library_display.1 " " library_display.2
		sleep 80
		
		Click % two_decimal.1 " " two_decimal.2 ;deck bpm display
	}
	
	sleep 80
	Click % Settings.1 " " Settings.2 ;exit settings
	sleep 80
	
	MouseMove, %PosX%, %PosY%
	rec_toggle := !rec_toggle
	return
}

del::
{
	Click
	MouseGetPos, PosX, PosY
	;Click, 540 %PosY% 2
	SendEvent, {Click 540 %PosY%}
	SendEvent, {Click 540 %PosY%}
	Sleep, 200
	SendInput, Delete
	SendInput, {Enter}
	MouseMove, %PosX%, %PosY%
	return
}

;::bpm::BPMCHANGE
;Functions-----------------------------------------------------------------------------------------------------------------------------------
hotcue_exec(input)
{
	global hotcues
	global last_accessed
	;SendInput, %input%
	last_accessed := input
	MouseGetPos, PosX, PosY
	X := hotcues[input].1
	Y := hotcues[input].2
	Click, %X% %Y%
	MouseMove, %PosX%, %PosY%
	return
}

change_colour(colour,input)
{
	global hotcues
	global last_accessed
	global colours
	MouseGetPos, PosX, PosY
	lastX := hotcues[last_accessed].1
	lastY := hotcues[last_accessed].2
	offsetX := lastX + colours[colour].1
	offsetY := lastY + colours[colour].2
	Click, %lastX% %lastY% right
	Click, %offsetX% %offsetY%
	MouseMove, %PosX%, %PosY%
	;SendInput, %input%
	return
}

change_text(text)
{
	global hotcues
	global last_accessed
	global colours
	global hotcue_text_offset
	MouseGetPos, PosX, PosY
	lastX := hotcues[last_accessed].1
	lastY := hotcues[last_accessed].2
	offsetY := lastY - hotcue_text_offset
	Click, %lastX% %offsetY% 2
	sleep 20
	SendInput % text
	SendInput {Enter}
	MouseMove, %PosX%, %PosY%
	return
}

check_for_colour(X,Y,colour,width,error_margin)
{
	PixelSearch, Px, Py, % X - width, % Y - width, % X + width, % Y + width, %colour%, %error_margin%, Fast RGB
	if ErrorLevel
	{
		return false
	}
	return true
}

import_settings()
{
	global hotcues
	global colours
	global hotcue_text_offset
	FileRead, settings, settings.ini
	settings := StrSplit(settings,",")	
	hotcue1 := [settings.1,settings.2]
	hotcue8 := [settings.3,settings.4]
	colour_delta := [settings.5,settings.6]
	
	hotcue_text_offset := Floor((hotcue8.2 - hotcue1.2) / 2)
	
	xhotdelta := (hotcue8.1 - hotcue1.1) / 3
	loop, 4{
		x := hotcue1.1 + Floor((A_Index-1) * xhotdelta)
		hotcues[A_Index] := [x, hotcue1.2]
		hotcues[A_Index+4] := [x, hotcue8.2]
	}
	
	xdeltahalf := colour_delta.1 / 6.0
	xdeltafull := colour_delta.1 / 3.0
	xdelta := []
	loop, 3
	{
		xdelta[A_Index] := Floor(xdeltahalf + xdeltafull * (A_Index - 1))
	}
	
	ydeltahalf := colour_delta.2 / 12.0
	ydeltafull := colour_delta.2 / 6.0
	ydelta := []
	loop, 6
	{
		ydelta[A_Index] := Floor(ydeltahalf + ydeltafull * (A_Index - 1))
	}
	
	colours["red"] := [xdelta.1,ydelta.1]
	colours["dark_orange"] := [xdelta.2,ydelta.1]
	colours["orange"] := [xdelta.3,ydelta.1]
	colours["yellow"] := [xdelta.1,ydelta.2]	
	colours["light_green"] := [xdelta.2,ydelta.2]	
	colours["dark_green"] := [xdelta.3,ydelta.2]
	colours["green"] := [xdelta.1,ydelta.3]
	colours["dull_green"] := [xdelta.2,ydelta.3]		
	colours["greaaeean"] := [xdelta.3,ydelta.3]
	colours["cyan"] := [xdelta.1,ydelta.4]		
	colours["light_blue"] := [xdelta.2,ydelta.4]		
	colours["dark_blue"] := [xdelta.3,ydelta.4]
	colours["blue"] := [xdelta.1,ydelta.5]		
	colours["dull_purple"] := [xdelta.2,ydelta.5]	
	colours["purple"] := [xdelta.3,ydelta.5]
	colours["pink"] := [xdelta.1,ydelta.6]		
	colours["dark_pink"] := [xdelta.2,ydelta.6]		
	colours["pink_red"] := [xdelta.3,ydelta.6]
	return
}
;Settings-creator----------------------------------------------------------------------------------------------------------------------------
seratoPixel:
Gui,+AlwaysOnTop
Gui, Font, s13
Gui, Add, Text, , % "Hello this will only pop once to find the places for your custom resolution.`nDelete 'settings.ini' in the folder to reset the settings."
Gui, Add, Button, Default x10 w80, OK
Gui, Show, AutoSize
return

ButtonOK:
Gui, Destroy
Gui,+AlwaysOnTop
Gui, Font, s13
Gui, Add, Text, , % "Please load any song onto Deck 1.`nThen set the hot cue 1 and 8."
Gui, Add, Button, Default x10 w80, Done
Gui, Show, AutoSize
return

ButtonDone:
Gui, Destroy
Gui,+AlwaysOnTop
Gui, Font, s13
Gui, Add, Text, , % "Next, (left)click in the middle of the colour bar of hotcue 1`nAfter that, do the same with hotcue 8."
Gui, Add, Picture, , hotcue.png
Gui, Add, Button, Default x10 w80, I'mReady
Gui, Show, AutoSize
return

ButtonI'mReady:
global hotcuePos
global stage
Gui, Destroy
KeyWait, LButton, D
SendEvent {Click Left Up}
Click, left up
if WinActive("ahk_class Qt5QWindowOwnDCIcon"){
	MouseGetPos, PosX, PosY
	switch stage
	{
		case 1:
			hotcuePos[1] := PosX
			hotcuePos[2] := PosY
			MsgBox, 4, ,% "Your coordinates for hotcue 1 are X:"hotcuePos.1 " Y:" hotcuePos.2 "`nAre these right? (Press No to retry)"
			IfMsgBox, Yes
			{
				stage := 2
			}
			Goto, ButtonI'mReady
			return
		case 2:
			hotcuePos[3] := PosX
			hotcuePos[4] := PosY
			MsgBox, 4, ,% "Your coordinates for hotcue 8 are X:"hotcuePos.3 " Y:" hotcuePos.4 "`nAre these right? (Press No to retry)"
			IfMsgBox, Yes
			{
				Goto, hotcuecolours
			}
			Goto, ButtonI'mReady
			return
	}
}
Goto, ButtonI'mReady
return

hotcuecolours:
Gui, Destroy
Gui,+AlwaysOnTop
Gui, Font, s13
Gui, Add, Text, , % "Next, (right)click one of the hotcue colour bars, bringing out the colour selector`nAfter that, (left)click the white right lower corner."
Gui, Add, Picture, , colour.png
Gui, Add, Button, Default x10 w80, Let'sGo
Gui, Show, AutoSize
return

ButtonLet'sGo:
global hotcuePos
global stage
Gui, Destroy
KeyWait, RButton, D
SendEvent {Click Right Up}
if WinActive("ahk_class Qt5QWindowOwnDCIcon"){
	MouseGetPos, PosX, PosY
	KeyWait, LButton, D
	SendEvent {Click Left Up}
	Click, left up
	MouseGetPos, deltaX, deltaY
	deltaX := deltaX - PosX
	deltaY := deltaY - PosY
	MsgBox, 4, ,% "The colour window size is [X,Y]:[" deltaX ":" deltaY "]`nThe expected ratio is " 68/86 " (68:86). The actual ratio is " deltaX/deltaY ".`nAn error of 0.05 is acceptable.`nAre these values right? (Press No to retry)"
	IfMsgBox, Yes
	{
		hotcuePos[5] := deltaX
		hotcuePos[6] := deltaY
		Goto, saveValues
	}
	Goto, ButtonLet'sGo
	return
	}
Goto, ButtonLet'sGo
return

saveValues:
global hotcuePos
out := ""
for k, v in hotcuePos
    out.=","v
	
StringTrimLeft, out, out, 1
FileAppend, %out%,settings.ini
Goto, init
return

GuiEscape:
GuiClose:
exitapp
return