#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Client
;Variables-----------------------------------------------------------------------------------------------------------------------------------
hotcues := [[140,130],[240,130],[340,130],[440,130],[140,175],[240,175],[340,175],[440,175]]
colours := {red:[11,7],			dark_orange:[34,7],		orange:[55,7]
			,yellow:[11,21],	light_green:[34,21],	dark_green:[55,21]
			,green:[11,35],		dull_green:[34,35],		greaaeean:[55,35]
			,cyan:[11,49],		light_blue:[34,49],		dark_blue:[55,49]
			,blue:[11,63],		dull_purple:[34,63],	purple:[55,63]
			,pink:[11,76],		dark_pink:[34,76],		pink_red:[55,76]}
last_accessed := 0
rec_toggle := True
;Auto-execute--------------------------------------------------------------------------------------------------------------------------------
Run, "C:\Program Files\Serato\Serato DJ Pro\Serato DJ Pro.exe"
Sleep 5000

Loop ;Checks every 3 seconds if Serato process exists. If not, then script exits.
{
	Process, Exist, Serato DJ Pro.exe
	{
		If ! ErrorLevel
		{
			ExitApp
		}
	}
	Sleep 3000
}
;Hotkeys-------------------------------------------------------------------------------------------------------------------------------------

;Exit Script
^Esc::
	ExitApp, 0
	return

#IfWinActive ahk_class Qt5QWindowOwnDCIcon
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

;Comfirm deletion
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
{	
	FormatTime, CurrentDateTime,, yyyy-MM-dd_HH-mm
	sleep 1000
	MouseGetPos, PosX, PosY 
	
	if(rec_toggle) ;rec
	{
		Click, 320, 15
		sleep 1000
		Click, 1177 420 2	
		SendInput %CurrentDateTime%
		SendInput {Esc}
	}
	else
	{
		Click, 1330 420
		sleep 350
		Click, 320, 15 ;rec
	}
	sleep 80
	
	Click, 1745 15 ;settings
	sleep 80
	
	Click, 800 55 ;dj perferences
	sleep 80
	Click, 710 135 ;lock playing deck
	sleep 80
	if(rec_toggle) ;stop time
	{
		SendEvent {Click 1140 210 Down}{Click 1140 178 Up}
	}
	else
	{
		SendEvent {Click 1140 210 Down}{Click 1140 300 Up}
	}
	sleep 80
	
	Click, 940 55 ;library + display
	sleep 80
	if(rec_toggle) ;deck bpm display
	{
		Click, 1077, 276
	}
	else
	{
		Click, 1077, 297
	}
	sleep 80
	Click, 1745 15 ;exit settings
	sleep 80
	
	MouseMove, %PosX%, %PosY%
	rec_toggle := !rec_toggle
	return
}

del::
{
	Click
	MouseGetPos, PosX, PosY
	Click, 540 %PosY% 2
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
	SendInput, %input%
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
	SendInput, %input%
	return
}