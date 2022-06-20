@echo off
rem Author: Benjamin Temitope
rem Description: A command line interface to interact with MTN USB MODEM [ZTE MF 823]
rem Software Needed: Curl

setlocal EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)

set "_mainmenuTitle=ZTE MF 823 CLI"
set "_submenuTitle=Network Bearer Preference"
set "_colorBlue="09""
set "_colorRed="0C""
set "_colorGreen="0A""
set "_colorYellow="0E""
set "_colorWhite="07""

:MainMenu
cls
mode con cols=80 lines=32
color 07
title %_mainmenuTitle%

call  :colorText %_colorYellow% "    %_mainmenuTitle%"
echo.
echo.

echo     [1] Connect Network
echo     [2] Disconnect Network
echo     [3] Toggle Network (Disconnect and Connect)
echo     [4] Enable Automatic Connection
echo     [5] Set Network Bearer Preference (Auto/4G/3G/2G)
echo     [0] Exit
echo.
choice /C 123450 /N /M ">   Choose a menu option, or press 0 to Exit: "
set _option=%errorlevel%
if %_option%==1 (goto :action1)
if %_option%==2 (goto :action2)
if %_option%==3 (goto :action3)
if %_option%==4 (goto :action4)
if %_option%==5 (goto :submenu)
if %_option%==6 (exit)

goto :MainMenu

:action1
curl --header "Referer: http://192.168.0.1/index.html" "http://192.168.0.1/goform/goform_set_cmd_process?goformId=CONNECT_NETWORK"
echo.
pause
goto :MainMenu

:action2
curl --header "Referer: http://192.168.0.1/index.html" "http://192.168.0.1/goform/goform_set_cmd_process?goformId=DISCONNECT_NETWORK"
echo.
pause
goto :MainMenu

:action3
curl --header "Referer: http://192.168.0.1/index.html" "http://192.168.0.1/goform/goform_set_cmd_process?goformId=DISCONNECT_NETWORK"
echo.
curl --header "Referer: http://192.168.0.1/index.html" "http://192.168.0.1/goform/goform_set_cmd_process?goformId=CONNECT_NETWORK"
echo.
pause
goto :MainMenu

:action4
curl --header "Referer: http://192.168.0.1/index.html" "http://192.168.0.1/goform/goform_set_cmd_process?goformId=SET_CONNECTION_MODE&ConnectionMode=auto_dial"
echo.
pause
goto :MainMenu

:submenu
cls
mode con cols=80 lines=32
color 07
title %_submenuTitle% - %_mainmenuTitle%
call  :colorText %_colorWhite% "    %_submenuTitle% - "
call  :colorText %_colorYellow% " %_mainmenuTitle%"
echo.
echo.

call  :colorText %_colorWhite% "    [1] Default ( "
call  :colorText %_colorYellow% "Auto"
call  :colorText %_colorWhite% ") "
echo.

call  :colorText %_colorWhite% "    [2] WCDMA (prefer "
call  :colorText %_colorGreen% " 3G"
call  :colorText %_colorWhite% ") "
echo.

call  :colorText %_colorWhite% "    [3] GSM (prefer "
call  :colorText %_colorGreen% " 2G"
call  :colorText %_colorWhite% ") "
echo.

call  :colorText %_colorWhite% "    [4] Only LTE ( "
call  :colorText %_colorGreen% "4G"
call  :colorText %_colorWhite% " only) "
echo.

call  :colorText %_colorWhite% "    [5] Only WCDMA ( "
call  :colorText %_colorGreen% "3G"
call  :colorText %_colorWhite% " only) "
echo.

call  :colorText %_colorWhite% "    [6] Only GSM ( "
call  :colorText %_colorGreen% "2G"
call  :colorText %_colorWhite% " only) "
echo.

call  :colorText %_colorWhite% "    [7] LTE and WCDMA ( "
call  :colorText %_colorGreen% "4G"
call  :colorText %_colorWhite% " +"
call  :colorText %_colorGreen% " 3G"
call  :colorText %_colorWhite% ") "
echo.

call  :colorText %_colorWhite% "    [8] LTE and GSM ( "
call  :colorText %_colorGreen% "4G"
call  :colorText %_colorWhite% " +"
call  :colorText %_colorGreen% " 2G"
call  :colorText %_colorWhite% ") "
echo.

call  :colorText %_colorWhite% "    [9] WCDMA and GSM ( "
call  :colorText %_colorGreen% "3G"
call  :colorText %_colorWhite% " +"
call  :colorText %_colorGreen% " 2G"
call  :colorText %_colorWhite% ") "
echo.

echo     [0] Back to Main Menu
echo.
choice /C 1234567890 /N /M ">   Choose a menu option, or press 0 to Go back to main menu: "
set _option=%errorlevel%
if %_option%==1 (goto :subaction1)
if %_option%==2 (goto :subaction2)
if %_option%==3 (goto :subaction3)
if %_option%==4 (goto :subaction4)
if %_option%==10 (goto :mainmenu)

:subaction1
curl --header "Referer: http://192.168.0.1/index.html" "http://192.168.0.1/goform/goform_set_cmd_process?goformId=SET_BEARER_PREFERENCE&BearerPreference=NETWORK_auto "
echo.
pause
goto :submenu

:subaction2
curl --header "Referer: http://192.168.0.1/index.html" "http://192.168.0.1/goform/goform_set_cmd_process?goformId=SET_BEARER_PREFERENCE&BearerPreference=WCDMA_preferred  "
echo.
pause
goto :submenu

:subaction3
curl --header "Referer: http://192.168.0.1/index.html" "http://192.168.0.1/goform/goform_set_cmd_process?goformId=SET_BEARER_PREFERENCE&BearerPreference=GSM_preferred   "
echo.
pause
goto :submenu

:subaction4
curl --header "Referer: http://192.168.0.1/index.html" "http://192.168.0.1/goform/goform_set_cmd_process?goformId=SET_BEARER_PREFERENCE&BearerPreference=Only_LTE    "
echo.
pause
goto :submenu

:subaction5
curl --header "Referer: http://192.168.0.1/index.html" "http://192.168.0.1/goform/goform_set_cmd_process?goformId=SET_BEARER_PREFERENCE&BearerPreference=Only_WCDMA     "
echo.
pause
goto :submenu

:subaction6
curl --header "Referer: http://192.168.0.1/index.html" "http://192.168.0.1/goform/goform_set_cmd_process?goformId=SET_BEARER_PREFERENCE&BearerPreference=Only_GSM      "
echo.
pause
goto :submenu

:subaction7
curl --header "Referer: http://192.168.0.1/index.html" "http://192.168.0.1/goform/goform_set_cmd_process?goformId=SET_BEARER_PREFERENCE&BearerPreference=WCDMA_AND_LTE       "
echo.
pause
goto :submenu

:subaction8
curl --header "Referer: http://192.168.0.1/index.html" "http://192.168.0.1/goform/goform_set_cmd_process?goformId=SET_BEARER_PREFERENCE&BearerPreference=GSM_AND_LTE        "
echo.
pause
goto :submenu

:subaction9
curl --header "Referer: http://192.168.0.1/index.html" "http://192.168.0.1/goform/goform_set_cmd_process?goformId=SET_BEARER_PREFERENCE&BearerPreference=WCDMA_AND_GSM         "
echo.
pause
goto :submenu

:colorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i