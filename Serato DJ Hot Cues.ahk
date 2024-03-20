#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Client

;VARs

hotcues := [[140,130],[240,130],[340,130],[440,130],[140,175],[240,175],[340,175],[440,175]]
colours := [[11,7],[34,7],[55,7]		;[1,2,3]	red,dark orange,orange
			,[11,21],[34,21],[55,21]	;[4,5,6]	yellow,light green, dark green
			,[11,35],[34,35],[55,35]	;[7,8,9]	green,dull green,???
			,[11,49],[34,49],[55,49]	;[10,11,12]	cyan,light blue,dark blue
			,[11,63],[34,63],[55,63]	;[13,14,15]	blue,dull purple,purple
			,[11,76],[34,76],[55,76]]	;[16,17,18]	pink,dark pink,light red
last_accessed := 0
rec_toggle := True


Run, "C:\Program Files\Serato\Serato DJ Pro\Serato DJ Pro.exe"
Sleep 5000

Loop
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

^Esc::
{
	ExitApp, 0
}


#IfWinActive ahk_class Qt5QWindowOwnDCIcon
;HOT CUES
1::
{
	hotcue_exec(1)
	return
}
2::
{
	hotcue_exec(2)
	return
}
3::
{
	hotcue_exec(3)
	return
}
4::
{
	hotcue_exec(4)
	return
}
5::
{
	hotcue_exec(5)
	return
}
6::
{
	hotcue_exec(6)
	return
}
7::
{
	hotcue_exec(7)
	return
}
8::
{
	hotcue_exec(8)
	return
}

y::
;Dark Green
{
	change_colour(6,"y")
	return
}
x::
;Green
{
	change_colour(7,"x")
	return
}
c::
;Blue
{
	change_colour(13,"c")
	return
}
v::
;Light Orange
{
	change_colour(3,"v")
	return
}
b::
;Orange
{
	change_colour(2,"b")
	return
}
n::
;yellow
{
	change_colour(4,"n")
	return
}
m::
;red
{
	change_colour(1,"m")
	return
}
,::
;Pink
{
	change_colour(16,",")
	return
}
.::
;Purple
{
	change_colour(15,".")
	return
}

;Confirm Deletion
^del::
{
	MsgBox, 4, Warning, Are you sure you want to delete the selected songs/crates?
	IfMsgBox, Yes
		{
			SendInput, ^{del}
		}
	return
}

;Toggle prefered recording settings
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

::br::Breakcore
::dn::DnB
::dnb::DnBnB
::ldnb::Liquid DnB
::meld::Melodic DnB

::com::Complextro

::clr::Colour Bass
::dub::Dubstep
::rid::Riddim
::ter::Tearout
::ff::Future Funk
::gar::Garage

::dish::Disco House
::fr::French House
::gh::Ghetto House
::lof::Lofi House
::melh::Melodic House
::ph::Piano House
::sol::Soulful House

::no::Normie
::om::Omnigenre
::Tc::Techno
::tr::Trance


;FUNCTIONS
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


AddGenre(genre)
{
	Clipboard := ""
	MouseGetPos, PosX, PosY
	Click, 800 %PosY% 2
	Sleep, 100
	SendInput, ^c
	ClipWait, 2
	genreArray := StrSplit(Clipboard, ", ")
	if(!hasValue(genreArray, genre))
	{
		genreArray.Push(genre)
	}
	Str := ""
	For Index, Value In genreArray
		Str .= ", " . Value
	Str := LTrim(Str, ", ") ; Remove leading pipes (|)
	;SendInput, ^a
	SendInput, %Str%
	SendInput, {Enter}
	MouseMove, %PosX%, %PosY%
	return
}

hasValue(haystack, needle) {
    if(!isObject(haystack))
        return false
    if(haystack.Length()==0)
        return false
    for k,v in haystack
        if(v==needle)
            return true
    return false
}

