/*
 * * * Compile_AHK SETTINGS BEGIN * * *

[AHK2EXE]
Exe_File=%In_Dir%\Show Cursor Inside Notch Apps.exe
Alt_Bin=C:\Program Files\AutoHotkey\Compiler\AutoHotkeySC.bin
Compression=2
[VERSION]
Resource_Files=%In_Dir%\cursor.png
Set_Version_Info=1
File_Description=Show Cursor Inside Notch Apps
Inc_File_Version=0
Internal_Name=Show Cursor Inside Notch Apps
Legal_Copyright=Martin Winged
Product_Name=Show Cursor Inside Notch Apps
[ICONS]
Icon_1=%In_Dir%\cursor.ico

* * * Compile_AHK SETTINGS END * * *
*/

;-------------------------------------------------------------------------------
; APP NAME:     Show Cursor Inside Notch Apps
; DESCRIPTION:  This script shows fake mouse cursor when Notch .exe application
;			    is visible as Notch hides cursor by default
;
; CRAPTED BY:   Martin Winged
;-------------------------------------------------------------------------------

; 

#SingleInstance Force ; Only allows one instance of the script to run.
SetTitleMatchMode, 2 ; A window's title can contain WinTitle anywhere inside it to be a match
CoordMode, Mouse, Screen ; Check on what screen mouse is right now

cursor_image = %A_Temp%\cursor.png
FileInstall, cursor.png, %cursor_image%, 1

; Get screen resolution
SysGet, Monitor, Monitor, %A_Index%

; Set GUI color to black
Gui, Color, 000000
Gui, +E0x20 -Caption +LastFound +ToolWindow +AlwaysOnTop
; Add cursor picture to GUI
Gui, Add, Picture, x0 y0 h32 w32 vCursor, %cursor_image%
; Make black color transparent - only cursor will be visble
WinSet, TransColor, 000000

; Do every 10 milliseconds:
Loop
{
	if (WinExist("ahk_class DEMOLITIONWINDOW") & WinActive("ahk_class DEMOLITIONWINDOW")) {
		; If overlay is not visible and Notch .exe application is visible - show cursor overlay
		if (!WinExist("Show Cursor Inside Notch Apps")) {
			Gui, Show, NoActivate w%MonitorRight% h%MonitorBottom%, Show Cursor Inside Notch Apps
		}
	} else {
		; If overlay is visible and Notch .exe application is not visible - hide cursor overlay
		if (WinExist("Show Cursor Inside Notch Apps")) {
			Gui, Hide
		}
	}

	; Update cursor position - take coords from Windows's mouse
	MouseGetPos, xpos, ypos
	GuiControl, Move, Cursor, % "x" xpos - 14
	GuiControl, Move, Cursor, % "y" ypos + 10

	; Wait 10 milliseconds
	Sleep, 10
}