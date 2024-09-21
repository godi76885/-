; Initialization and Settings

Gui, +AlwaysOnTop
#NoEnv 
#persistent
#MaxThreadsPerHotkey 2
#KeyHistory 0
ListLines Off
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
CoordMode, Pixel, Screen
SoundBeep, 300, 200
SoundBeep, 400, 200

; Default Settings
PixelBox := 3
PixelSens := 65
PixelColor := 0xFEFE40
TapTime := 70
HoldKey := "Alt" ; Default Hold Key

; GUI Creation
; GUI Creation
Gui, Font, s10, Verdana ; Set font for the GUI

; Mode Selection Group
Gui, Add, GroupBox, x10 y10 w280 h130, TriggerBuff©
Gui, Add, Text, x20 y30, Select Mode:
Gui, Add, Button, x20 y50 w120 h30 gStayOn, Constant Clicking
Gui, Add, Button, x150 y50 w120 h30 gHoldMode, Hold Mode
Gui, Add, Button, x20 y90 w120 h30 gOffLoop, Turn Off
Gui, Add, Button, x150 y90 w120 h30 gTerminate, Exit Script


; Settings Group
Gui, Add, GroupBox, x10 y150 w280 h210, Settings
Gui, Add, Text, x20 y170, Pixel Box:
Gui, Add, Edit, x150 y170 w120 vPixelBox, %PixelBox%
Gui, Add, Text, x20 y200, Pixel Sensitivity:
Gui, Add, Edit, x150 y200 w120 vPixelSens, %PixelSens%
Gui, Add, Text, x20 y230, Pixel Color:
Gui, Add, Edit, x150 y230 w120 vPixelColor, %PixelColor%
Gui, Add, Text, x20 y260, Tap Time (ms):
Gui, Add, Edit, x150 y260 w120 vTapTime, %TapTime%
Gui, Add, Text, x20 y290, Hold Key:
Gui, Add, Edit, x150 y290 w120 vHoldKey, %HoldKey%
Gui, Add, Button, x90 y330 w150 h30 gApplySettings, Apply Settings

; Status Display
Gui, Add, Text, x10 y370 w280 vStatus, Status: Not started
Gui, Add, Text,, Toggle GUI with .
Gui, Show, w300 h410, AHK Script GUI
WinSet, Style, -0xC00000, AHK Script GUI



StayOn:
SoundBeep, 300, 200
GuiControl,, Status, Status: Constant Mode
settimer, loop2, off
settimer, loop1, 1
return

HoldMode:
SoundBeep, 300, 200
GuiControl,, Status, Status: Hold Mode
settimer, loop1, off
settimer, loop2, 1
return

OffLoop:
SoundBeep, 300, 200
GuiControl,, Status, Status: Turned Off
settimer, loop1, off
settimer, loop2, off
return

Terminate:
SoundBeep, 300, 200
SoundBeep, 200, 200
Sleep 400
exitapp

ApplySettings:
Gui, Submit, NoHide
return

loop1:
PixelSearch()
return

loop2:
If GetKeyState(HoldKey, "P"){
    PixelSearch()
}
return

#if toggle
*~$LButton::
sleep 1
While GetKeyState("LButton", "P"){
    Click
    sleep 1
}
return
#if

PixelSearch() {
    global PixelBox, PixelSens, PixelColor, TapTime
    PixelSearch, FoundX, FoundY, A_ScreenWidth/2-PixelBox, A_ScreenHeight/2-PixelBox, A_ScreenWidth/2+PixelBox, A_ScreenHeight/2+PixelBox, PixelColor, PixelSens, Fast RGB
    If !(ErrorLevel){
        If !GetKeyState("LButton"){
            click
            sleep TapTime
        }
    }
    return
}
.:: ; Hotkey for the ',' key
if (GuiVisible := !GuiVisible) ; Toggle the GuiVisible variable
    Gui, Show
else
    Gui, Hide
return