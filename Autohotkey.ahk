#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode 2 ; Match strings anywhere in WinTitle
#Include %A_ScriptDir%\OnWin.ahk ; https://www.autohotkey.com/boards/viewtopic.php?t=6463
EnvGet, EDITOR, EDITOR ; Get EDITOR from environment variables
; EDITOR="C:\Users\hovis\AppData\Local\Programs\Vim\vim81\gvim.exe"

Menu, Tray, Tip, Hovis's main ahk shtupf

TrayTip, Autohotkey, Started!, 0.5

Test(this)
{
        static window
        event := this.Event, window := this.WinTitle
}

; Use ^j and ^k for next/previous when using Keypiranha
#if WinActive("ahk_class keypirinha_wndcls_run")
^j::Send {Down}
^k::Send {Up}
#if

; Modifier keys reference https://www.autohotkey.com/docs/Hotkeys.htm
;  #: Super (Win)
;  +: Shift
;  ^: Control
;  !: Meta (Alt)
;  

!Numpad2::Send {Volume_Down}
!Numpad4::Send {Media_Prev}
!Numpad5::Send {Media_Play_pause}
!Numpad6::Send {Media_Next}
!Numpad8::Send {Volume_Down}

ListLines

^!+4::
Send {LButton Down}
Return

; Ctrl+Alt+Shift A
; Open this file in %EDITOR%
^!+a::
Run, %EDITOR% "%A_ScriptFullPath%"
Return

Launch_App2::
SetTitleMatchMode Regex
IfWinNotExist ^Calculator
{
        TrayTip "launching calculator"
	Run calc.exe
	Winwait ^Calculator
	WinActivate ^Calculator
}
Else WinActivate ^Calculator
Return

^!+c::
SetTitleMatchMode Regex
IfWinExist HiringThing.*Calendar
{
 	Winwait, HiringThing.*Calendar,, 3
        if ErrorLevel
        {
                MsgBox, WinWait timed out.
                return
        }
        Else WinActivate HiringThing.*Calendar
}
Else
{
 	Run "C:\Program Files (x86)\Google\Chrome\Application\chrome_proxy.exe"  --profile-directory="Profile 1" --app-id=kjbdgfilnfhdoflbpgamdcdgpehopbep
 	Winwait, HiringThing.*Calendar,, 3
        if ErrorLevel
        {
                MsgBox, WinWait timed out.
                return
        }
        Else WinActivate HiringThing.*Calendar
}
Return

^!+t::
IfWinExist ahk_class CASCADIA_HOSTING_WINDOW_CLASS
{
 	Winwait, ahk_class CASCADIA_HOSTING_WINDOW_CLASS,, 3
        if ErrorLevel
        {
                MsgBox, WinWait timed out.
                return
        }
        Else WinActivate ahk_class CASCADIA_HOSTING_WINDOW_CLASS
}
Else
{
 	Run "C:\Users\hovis\Desktop\Windows Terminal Preview - Shortcut.lnk"
 	Winwait, ahk_class CASCADIA_HOSTING_WINDOW_CLASS,, 3
        if ErrorLevel
        {
                MsgBox, WinWait timed out.
                return
        }
        Else WinActivate ahk_class CASCADIA_HOSTING_WINDOW_CLASS
}
Return

^!+m::
SetTitleMatchMode 2
IfWinExist YouTube Music
{
        WinActivate YouTube Music
}
Else
{
 	Run "C:\Program Files\FirefoxPWA\firefoxpwa.exe" site launch 01FTRJ34R2W5693APTNBSZKR39
 	Winwait YouTube Music
 	WinActivate YouTube Music
}
Return

; Valheim repeat-y tricks
^!+r::
while (getKeyState("r", "P"))
{
        send, r
        sleep, 1
}
return


#+g::
WinGetClass, class, A
WinGetTitle, title
WinGetActiveTitle, activetitle
active = WinActive("ahk_class Vim")
MsgBox, The active window's class is "%class%", title: "%title%", activetitle: "%activetitle%", A_ScriptName: "%A_ScriptName%". A_ScriptName is active: WinActive(%A_ScriptName%)
Return

; Detect this file being written in vim (send the characters through transparently)
; Try to reload this script, if it doesn't load show an error dialog.
:*:`:w`n::
Send, `:w`n
IfWinActive %A_ScriptName%
{
    TrayTip, Autohotkey, %A_ScriptFullPath%, 2
    Reload
        Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
        MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
        IfMsgBox, Yes, Run, %EDITOR% %A_ScriptFullPath%
        return
}
Return

; Shift F2, Shift F3 switch to first and second desktops (or move left and right, really)
; *+F2::Send, {LWinDown}{CtrlDown}{Left}{CtrlUp}{LWinUp}
; *+F3::Send, {LWinDown}{CtrlDown}{Right}{CtrlUp}{LWinUp}

^!+w::
TrayTip, testing, Switched to G930 headphones, 0.5
Run, mmsys.cpl
WinWait,Sound ; Change "Sound" to the name of the window in your local language
ControlSend,SysListView321,{Down 1} ; This number selects the matching audio device in the list, change it accordingly
ControlClick,&Set Default ; Change "&Set Default" to the name of the button in your local language
ControlClick,OK
Return

^!+q::
Run, mmsys.cpl
WinWait,Sound ; Change "Sound" to the name of the window in your local language
ControlSend,SysListView321,{Down 3} ; This number selects the matching audio device in the list, change it accordingly
ControlClick,&Set Default ; Change "&Set Default" to the name of the button in your local language
ControlClick,OK
TrayTip, Sound, Switched to Realtek speakers, 0.5
Return


^+F1:: ; Ctrl+Shift+F1, move current window to Virtual Desktop 1
Send #{Tab} ; Super+Tab
MouseGetPos saveX, saveY
sleep 500
SendEvent {Click 100 200 Down}{Click 75 75 Up}{Click}
MouseMove saveX, saveY
Return

^+F2:: ; Ctrl+Shift+F2, move current window to Virtual Desktop 2
Send #{Tab} ; Super+Tab
MouseGetPos saveX, saveY
sleep 500
SendEvent {Click 100 200 Down}{Click 275 100 Up}{Click}
MouseMove saveX, saveY
Return

+Backspace::
; Minecraft fishing while multitasking
; Leave your cursor in MC, leave your bobber in the water,
; and make Minecraft your last active window.

;Send !{Tab} ; Alt+tab
;sleep 75
;Click, Right
;sleep 450
;Click, Right
;sleep 25
;Send !{Tab}
;Return
;
;^+Backspace::
WinActivate Minecraft
WinGetPos Minecraft, X, Y, Width, Height
Click, Right, Width/2, Height/2
sleep 450
Click, Right, Width/2, Height/2
sleep 25
Send !{Tab}
Return
