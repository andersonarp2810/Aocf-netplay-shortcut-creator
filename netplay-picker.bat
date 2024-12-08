@echo off
mode con: cols=160 lines=20
title Squiroll + Netplay creator
:main
goto thcrapinput

:thcrapinput
echo Insert thcrap\bin folder location, obrigatory (example:'C:\thcrap\bin'):
set /p thcrapbin=
:: if "%thcrapbin%" equ "" set thcrapbin=C:\th\thcrap\bin this is a handy line for testing
:: this took me ages to find, it removes quotes from the input, makes life easier when dealing with spaces on the file path
:: so much so i'm gonna leave this comment here and no one can tell me otherwise
if "%thcrapbin%" equ "" (echo thcrap bin folder location is obrigatory! & goto thcrapinput)
set thcrapbin=%thcrapbin:"=%
set lastchar=%thcrapbin:~-1%
if "%lastchar%" neq "\" (set thcrapbin=%thcrapbin%\)
IF EXIST "%thcrapbin%thcrap_configure.exe" GOTO stable_input
IF EXIST "%thcrapbin%thcrap_configure_v3.exe" GOTO stable_input
echo Invalid thcrap bin folder, both thcrap_configure.exe and thcrap_configure_v3.exe not found!
goto thcrapinput

:stable_input
echo Insert Squiroll STABLE location, leave it empty to not create a shortcut (example:'C:\Downloads\squiroll-ver1.1-stable\Netcode.dll'):
set /p stable=
if "%stable%" equ "" goto beta_input
set stable=%stable:"=%
set extension=%stable:~-4%
if "%extension%" neq ".dll" (set stable=%stable%\Netcode.dll)
echo Autocompleted file location to %stable%
goto beta_input

:beta_input
echo Insert Squiroll BETA location, leave it empty to not create a shortcut (example:'C:\Downloads\squiroll-ver1.1-beta\Netcode.dll'):
set /p beta=
if "%beta%" equ "" set beta=C:\Users\Administrator\Downloads\New folder\squiroll-ver1.1-beta
if "%beta%" equ "" goto lunar_input
set beta=%beta:"=%
set extension=%beta:~-4%
if "%extension%" neq ".dll" (set beta=%beta%\Netcode.dll)
echo Autocompleted file location to %beta%
goto lunar_input

:lunar_input
echo Insert Lunarcast Netplay.dll location, leave it empty to not create a shortcut (example:'C:\Downloads\Netplay\Netplay.dll'):
set /p lunarcast=
if "%lunarcast%" equ "" goto create
set lunarcast=%lunarcast:"=%
set extension=%lunarcast:~-4%
if "%extension%" neq ".dll" (set lunarcast=%lunarcast%\Netplay.dll)
echo Autocompleted file location to %lunarcast%
goto create

:create
if "%stable%" equ "" (
    if "%beta%" equ "" (
        if "%lunarcast%" equ "" (
            echo You did not input any file.
            goto stable_input
        )
    )
)
:: for whatever the fuck reason this variable does neither set itself or update inside the if
set newfile="%CD%\squiroll-stable.bat"
if "%stable%" neq "" (
    echo Creating at %newfile%
    echo @echo off>%newfile%
    echo title Squiroll stable + Netplay>>%newfile%
    echo :main>>%newfile%
    echo xcopy /s/y "%stable%" "%thcrapbin%">>%newfile%
    echo del "%thcrapbin%\Netplay.dll">>%newfile%
    echo start "" "%thcrapbin%thcrap_loader.exe" "en.js" th155>>%newfile%
)
set newfile="%CD%\squiroll-beta.bat"
if "%beta%" neq "" (
    echo Creating at %newfile%
    echo @echo off>%newfile%
    echo title Squiroll beta + Netplay>>%newfile%
    echo :main>>%newfile%
    echo xcopy /s/y "%beta%" "%thcrapbin%">>%newfile%
    echo del "%thcrapbin%\Netplay.dll">>%newfile%
    echo start "" "%thcrapbin%thcrap_loader.exe" "en.js" th155>>%newfile%
)
set newfile="%CD%\lunarcast-netplay.bat"
if "%lunarcast%" neq "" (
    echo Creating at %newfile%
    echo @echo off>%newfile%
    echo title Lunarcast Netplay>>%newfile%
    echo :main>>%newfile%
    echo xcopy /s/y "%lunarcast%" "%thcrapbin%">>%newfile%
    echo del "%thcrapbin%\Netcode.dll">>%newfile%
    echo start "" "%thcrapbin%thcrap_loader.exe" "en.js" th155>>%newfile%
)

echo Shortcuts created, have fun! Remember, if you move or rename any of the dlls, run this script again.
pause