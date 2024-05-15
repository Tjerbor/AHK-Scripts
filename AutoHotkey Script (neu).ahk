#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
CoordMode, Mouse, Client
CoordMode, Pixel, Client

^Esc::
	exitapp
	return
;asd

^LButton::
	MouseGetPos, PosX, PosY
	MsgBox % check_for_colour(PosX, PosY, "0x000000")
	return

check_for_colour(X,Y,colour)
{
	clrs := {}
	PixelGetColor, clr, %X%, %Y% , Alt RGB
	clrs.Push(clr)
	PixelGetColor, clr, %X%, % Y - 5, Alt RGB
	clrs.Push(clr)
	PixelGetColor, clr, % X + 5, %Y% , Alt RGB
	clrs.Push(clr)
	PixelGetColor, clr, %X%, % Y + 5, Alt RGB
	clrs.Push(clr)
	PixelGetColor, clr, % X - 5, %Y% , Alt RGB
	clrs.Push(clr)
	
	;Concat := ""
	;For Each, Element In clrs {
	;If (Concat <> "") ; Concat is not empty, so add a line feed
	;	Concat .= "`n"
	;Concat .= Element
	;
	;}
	;MsgBox, %Concat%
	
	if (clrs.1 == colour or clrs.2 == colour or clrs.3 == colour or clrs.4 == colour or clrs.5 == colour)
	{
		return true
	}	
	return false
}