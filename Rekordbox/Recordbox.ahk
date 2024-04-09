#SingleInstance Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Client
FormatTime, CurrentDateTime,, yyyy-MM-dd_HH-mm

;Variables-----------------------------------------------------------------------------------------------------------------------------------
hotcues := []
colours := {}
last_accessed := 0
rec_toggle := True
hotcuePos := []
stage := 1
;Auto-execute--------------------------------------------------------------------------------------------------------------------------------
Run, "C:\Program Files\Pioneer\rekordbox 6.8.1\rekordbox.exe"
WinWait, ahk_exe rekordbox.exe
WinWaitActive, ahk_exe rekordbox.exe

Goto, init

init:
if !FileExist("settings.ini")
{
	Goto, rekordboxPixel
}
import_settings()

WinWaitActive, ahk_exe rekordbox.exe


WinWaitClose, ahk_exe rekordbox.exe
Exitapp
;Hotkeys-------------------------------------------------------------------------------------------------------------------------------------

;Exit Script
^Esc::
	ExitApp, 0
	return

#IfWinActive ahk_exe rekordbox.exe
f1::
	suspend
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
Numpad1::
	change_colour("yellow")
	return

;Functions-----------------------------------------------------------------------------------------------------------------------------------
hotcue_exec(input)
{
	global last_accessed
	SendInput, {%input% down}
    Sleep, 50
    SendInput, {%input% up}
	last_accessed := input
	return
}

change_colour(colour)
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
	sleep 150
	MouseMove, %offsetX%, %offsetY%
	sleep 150
	SendEvent {Click down}
	sleep 150
	SendEvent {Click up}
	MouseMove, %PosX%, %PosY%
	return
}

import_settings()
{
	global hotcues
	global colours
	FileRead, settings, settings.ini
	settings := StrSplit(settings,",")	
	hotcue1 := [settings.1,settings.2]
	hotcue8 := [settings.3,settings.4]
	colour_delta := [settings.5,settings.6]
	
	colour_middleX := colour_delta.1 // 2
	colour_middleY := colour_delta.2 // 2
	
	xhotdelta := (hotcue8.1 - hotcue1.1) / 7
	loop, 8{
		x := hotcue1.1 + Floor((A_Index-1) * xhotdelta)
		hotcues[A_Index] := [x, hotcue1.2]
	}
	
	deltahalf := colour_delta.1 / 10.0
	deltafull := colour_delta.1 / 5.0
	xdelta := []
	ydelta := []
	loop, 4
	{
		xdelta[A_Index] := Floor(colour_middleX -deltahalf + deltafull * (A_Index - 2))
		ydelta[A_Index] := Floor(colour_middleY + deltafull * (A_Index - 3))
	}
	
	colours["pink"] := [xdelta.1,ydelta.1]
	colours["purple"] := [xdelta.2,ydelta.1]
	colours["dull_purple"] := [xdelta.3,ydelta.1]
	colours["dull_blue"] := [xdelta.4,ydelta.1]
	colours["blue"] := [xdelta.1,ydelta.2]
	colours["light_blue"] := [xdelta.2,ydelta.2]
	colours["cyan"] := [xdelta.3,ydelta.2]
	colours["dark_cyan"] := [xdelta.4,ydelta.2]
	colours["cyan_green"] := [xdelta.1,ydelta.3]
	colours["green"] := [xdelta.2,ydelta.3]
	colours["light_yellow"] := [xdelta.3,ydelta.3]
	colours["yellow"] := [xdelta.4,ydelta.3]
	colours["dark_yellow"] := [xdelta.1,ydelta.4]
	colours["orange"] := [xdelta.2,ydelta.4]
	colours["red"] := [xdelta.3,ydelta.4]
	colours["dark_pink"] := [xdelta.4,ydelta.4]
	return
}
;Settings-creator----------------------------------------------------------------------------------------------------------------------------
rekordboxPixel:
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
Gui, Add, Text, , % "Please load up any song onto Deck 1."
Gui, Add, Button, Default x10 w80, Done
Gui, Show, AutoSize
return

ButtonDone:
Gui, Destroy
Gui,+AlwaysOnTop
Gui, Font, s13
Gui, Add, Text, , % "Next, (left)click in the middle of hotcue A`nAfter that, do the same with hotcue H."
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
if WinActive("ahk_exe rekordbox.exe"){
	MouseGetPos, PosX, PosY
	switch stage
	{
		case 1:
			hotcuePos[1] := PosX
			hotcuePos[2] := PosY
			MsgBox, 4, ,% "Your coordinates for hotcue A are X:"hotcuePos.1 " Y:" hotcuePos.2 "`nAre these right? (Press No to retry)"
			IfMsgBox, Yes
			{
				stage := 2
			}
			Goto, ButtonI'mReady
			return
		case 2:
			hotcuePos[3] := PosX
			hotcuePos[4] := PosY
			MsgBox, 4, ,% "Your coordinates for hotcue H are X:"hotcuePos.3 " Y:" hotcuePos.4 "`nAre these right? (Press No to retry)"
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
Gui, Add, Text, , % "Next, (right)click one of the hotcues, bringing out the colour selector`nAfter that, (left)click the right lower corner."
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
if WinActive("ahk_exe rekordbox.exe"){
	MouseGetPos, PosX, PosY
	KeyWait, LButton, D
	SendEvent {Click Left Up}
	Click, left up
	MouseGetPos, deltaX, deltaY
	deltaX := deltaX - PosX
	deltaY := deltaY - PosY
	MsgBox, 4, ,% "The colour window size is [X,Y]:[" deltaX ":" deltaY "]`nThe expected ratio is " 123/127 " (123:127). The actual ratio is " deltaX/deltaY ".`nAn error of 0.05 is acceptable.`nAre these values right? (Press No to retry)"
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