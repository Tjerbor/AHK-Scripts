#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Client

;VARs
lastX := 0
lastY := 0
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
	SendInput, 1
	lastX := 140
	lastY := 130
	return
}
2::
{
	SendInput, 2
	lastX := 240
	lastY := 130
	return
}
3::
{
	SendInput, 3
	lastX := 340
	lastY := 130
	return
}
4::
{
	SendInput, 4
	lastX := 440
	lastY := 130
	return
}
5::
{
	SendInput, 5
	lastX := 140
	lastY := 175
	return
}
6::
{
	MouseGetPos, PosX, PosY
	Click, 240 175
	lastX := 240
	lastY := 175
	MouseMove, %PosX%, %PosY%
	SendInput, 6
	return
}
7::
{
	MouseGetPos, PosX, PosY
	Click, 340 175
	lastX := 340
	lastY := 175
	MouseMove, %PosX%, %PosY%
	SendInput, 6
	return
}
8::
{
	MouseGetPos, PosX, PosY
	Click, 440 175
	lastX := 440
	lastY := 175
	MouseMove, %PosX%, %PosY%
	SendInput, 6
	return
}

y::
;Dark Green
{
	MouseGetPos, PosX, PosY
	newX := lastX + 55
	newY := lastY + 20
	Click, %lastX% %lastY% right
	Click, %newX% %newY%
	MouseMove, %PosX%, %PosY%
	return
}
x::
;Green
{
	MouseGetPos, PosX, PosY
	newX := lastX + 10
	newY := lastY + 35
	Click, %lastX% %lastY% right
	Click, %newX% %newY%
	MouseMove, %PosX%, %PosY%
	SendInput, x
	return
}
c::
;Blue
{
	MouseGetPos, PosX, PosY
	newX := lastX + 10
	newY := lastY + 65
	Click, %lastX% %lastY% right
	Click, %newX% %newY%
	MouseMove, %PosX%, %PosY%
	SendInput, c
	return
}
v::
;Light Orange
{
	MouseGetPos, PosX, PosY
	newX := lastX + 55
	newY := lastY + 10
	Click, %lastX% %lastY% right
	Click, %newX% %newY%
	MouseMove, %PosX%, %PosY%
	SendInput, v
	return
}
b::
;Orange
{
	MouseGetPos, PosX, PosY
	newX := lastX + 30
	newY := lastY + 10
	Click, %lastX% %lastY% right
	Click, %newX% %newY%
	MouseMove, %PosX%, %PosY%
	SendInput, b
	return
}
n::
;yellow
{
	MouseGetPos, PosX, PosY
	newX := lastX + 10
	newY := lastY + 20
	Click, %lastX% %lastY% right
	Click, %newX% %newY%
	MouseMove, %PosX%, %PosY%
	SendInput, n
	return
}
m::
;red
{
	MouseGetPos, PosX, PosY
	newX := lastX + 10
	newY := lastY + 8
	Click, %lastX% %lastY% right
	Click, %newX% %newY%
	MouseMove, %PosX%, %PosY%
	SendInput, m
	return
}
,::
;Pink
{
	MouseGetPos, PosX, PosY
	newX := lastX + 10
	newY := lastY + 80
	Click, %lastX% %lastY% right
	Click, %newX% %newY%
	MouseMove, %PosX%, %PosY%
	SendInput, ,
	return
}
.::
;Purple
{
	MouseGetPos, PosX, PosY
	newX := lastX + 55
	newY := lastY + 65
	Click, %lastX% %lastY% right
	Click, %newX% %newY%
	MouseMove, %PosX%, %PosY%
	SendInput, .
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

;GENRE TAGS: Y COORDINATE OF MOUSE HAS TO BE THE SAME AS THE SELECTED SONG
;Numpad1::
;{
;	AddGenre("Bass House")
;	return
;}
;Numpad2::
;{
;	AddGenre("Colour House")
;	return
;}
;Numpad3::
;{
;	AddGenre("Deep House")
;	return
;}
;Numpad4::
;{
;	AddGenre("Future House")
;	return
;}
;Numpad5::
;{
;	AddGenre("Tech House")
;	return
;}
;Numpad6::
;{
;	AddGenre("Tech Core")
;	return
;}
;
;ins::
;{
;	Click
;	AddGenre("BPMCHANGE")
;	return
;}