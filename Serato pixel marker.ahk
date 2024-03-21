#SingleInstance Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Client

hotcuePos := []
stage := 1

Gui,+AlwaysOnTop
;Gui, SeratoPixel:New
Gui, Font, s13
Gui, Add, Text, , % "Hello, this will only pop once to find the places for your custom resolution.`nDelete "settings.ini" in the folder to reset the settings."
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
Click, right up
if WinActive("ahk_class Qt5QWindowOwnDCIcon"){
	MouseGetPos, PosX, PosY
	KeyWait, LButton, D
	Click, left up
	MouseGetPos, deltaX, deltaY
	deltaX := deltaX - PosX
	deltaY := deltaY - PosY
	MsgBox, 4, ,% "The colour window size is [X,Y]:[" deltaX ":" deltaY "]`nThe expected ratio is " 68/86 " (68:86). The actual ratio is " deltaX/deltaY ".`nAn Error +-0.05 should be fine`nAre these values right? (Press No to retry)"
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
Goto, GuiEscape
return

GuiEscape:
GuiClose:
exitapp 
return

;#IfWinActive ahk_class Qt5QWindowOwnDCIcon
