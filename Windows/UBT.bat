@echo off
set /p "Pfad="<"path.save"
cmd /c "start /min adb.bat"
mode con lines=70 cols=82
title Ultimate Backup Tool v1.3.2
if exist adb.exe (
echo ADB found! Continuing
) else (
echo ADB not found in path!
pause
exit
)
ping 127.0.0.1 >nul
set /p "language="<"language.save"
if not defined Pfad (
set Pfad=C:\backup\backup.ab
)
set chkDevice=false
set chkFastbot=false
find "1" language.save && goto menu
find "2" language.save && goto menuger
goto menu

:menu
adb shell getprop ro.build.version.release >version.check 2>&1
adb shell getprop ro.product.model >model.check 2>&1
adb shell getprop ro.product.manufacturer >manufacturer.check 2>&1
set /p "version="<"version.check"
set /p "model="<"model.check"
set /p "manufacturer="<"manufacturer.check"
find "arc" model.check && goto sorry >hide.this
find "mini" model.check && goto sorry >hide.this
find "txt" model.check && goto sorry >hide.this
find "Ray" model.check && goto sorry 
find "Play" model.check && goto sorry
find "neo" model.check && goto sorry 
find "x10" model.check && goto sorry 
find "x8" model.check && goto sorry 
find "one" model.check && goto sorry1 
if "%version%"=="3.0" goto sorry2
if "%version%"=="3.0" goto sorry2
if "%version%"=="3.1" goto sorry2
if "%version%"=="3.2.1" goto sorry2
if "%version%"=="3.2" goto sorry2
if "%version%"=="2.3.7" goto sorry2
if "%version%"=="2.3.6" goto sorry2
if "%version%"=="2.3.5" goto sorry2
if "%version%"=="2.3.3" goto sorry2
if "%version%"=="2.3.2" goto sorry2
if "%version%"=="2.3.1" goto sorry2
if "%version%"=="2.3" goto sorry2
if "%version%"=="2.2.2" goto sorry2
if "%version%"=="2.2.1" goto sorry2
if "%version%"=="2.2" goto sorry2
if "%version%"=="2.0" goto sorry2
if "%version%"=="2.1" goto sorry2
if "%version%"=="1.6" goto sorry2
if "%version%"=="1.5" goto sorry2
if "%version%"=="1.0" goto sorry3
if "%version%"=="1.1" goto sorry2
echo 1 > language.save
del msg.vbs
del search.find
cls
echo				 Ultimate Backup tool v1.3.2
echo				        by Gigadroid
echo				     xda-developers.com
echo.
echo Notices:
echo I'M NOT RESPONSIBLE IF YOU DAMAGE YOUR DEVICE!
echo By unlocking the bootloader you will lose your warranty!
echo Make sure that USB Debugging is enabled!
echo The backup function will not back up SMS messages!
echo If you want to make a backup,set a desktop backup password under Developer 
echo Options. It seems it would fail otherwise!
echo Make sure that you have correctly installed drivers!
echo The backup will be saved in %Pfad% .
echo.
echo ##############################   Device Info  ##################################
echo.
if NOT "%chkDevice%"=="true" goto devices
adb devices | FINDSTR /IL "0" >nul
IF %ERRORLEVEL% EQU 0 adb devices
IF %ERRORLEVEL% EQU 1 (
echo List of devices attached : NO DEVICE CONNECTED
echo. 
)
if NOT "%chkFastboot%"=="true" goto fastbot
fastboot devices | FINDSTR /IL "0" >nul
IF %ERRORLEVEL% EQU 0 fastboot devices
IF %ERRORLEVEL% EQU 1 (
echo List of fastboot devices : NO DEVICE CONNECTED
echo.
)
if "%manufacturer%"=="error: device not found" goto part2
echo Manufacturer:              %manufacturer%
echo.
echo Model:                     %model%
echo.
echo Android Version:           %version%
echo.
echo ################################################################################
goto part1

:part2
echo Manufacturer:              NO DEVICE CONNECTED
echo.
echo Model:                     NO DEVICE CONNECTED
echo.
echo Android Version:           NO DEVICE CONNECTED
echo.
echo ################################################################################
goto part1

:part1
echo.
echo What would you like to do?
echo.
echo ##############################     Backup     ##################################
echo #                                                                              #
echo #   1.  Set path                                                               #
echo #   2.  Backup all without system apps                                         #
echo #   3.  Backup all with system apps (unsafe)                                   #
echo #   4.  Backup app and device data (not the APKs themselves)                   #
echo #   5.  Backup apps                                                            #
echo #   6.  Backup device shared storage / SD card contents                        #
echo #   7.  Backup a single app                                                    #
echo #   8.  Restore                                                                #
echo #                                                                              #
echo ################################################################################
echo.
echo ###############################    Tools     ###################################
echo #                                                                              #
echo #   9.  Install Drivers                                                        #
echo #   10. Unlock Bootloader (Uses "fastboot oem unlock" command)                 #
echo #   11. Install CWM/ CWM Touch (Galaxy Nexus, S2 and S3)                       #
echo #   12. Root your phone (ARM) (requires custom recovery)                       #
echo #   13. All in one (Galaxy Nexus, S2 and S3)                                   #
echo #                                                                              #
echo ################################################################################
echo. 
echo     14. Refresh
echo     15. Capture a problem
echo     16. Change language
echo     17. Quit
del version.check
del manufacturer.check
del model.check
goto choose

:choose
echo.
set /P C=Choose a option:
if "%C%"=="9" goto drivers
if "%C%"=="13" goto one
if "%C%"=="12" goto root1
if "%C%"=="11" goto cwm
if "%C%"=="10" goto unlock
if "%C%"=="17" goto quit
if "%C%"=="8" goto restore
if "%C%"=="6" goto sd
if "%C%"=="5" goto apps
if "%C%"=="4" goto appsdevice
if "%C%"=="3" goto system
if "%C%"=="2" goto all
if "%C%"=="1" goto path 
if "%C%"=="7" goto single
if "%C%"=="14" goto refresh
if "%C%"=="16" goto language
if "%C%"=="15" goto problem 
echo.
echo Incorrect input, try again.
goto choose

:problem
start captureproblem.bat
echo After you have recorded your problem, post your log under the XDA-Thread of Ultimate Backup Tool.
pause
goto menu

:language
cls
echo.
echo Choose a language:
echo.
echo 1. English
echo 2. Deutsch (thanks to TheMaurice)
echo.
set /P language=Choose a option:
if "%language%"=="1" goto menu
if "%language%"=="2" goto menuger
echo.
echo Incorrect input, try again.
goto language

:sorry3
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("ARE YOU KIDDING ME? " , _
echo 0 Or 256 Or 0, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto quit

:sorry2
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Sorry, this Tool does only work with Android 4.0 and above. " , _
echo 0 Or 256 Or 0, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto quit

:sorry1
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Sorry, there are problems with phones from the One series." ^& vbCrLf ^& "Don't say it didn't worked for you, I warned you!" , _
echo 0 Or 256 Or 0, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menu

:sorry
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Sorry, there are problems with Sony devices from 2011." ^& vbCrLf ^& "Don't say it didn't worked for you, I warned you!" , _
echo 0 Or 256 Or 0, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menu

:refresh
goto menu

:fastbot
echo Checking fastboot...
set chkFastboot=true
goto menu

:devices
echo Checking list of attached devices...
set chkDevice=true
goto menu

:single 
cls
start singleappbackup.bat
set /P App=Look at the window that was opened. Find the package name of the app you want to backup and type it here:
echo Wait until you see a message saying 'Backup complete' or your phone returns to the home screen.
adb backup ^<%App%^> -f "%Pfad%" > search.find 2>&1
findstr "adb" search.find >nul
IF %ERRORLEVEL% EQU 1 goto singlecomplete
IF %ERRORLEVEL% EQU 0 goto singlefailed

:singlecomplete
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup complete!", _
echo 1 Or 256 Or 1, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menu

:singlefailed
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup failed!", _
echo 5 Or 256 Or 16, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
IF %ERRORLEVEL% EQU 2 goto menu
IF %ERRORLEVEL% EQU 4 goto single

:path
cls
echo.
set /P Pfad=Type the path where the backup should be stored (like C:\backup\backup.ab):
echo %Pfad%>path.save
goto menu

:one
cls
echo.
echo Which device is connected?
echo.
echo 1. Galaxy Nexus
echo 2. Galaxy S2
echo 3. Galaxy S3
echo 4. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto onegnex
if "%C%"=="2" goto ones2
if "%C%"=="3" goto ones3
if "%C%"=="4" goto menu
echo.
echo Incorrect input, try again.
goto one

:ones3
cls
echo.
echo Which ClockworkMod Recovery do you wish to install?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo 3. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto ones3normal
if "%C%"=="2" goto ones3touch
if "%C%"=="3" goto one
echo.
echo Incorrect input, try again.
goto ones3

:ones3touch
cls
echo 1. GT-I9300
echo 2. Sprint
echo 3. T-Mobile
echo 4. Verizon
echo 5. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto oness3origtouch
if "%C%"=="2" goto oness3sprinttouch
if "%C%"=="3" goto oness3tmtouch
if "%C%"=="4" goto oness3verizontouch
if "%C%"=="5" goto ones3
echo.
echo Incorrect input, try again.
goto oness3touch

:ones3origtouch
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-i9300.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-i9300.img
fastboot reboot
echo You have installed CWM.
adb wait-for-device
goto root

:ones3sprinttouch
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-d2spr.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-d2spr.img
fastboot reboot
echo You have installed CWM.
adb wait-for-device
goto root

:ones3tmtouch
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-d2tmo.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-d2tmo.img
fastboot reboot
echo You have installed CWM.
adb wait-for-device
goto root

:ones3verizontouch
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-d2vzw.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-d2vzw.img
fastboot reboot
echo You have installed CWM.
adb wait-for-device
goto root

:ones3normal
cls
echo 1. GT-I9300
echo 2. AT and T
echo 3. Sprint
echo 4. T-Mobile
echo 5. US Cellular
echo 6. Verizon
echo 7. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto ones3orig
if "%C%"=="2" goto ones3att
if "%C%"=="3" goto ones3sprint
if "%C%"=="4" goto ones3tm
if "%C%"=="5" goto ones3us
if "%C%"=="6" goto ones3verizon
if "%C%"=="7" goto ones3
echo.
echo Incorrect input, try again.
goto ones3normal

:ones3orig
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-i9300.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.2-i9300.img
fastboot reboot
echo You have installed CWM.
adb wait-for-device
goto root

:ones3att
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2att.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2att.img
fastboot reboot
echo You have installed CWM.
adb wait-for-device
goto root

:ones3sprint
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2spr.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2spr.img
fastboot reboot
echo You have installed CWM.
adb wait-for-device
goto root

:ones3tm
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2tmo.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2tmo.img
fastboot reboot
echo You have installed CWM.
adb wait-for-device
goto root

:ones3us
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2usc.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2usc.img
fastboot reboot
echo You have installed CWM.
adb wait-for-device
goto root

:ones3verizon
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2vzw.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2vzw.img
fastboot reboot
echo You have installed CWM.
adb wait-for-device
goto root

:onegnex
cls
echo.
echo 1. Galaxy Nexus (GSM)
echo 2. Galaxy Nexus (Sprint)
echo 3. Galaxy Nexus (Verizon) 
echo 4. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto onegsm
if "%C%"=="2" goto onesprint
if "%C%"=="3" goto oneverizon
if "%C%"=="4" goto one
echo.
echo Incorrect input, try again.
goto onegnex

:ones2touch
cls
echo.
echo 1. Galaxy S2
echo 2. Galaxy S2 (AT and T)
echo 3. SGH-I777
echo 4. Galaxy S2 (T-Mobile)
echo 5. Back
echo.
set /P C=Choose a option:
if "%C%"=="2" goto oneatttouch
if "%C%"=="1" goto onei9100touch
if "%C%"=="3" goto onei777touch
if "%C%"=="4" goto onetmtouch
if "%C%"=="5" goto ones2
echo.
echo Incorrect input, try again.
goto ones2touch

:oneatttouch
cls
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-5.8.1.5-galaxys2att.zip
cls
echo Flashing ...
adb push recovery-clockwork-touch-5.8.1.5-galaxys2att.zip /sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2att.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2att.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have installed CWM.
adb wait-for-device
goto root

:s2sghtouch
cls
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-i777.zip
cls
echo Flashing ...
adb push recovery-clockwork-touch-6.0.1.0-i777.zip /sdcard/recovery-clockwork-touch-6.0.1.0-i777.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-touch-6.0.1.0-i777.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have installed CWM.
adb wait-for-device
goto root

:s2s2touch
cls
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-5.8.1.5-galaxys2.zip
cls
echo Flashing ...
adb push recovery-clockwork-touch-5.8.1.5-galaxys2.zip /sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have installed CWM.
adb wait-for-device
goto root

:s2tmtouch
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
adb reboot bootloader
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-hercules.img
cls
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-hercules.img
fastboot reboot
echo You have installed CWM.
adb wait-for-device
goto root

:ones2
cls
echo.
echo Which ClockworkMod Recovery do you wish to install?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo 3. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto s2normal
if "%C%"=="2" goto s2touch
if "%C%"=="3" goto one
echo.
echo Incorrect input, try again.
goto ones2

:ones2normal
cls
echo.
echo 1. Galaxy S2
echo 2. Galaxy S2 (AT and T)
echo 3. SGH-I777
echo 4. Galaxy S2 (T-Mobile)
echo 5. Back
echo.
set /P C=Choose a option:
if "%C%"=="2" goto oneattnormal
if "%C%"=="1" goto onei9100normal
if "%C%"=="3" goto onei777normal
if "%C%"=="4" goto onetmnormal
if "%C%"=="5" goto ones2
echo.
echo Incorrect input, try again.
goto ones2normal

:oneattnormal
cls
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-5.0.2.6-galaxys2att.zip
cls
echo Flashing ...
adb push recovery-clockwork-5.0.2.6-galaxys2att.zip /sdcard/recovery-clockwork-5.0.2.6-galaxys2att.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-5.0.2.6-galaxys2att.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have installed CWM.
adb wait-for-device
goto root

:onei9100normal
cls
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-i9100.zip
cls
echo Flashing ...
adb push recovery-clockwork-6.0.1.0-i9100.zip /sdcard/recovery-clockwork-6.0.1.0-i9100.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-6.0.1.0-i9100.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have installed CWM.
adb wait-for-device
goto root

:onei777normal
cls
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-i777.zip
cls
echo Flashing ...
adb push recovery-clockwork-6.0.1.0-i777.zip /sdcard/recovery-clockwork-6.0.1.0-i777.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-6.0.1.0-i777.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have installed CWM.
adb wait-for-device
goto root

:onetmnormal
cls
echo Your phone will reboot sometimes, that's normal
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
adb reboot bootloader
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-5.0.2.7-hercules.img
cls
echo Flashing...
fastboot flash recovery recovery-clockwork-5.0.2.7-hercules.img
fastboot reboot
echo You have installed CWM.
adb wait-for-device
goto root

:onegsm
cls
adb reboot bootloader
echo Your phone will reboot sometimes, that's normal
echo If your Command Prompt displays "waiting for device" for a long time, your driver wasn't successfully installed.
echo If all was successfull, you will be prompted to confirm that you wish to unlock the bootloader.
fastboot oem unlock 
fastboot reboot
adb wait-for-device
echo.
echo Which ClockworkMod Recovery do you wish to install?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo 3. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto normal1
if "%C%"=="2" goto touch1
if "%C%"=="3" goto onegnex
echo.
echo Incorrect input, try again.
goto onegsm

:normal1
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-maguro.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.0-maguro.img
fastboot reboot recovery
echo You have installed CWM.
adb wait-for-device
goto root

:touch1
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-maguro.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.0-maguro.img
fastboot reboot
echo You have installed CWM.
adb wait-for-device
goto root

:onesprint
cls
adb reboot bootloader
echo Your phone will reboot sometimes, that's normal
echo If your Command Prompt displays "waiting for device" for a long time, your driver wasn't successfully installed.
echo If all was successfull, you will be prompted to confirm that you wish to unlock the bootloader.
fastboot oem unlock
fastboot reboot
adb wait-for-device
echo.
echo Which ClockworkMod Recovery do you wish to install?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo 3. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto normal2
if "%C%"=="2" goto touch2
if "%C%"=="3" goto onegnex
echo.
echo Incorrect input, try again.
goto onesprint

:normal2
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-toroplus.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.0-maguro.img
fastboot reboot 
echo You have installed CWM.
adb wait-for-device
goto root

:touch2
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo.
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-toroplus.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.0-toroplus.img
fastboot reboot 
echo You have installed CWM.
adb wait-for-device
goto root

:oneverizon
cls
adb reboot bootloader
echo Your phone will reboot sometimes, that's normal
echo If your Command Prompt displays "waiting for device" for a long time, your driver wasn't successfully installed.
echo If all was successfull, you will be prompted to confirm that you wish to unlock the bootloader.
fastboot oem unlock
fastboot reboot
adb wait-for-device
echo.
echo Which ClockworkMod Recovery do you wish to install?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo 3. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto normal3
if "%C%"=="2" goto touch3
if "%C%"=="3" goto onegnex
echo.
echo Incorrect input, try again.
goto oneverizon

:normal3
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo.
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-toro.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.0-toro.img
fastboot reboot 
echo You have installed CWM.
adb wait-for-device
goto root

:touch3
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo.
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-toro.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.0-toro.img
fastboot reboot 
echo You have installed CWM.
adb wait-for-device
goto root

:drivers
cls
echo.
echo If your drivers don't work try on from these (uninstall your previous drivers first):
echo 1. Samsung Driver
echo 2. HTC Sync (installs the drivers, you don't need to install HTC Sync to make it work)
echo 3. Sony Drivers (will open a website)
echo 4. Motorola Device Manager 
echo 5. LG Drivers (will open a website)
echo 6. PDAnet's Driver (only GNex)
echo 7. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto driver1
if "%C%"=="6" goto driver4
if "%C%"=="2" goto driver5
if "%C%"=="3" goto driver2
if "%C%"=="5" goto driver7
if "%C%"=="4" goto driver6
if "%C%"=="7" goto menu
echo.
echo Incorrect input, try again.
goto drivers

:driver7
start http://www.lgforum.com/resources
goto menu

:driver6
cls
echo Downloading...
wget -q -N http://www.mymotocast.com/download/MDM?platform=windows
echo Motorola Device Manager will now be installed.
start MotorolaDeviceManager_2.2.28.exe
pause
goto menu

:driver2
start http://developer.sonymobile.com/downloads/drivers/
goto menu

:driver5
cls
echo Downloading...
wget -q -N http://dl4.htc.com/managed-assets/support/software/htc-sync/htc_sync_setup_3.2.20.exe
cls
echo HTC Sync will now be installed.
start htc_sync_setup_3.2.20.exe
pause
goto menu

:driver1
cls
echo Downloading...
wget -q -N --no-check-certificate https://dl.dropbox.com/s/h8jraq6ubopbp0a/SAMSUNG_USB_Driver_for_Mobile_Phones_1_5_6_0.exe?dl=1
ren "SAMSUNG_USB_Driver_for_Mobile_Phones_1_5_6_0.exe?dl=1" "SAMSUNG_USB_Driver_for_Mobile_Phones_1_5_6_0.exe"
cls
echo The driver will now be installed
start SAMSUNG_USB_Driver_for_Mobile_Phones_1_5_6_0.exe
pause
goto menu

:driver4
if exist %PROGRAMFILES(X86)% (
cls
echo Downloading...
wget -q -N http://pdanet.co/bin/PdaNetA350x64.exe
cls
echo The driver will now be installed
start PdaNetA350x64.exe
pause
goto menu
) else (
cls
echo Downloading...
wget -q -N http://pdanet.co/bin/PdaNetA350.exe
cls
echo The driver will now be installed
start PdaNetA350.exe
pause
goto menu
)

:cwm
cls
echo.
echo Which ClockworkMod Recovery do you wish to install?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo 3. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto normal
if "%C%"=="2" goto touch
if "%C%"=="3" goto menu
echo.
echo Incorrect input, try again.
goto cwm

:normal
cls
echo.
echo Which device schould get CWM?
echo.
echo 1. Samsung Galaxy Nexus 
echo 2. Samsung Galaxy S2
echo 3. Samsung Galaxy S3
echo 4. Samsung Galaxy Note
echo 5. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto nexus
if "%C%"=="2" goto s2
if "%C%"=="3" goto s3
if "%C%"=="4" goto note
if "%C%"=="5" goto cwm
echo.
echo Incorrect input, try again.
goto normal

:note
cls
echo.
echo 1. GT-N7000
echo 2. AT and T
echo.
set /P C=Choose a option:
if "%C%"=="1" goto n7000
if "%C%"=="2" goto n7000att
if "%C%"=="3" goto normal
echo.
echo Incorrect input, try again.
goto note

:n7000
cls
echo Your phone may not be in fastboot mode.
pause
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-n7000.zip
cls
echo Flashing ...
adb push recovery-clockwork-6.0.1.2-n7000.zip /sdcard/recovery-clockwork-6.0.1.2-n7000.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-6.0.1.2-n7000.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have installed CWM.
pause
goto menu

:n7000att
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-5.8.4.8-quincyatt.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery-clockwork-5.8.4.8-quincyatt.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:s3
cls
echo.
echo 1. GT-I9300
echo 2. AT and T
echo 3. Sprint
echo 4. T-Mobile
echo 5. US Cellular
echo 6. Verizon
echo 7. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto s3orig
if "%C%"=="2" goto s3att
if "%C%"=="3" goto s3sprint
if "%C%"=="4" goto s3tm
if "%C%"=="5" goto s3us
if "%C%"=="6" goto s3verizon
if "%C%"=="7" goto normal
echo.
echo Incorrect input, try again.
goto s3

:s3orig
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-i9300.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.2-i9300.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:s3att
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2att.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2att.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:s3sprint
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2spr.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2spr.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:s3tm
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2tmo.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2tmo.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:s3us
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2usc.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2usc.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:s3verizon
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2vzw.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2vzw.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:s2
cls
echo 1. AT and T
echo 2. GT-I9100
echo 3. SGH-I777
echo 4. T-Mobile
echo 5. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto s2att
if "%C%"=="2" goto s2orig
if "%C%"=="3" goto s2sgh
if "%C%"=="4" goto s2tm
if "%C%"=="5" goto normal
echo.
echo Incorrect input, try again.
goto s2

:s2att
cls
echo Your phone may not be in fastboot mode.
pause
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-5.0.2.6-galaxys2att.zip
cls
echo Flashing ...
adb push recovery-clockwork-5.0.2.6-galaxys2att.zip /sdcard/recovery-clockwork-5.0.2.6-galaxys2att.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-5.0.2.6-galaxys2att.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have installed CWM.
pause
goto menu

:s2orig
cls
echo Your phone may not be in fastboot mode.
pause
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-i9100.zip
cls
echo Flashing ...
adb push recovery-clockwork-6.0.1.0-i9100.zip /sdcard/recovery-clockwork-6.0.1.0-i9100.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-6.0.1.0-i9100.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have installed CWM.
pause
goto menu

:s2sgh
cls
echo Your phone may not be in fastboot mode.
pause
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-i777.zip
cls
echo Flashing ...
adb push recovery-clockwork-6.0.1.0-i777.zip /sdcard/recovery-clockwork-6.0.1.0-i777.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-6.0.1.0-i777.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have installed CWM.
pause
goto menu

:s2tm
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-5.0.2.7-hercules.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-5.0.2.7-hercules.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:nexus
cls
echo 1. GSM
echo 2. Sprint
echo 3. Verizon
echo 4. Back
echo
set /P C=Choose a option:
if "%C%"=="1" goto cwmgsm
if "%C%"=="2" goto cwmsprint
if "%C%"=="3" goto cwmverizon
if "%C%"=="4" goto normal
echo.
echo Incorrect input, try again.
goto nexus

:cwmgsm
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-maguro.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.0-maguro.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:cwmsprint
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-toroplus.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.0-toroplus.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:cwmverizon
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-toro.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-6.0.1.0-toro.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:touch
cls
echo.
echo Which device schould get CWM?
echo.
echo 1. Samsung Galaxy Nexus 
echo 2. Samsung Galaxy S2
echo 3. Samsung Galaxy S3
echo 4. Samsung Galaxy Note (only AT and T)
echo 5. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto nexustouch
if "%C%"=="2" goto s2touch
if "%C%"=="3" goto s3touch
if "%C%"=="4" goto n7000atttouch
if "%C%"=="5" goto cwm
echo.
echo Incorrect input, try again.
goto touch

:n7000atttouch
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-5.8.4.3-quincyatt.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-5.8.4.3-quincyatt.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:s3touch
cls
echo 1. GT-I9300
echo 2. Sprint
echo 3. T-Mobile
echo 4. Verizon
echo 5. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto s3origtouch
if "%C%"=="2" goto s3sprinttouch
if "%C%"=="3" goto s3tmtouch
if "%C%"=="4" goto s3verizontouch
if "%C%"=="5" goto touch
echo.
echo Incorrect input, try again.
goto s3touch

:s3origtouch
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-i9300.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-i9300.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:s3sprinttouch
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-d2spr.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-d2spr.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:s3tmtouch
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-d2tmo.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-d2tmo.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:s3verizontouch
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-d2vzw.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-d2vzw.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:s2touch
cls
echo 1. AT and T
echo 2. SGH-I777
echo 3. GT-I9100
echo 4. T-Mobile
echo 5. Back
echo.
set /P C=Choose a option:
if "%C%"=="1" goto s2atttouch
if "%C%"=="2" goto s2sghtouch
if "%C%"=="3" goto s2s2touch
if "%C%"=="4" goto s2tmtouch
if "%C%"=="3" goto touch
echo.
echo Incorrect input, try again.
goto s2touch

:s2atttouch
cls
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-5.8.1.5-galaxys2att.zip
cls
echo Flashing ...
adb push recovery-clockwork-touch-5.8.1.5-galaxys2att.zip /sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2att.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2att.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have installed CWM.
pause
goto menu

:s2sghtouch
cls
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-i777.zip
cls
echo Flashing ...
adb push recovery-clockwork-touch-6.0.1.0-i777.zip /sdcard/recovery-clockwork-touch-6.0.1.0-i777.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-touch-6.0.1.0-i777.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have installed CWM.
pause
goto menu

:s2s2touch
cls
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-5.8.1.5-galaxys2.zip
cls
echo Flashing ...
adb push recovery-clockwork-touch-5.8.1.5-galaxys2.zip /sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have installed CWM.
pause
goto menu

:s2tmtouch
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
adb reboot bootloader
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-hercules.img
cls
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-hercules.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:nexustouch
cls
echo 1. GSM
echo 2. Sprint
echo 3. Verizon
echo 4. Back
echo
set /P C=Choose a option:
if "%C%"=="1" goto cwmtouchgsm
if "%C%"=="2" goto cwmtouchsprint
if "%C%"=="3" goto cwmtouchverizon
if "%C%"=="4" goto touch
echo.
echo Incorrect input, try again.
goto nexustouch

:cwmtouchgsm
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-maguro.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.0-maguro.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:cwmtouchsprint
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-toroplus.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.0-toroplus.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:cwmtouchverizon
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-toro.img
cls
adb reboot bootloader
echo Flashing...
fastboot flash recovery recovery-clockwork-touch-6.0.1.0-toro.img
fastboot reboot
echo You have installed CWM.
pause
goto menu

:root
cls
echo Your phone will now be rooted.
echo Downloading...
wget -q -N http://downloads.noshufou.netdna-cdn.com/superuser/Superuser-3.1.3-arm-signed.zip
ren "Superuser-3.1.3-arm-signed.zip" "Superuser.zip"
cls
echo Flashing ...
adb push Superuser.zip /sdcard/Superuser.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/Superuser.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have succesfully rooted your phone.
goto menu

:root1
cls
echo Your phone may not be in fastboot mode.
pause
echo Your phone will now be rooted.
echo Downloading...
wget -q -N http://downloads.noshufou.netdna-cdn.com/superuser/Superuser-3.1.3-arm-signed.zip
ren "Superuser-3.1.3-arm-signed.zip" "Superuser.zip"
cls
echo Flashing ...
adb push Superuser.zip /sdcard/Superuser.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/Superuser.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo You have succesfully rooted your phone.
pause
goto menu

:unlock
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Do you really want to unlock the bootloader?" ^& vbCrLf ^& "All data will be deleted!", _
echo 1 Or 256 Or 48, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto unlock%errorlevel%

:unlock1
del msg.vbs
cls
adb reboot bootloader
echo If your Command Prompt displays "waiting for device" for a long time, your driver wasn't successfully installed.
echo If all was successfull, you will be prompted to confirm that you wish to unlock the bootloader.
fastboot oem unlock
fastboot reboot
pause
goto menu

:unlock2
del msg.vbs
goto menu

:all
cls
echo Wait until you see a message saying 'Backup complete' or your phone returns to the home screen.
adb backup -apk -shared -all -nosystem -f "%Pfad%" > search.find 2>&1
findstr "adb" search.find >nul
IF %ERRORLEVEL% EQU 1 goto allcomplete
IF %ERRORLEVEL% EQU 0 goto allfailed

:allcomplete
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup complete!", _
echo 1 Or 256 Or 1, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menu

:allfailed
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup failed!", _
echo 5 Or 256 Or 16, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
IF %ERRORLEVEL% EQU 2 goto menu
IF %ERRORLEVEL% EQU 4 goto all

:system
cls
echo Wait until you see a message saying 'Backup complete' or your phone returns to the home screen.
adb backup -apk -shared -all -system -f "%Pfad%" > search.find 2>&1
findstr "adb" search.find >nul
IF %ERRORLEVEL% EQU 1 goto systemcomplete
IF %ERRORLEVEL% EQU 0 goto systemfailed

:systemcomplete
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup complete!", _
echo 1 Or 256 Or 1, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menu

:systemfailed
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup failed!", _
echo 5 Or 256 Or 16, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
IF %ERRORLEVEL% EQU 2 goto menu
IF %ERRORLEVEL% EQU 4 goto system

:appsdevice
cls
echo Wait until you see a message saying 'Backup complete' or your phone returns to the home screen.
adb backup -all -f "%Pfad%" > search.find 2>&1
findstr "adb" search.find >nul
IF %ERRORLEVEL% EQU 1 goto appsdevicecomplete
IF %ERRORLEVEL% EQU 0 goto appsdevicefailed

:appsdevicecomplete
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup complete!", _
echo 1 Or 256 Or 1, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menu

:appsdevicefailed
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup failed!", _
echo 5 Or 256 Or 16, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
IF %ERRORLEVEL% EQU 2 goto menu
IF %ERRORLEVEL% EQU 4 goto appsdevice

:apps
cls
echo Wait until you see a message saying 'Backup complete' or your phone returns to the home screen.
adb backup -apk -noshared -nosystem -f "%Pfad%" > search.find 2>&1
findstr "adb" search.find >nul
IF %ERRORLEVEL% EQU 1 goto appscomplete
IF %ERRORLEVEL% EQU 0 goto appsfailed

:appscomplete
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup complete!", _
echo 1 Or 256 Or 1, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menu

:appsfailed
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup failed!", _
echo 5 Or 256 Or 16, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
IF %ERRORLEVEL% EQU 2 goto menu
IF %ERRORLEVEL% EQU 4 goto apps

:sd
cls
echo Wait until you see a message saying 'Backup complete' or your phone returns to the home screen.
adb backup -noapk -shared -nosystem -f "%Pfad%" > search.find 2>&1
findstr "adb" search.find >nul
IF %ERRORLEVEL% EQU 1 goto sdcomplete
IF %ERRORLEVEL% EQU 0 goto sdfailed

:sdcomplete
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup complete!", _
echo 1 Or 256 Or 1, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menu

:sdfailed
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup failed!", _
echo 5 Or 256 Or 16, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
IF %ERRORLEVEL% EQU 2 goto menu
IF %ERRORLEVEL% EQU 4 goto sd

:restore
cls
adb restore "%Pfad%" > search.find 2>&1
findstr "adb" search.find >nul
IF %ERRORLEVEL% EQU 1 goto restorecomplete
IF %ERRORLEVEL% EQU 0 goto restorefailed

:restorecomplete
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Restore complete!", _
echo 1 Or 256 Or 1, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menu

:restorefailed
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Restore failed!", _
echo 5 Or 256 Or 16, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
IF %ERRORLEVEL% EQU 2 goto menu
IF %ERRORLEVEL% EQU 4 goto restore

:quit
taskkill /f /im adb.exe
del msg.vbs
del version.check
del model.check
del manufacturer.check
exit

:menuger
adb shell getprop ro.build.version.release >version.check 2>&1
adb shell getprop ro.product.model >model.check 2>&1
adb shell getprop ro.product.manufacturer >manufacturer.check 2>&1
set /p "version="<"version.check"
set /p "model="<"model.check"
set /p "manufacturer="<"manufacturer.check"
find "arc" model.check && goto sorryger >hide.this
find "mini" model.check && goto sorryger >hide.this
find "txt" model.check && goto sorryger >hide.this
find "Ray" model.check && goto sorryger
find "Play" model.check && goto sorryger
find "neo" model.check && goto sorryger
find "x10" model.check && goto sorryger
find "x8" model.check && goto sorryger
find "one" model.check && goto sorry1ger
if "%version%"=="3.0" goto sorry2ger
if "%version%"=="3.0" goto sorry2ger
if "%version%"=="3.1" goto sorry2ger
if "%version%"=="3.2.1" goto sorry2ger
if "%version%"=="3.2" goto sorry2ger
if "%version%"=="2.3.7" goto sorry2ger
if "%version%"=="2.3.6" goto sorry2ger
if "%version%"=="2.3.5" goto sorry2ger
if "%version%"=="2.3.3" goto sorry2ger
if "%version%"=="2.3.2" goto sorry2ger
if "%version%"=="2.3.1" goto sorry2ger
if "%version%"=="2.3" goto sorry2ger
if "%version%"=="2.2.2" goto sorry2ger
if "%version%"=="2.2.1" goto sorry2ger
if "%version%"=="2.2" goto sorry2ger
if "%version%"=="2.0" goto sorry2ger
if "%version%"=="2.1" goto sorry2ger
if "%version%"=="1.6" goto sorry2ger
if "%version%"=="1.5" goto sorry2ger
if "%version%"=="1.0" goto sorry3ger
if "%version%"=="1.1" goto sorry2ger
echo 2 > language.save
del msg.vbs
del search.find
cls
echo				 Ultimate Backup tool v1.3.2
echo				        von Gigadroid
echo                              übersetzt von TheMaurice
echo				     xda-developers.com
echo.
echo Notices:
echo ICH UEBERNEHME KEINE HAFTUNG FUER DIE BESCHAEDIGUNG IHRES GERAETES!
echo Beim Entsperren des Bootloaders geht die Garantie des Geraetes verloren!
echo Stellen Sie sicher, dass USB-Debugging auf dem Geraet aktiviert ist!
echo Das Backup wird keine SMS Nachrichten sichern!
echo Stellen Sie sicher, dass alle Treiber korekt installiert sind!
echo Desktop Sicherungspasswort in den Entwicklereinstellungen gesetzt haben,
echo sonst kann es Probleme beim Backupvorgang geben!
echo Das Backup wird in %Pfad% gespeichert.
echo.
echo ##############################   Geraet Info  ##################################
echo.
if NOT "%chkDevice%"=="true" goto devicesger
adb devices | FINDSTR /IL "0" >nul
IF %ERRORLEVEL% EQU 0 adb devices
IF %ERRORLEVEL% EQU 1 (
echo Verbundene Geraete : KEIN GERAET VERBUNDEN
echo. 
)
if NOT "%chkFastboot%"=="true" goto fastbotger
fastboot devices | FINDSTR /IL "0" >nul
IF %ERRORLEVEL% EQU 0 fastboot devices
IF %ERRORLEVEL% EQU 1 (
echo Verbundene fastboot Geraete : KEIN GERAET VERBUNDEN
echo.
)
if "%manufacturer%"=="error: device not found" goto part2ger
echo Hersteller:                %manufacturer%
echo.
echo Modell:                    %model%
echo.
echo Android Version:           %version%
echo.
echo ################################################################################
goto part1ger

:part2ger
echo Hersteller:                KEIN GERAET VERBUNDEN
echo.
echo Modell:                    KEIN GERAET VERBUNDEN
echo.
echo Android Version:           KEIN GERAET VERBUNDEN
echo.
echo ################################################################################
goto part1ger

:part1ger
echo.
echo Was moechetn Sie tun?
echo.
echo ##############################     Backup     ##################################
echo #                                                                              #
echo #   1.  Speicherpfad festlegen                                                 #
echo #   2.  Sichere alles ausser Systemapps                                         #
echo #   3.  Sichere alles mit Systemapps (unsicher)                                #
echo #   4.  Sichere App un geraete Daten (Nicht die Apps sleber)                   #
echo #   5.  Sichere Apps                                                           #
echo #   6.  Sichere Geraete Speicher und SD-Karten Inhalt                          #
echo #   7.  Sichere einzelne App                                                   #
echo #   8.  Restore                                                                #
echo #                                                                              #
echo ################################################################################
echo.
echo ###############################    Tools     ###################################
echo #                                                                              #
echo #   9.  Treiber Installieren                                                   #
echo #   10. Bootloader entsperren (nur Galaxy Nexus, löscht alle Daten             #
echo #   11. Install CWM/ CWM Touch (nur Galaxy Nexus, bald mehr Geraete)           #
echo #   12. Geraet rooten (ARM) (benoetigt Custom Recovery)                        #
echo #   13. All in one (nur Galaxy Nexus, löscht alle Daten)                       #
echo #                                                                              #
echo ################################################################################
echo. 
echo     14. Aktualisieren
echo     15. Problem aufzeichnen
echo     16. Change language
echo     17. Beenden
del version.check
del manufacturer.check
del model.check
goto chooseger

:chooseger
echo.
set /P C=Option waehlen:
if "%C%"=="9" goto driversger
if "%C%"=="13" goto oneger
if "%C%"=="12" goto root1ger
if "%C%"=="11" goto cwmgerger
if "%C%"=="10" goto unlockger
if "%C%"=="17" goto quitger
if "%C%"=="8" goto restoreger
if "%C%"=="6" goto sdger
if "%C%"=="5" goto appsger
if "%C%"=="4" goto appsdeviceger
if "%C%"=="3" goto systemger
if "%C%"=="2" goto allger
if "%C%"=="1" goto pathger
if "%C%"=="7" goto singleger
if "%C%"=="14" goto refreshger
if "%C%"=="16" goto language
if "%C%"=="15" goto problemger
echo.
echo unrueltige Eingabe.
goto chooseger

:problemger
start captureproblem.bat
echo Nachdem du das Problem aufgezeichnet hast, poste deinen Log im XDA-Thread vom Ultimate Backup Tool.
pause
goto menu

:sorry3ger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("WILLST DU MICH VERAR**HEN? " , _
echo 0 Or 256 Or 0, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto quitger

:sorry2ger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Sorry, dieses Tool funktioniert nur mit Android 4 oder hoeher. " , _
echo 0 Or 256 Or 0, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto quitger

:sorry1ger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Sorry, es gibt Probleme mit der HTC One Serie." ^& vbCrLf ^& "Sag nicht, es haette bei dir nicht funktioniert, ich warne dich!" , _
echo 0 Or 256 Or 0, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menuger

:sorryger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Sorry, es gibt Probleme mit SONY Geraeten von 2011." ^& vbCrLf ^& "Sag nicht, es haette bei dir nicht funktioniert, ich warne dich!" , _
echo 0 Or 256 Or 0, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menuger

:refreshger
goto menuger

:fastbotger
echo Ueberpruefe fastboot...
set chkFastboot=true
goto menuger

:devicesger
echo Ueberpruefe verbundene Geraete...
set chkDevice=true
goto menuger

:singleger
cls
start singleappbackup.bat
set /P App=Schaue auf das Fenster, welches sich geöffnet hat. Finde den Paketnamen der App, die du sichern möchtest und gebe ihn hier ein:
echo Warte, bis du die Nachricht "Backup erfolgreich" siehst oder das Geraet zum Homescreen zurueckkehrt.
adb backup ^<%App%^> -f "%Pfad%" > search.find 2>&1
findstr "adb" search.find >nul
IF %ERRORLEVEL% EQU 1 goto singlecompleteger
IF %ERRORLEVEL% EQU 0 goto singlefailedger

:singlecompleteger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup erfolgreich!", _
echo 1 oder 256 oder 1, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menuger

:singlefailedger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup fehlgeschlagen!", _
echo 5 oder 256 oder 16, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
IF %ERRORLEVEL% EQU 2 goto menuger
IF %ERRORLEVEL% EQU 4 goto singleger

:pathger
cls
echo.
set /P Pfad=Geben Sie den Pfad an, wo das Backup gespeichert werden soll (z.B. C:\backup\backup.ab):
echo %Pfad%>path.save
goto menuger

:oneger
cls
echo.
echo Welches Geraet ist verbunden?
echo.
echo 1. Galaxy Nexus
echo 2. Galaxy S2
echo 3. Galaxy S3
echo 4. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto onegnexger
if "%C%"=="2" goto ones2ger
if "%C%"=="3" goto ones3ger
if "%C%"=="4" goto menuger
echo.
echo Ungueltige Eingabe.
goto oneger

:ones3ger
cls
echo.
echo Welchen ClockworkMod Recovery moechten Sie installieren?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo 3. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto ones3normalger
if "%C%"=="2" goto ones3touchger
if "%C%"=="3" goto oneger
echo.
echo Ungueltige Eingabe.
goto ones3ger

:ones3touchger
cls
echo 1. GT-I9300
echo 2. Sprint
echo 3. T-Mobile
echo 4. Verizon
echo 5. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto oness3origtouchger
if "%C%"=="2" goto oness3sprinttouchger
if "%C%"=="3" goto oness3tmtouchger
if "%C%"=="4" goto oness3verizontouchger
if "%C%"=="5" goto ones3ger
echo.
echo Ungueltige Eingabe.
goto oness3touchger

:ones3origtouchger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-i9300.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-i9300.img
fastboot reboot
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:ones3sprinttouchger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-d2spr.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-d2spr.img
fastboot reboot
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:ones3tmtouchger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-d2tmo.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-d2tmo.img
fastboot reboot
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:ones3verizontouchger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-d2vzw.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-d2vzw.img
fastboot reboot
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:ones3normalger
cls
echo 1. GT-I9300
echo 2. AT and T
echo 3. Sprint
echo 4. T-Mobile
echo 5. US Cellular
echo 6. Verizon
echo 7. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto ones3origger
if "%C%"=="2" goto ones3attger
if "%C%"=="3" goto ones3sprintger
if "%C%"=="4" goto ones3tmger
if "%C%"=="5" goto ones3usger
if "%C%"=="6" goto ones3verizonger
if "%C%"=="7" goto ones3ger
echo.
echo Ungueltige Eingabe.
goto ones3normalger

:ones3origger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-i9300.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.2-i9300.img
fastboot reboot
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:ones3attger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2att.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2att.img
fastboot reboot
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:ones3sprintger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2spr.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2spr.img
fastboot reboot
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:ones3tmger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2tmo.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2tmo.img
fastboot reboot
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:ones3usger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2usc.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2usc.img
fastboot reboot
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:ones3verizonger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2vzw.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2vzw.img
fastboot reboot
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:onegnexger
cls
echo.
echo 1. Galaxy Nexus (GSM)
echo 2. Galaxy Nexus (Sprint)
echo 3. Galaxy Nexus (Verizon) 
echo 4. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto onegsmger
if "%C%"=="2" goto onesprintger
if "%C%"=="3" goto oneverizonger
if "%C%"=="4" goto oneger
echo.
echo Ungueltige Eingabe.
goto onegnexger

:ones2touchger
cls
echo.
echo 1. Galaxy S2
echo 2. Galaxy S2 (AT and T)
echo 3. SGH-I777
echo 4. Galaxy S2 (T-Mobile)
echo 5. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="2" goto oneatttouchger
if "%C%"=="1" goto onei9100touchger
if "%C%"=="3" goto onei777touchger
if "%C%"=="4" goto onetmtouchger
if "%C%"=="5" goto ones2ger
echo.
echo Ungueltige Eingabe.
goto ones2touchger

:oneatttouchger
cls
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-5.8.1.5-galaxys2att.zip
cls
echo Flashen ...
adb push recovery-clockwork-touch-5.8.1.5-galaxys2att.zip /sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2att.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2att.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:s2sghtouchger
cls
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-i777.zip
cls
echo Flashen ...
adb push recovery-clockwork-touch-6.0.1.0-i777.zip /sdcard/recovery-clockwork-touch-6.0.1.0-i777.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-touch-6.0.1.0-i777.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:s2s2touchger
cls
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-5.8.1.5-galaxys2.zip
cls
echo Flashen ...
adb push recovery-clockwork-touch-5.8.1.5-galaxys2.zip /sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:s2tmtouchger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
adb reboot bootloader
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-hercules.img
cls
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-hercules.img
fastboot reboot
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:ones2ger
cls
echo.
echo Welchen ClockworkMod Recovery moechten Sie installieren?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo 3. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto s2normalger
if "%C%"=="2" goto s2touchger
if "%C%"=="3" goto oneger
echo.
echo Ungueltige Eingabe.
goto ones2ger

:ones2normalger
cls
echo.
echo 1. Galaxy S2
echo 2. Galaxy S2 (AT and T)
echo 3. SGH-I777
echo 4. Galaxy S2 (T-Mobile)
echo 5. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="2" goto oneattnormalger
if "%C%"=="1" goto onei9100normalger
if "%C%"=="3" goto onei777normalger
if "%C%"=="4" goto onetmnormalger
if "%C%"=="5" goto ones2ger
echo.
echo Ungueltige Eingabe.
goto ones2normalger

:oneattnormalger
cls
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-5.0.2.6-galaxys2att.zip
cls
echo Flashen ...
adb push recovery-clockwork-5.0.2.6-galaxys2att.zip /sdcard/recovery-clockwork-5.0.2.6-galaxys2att.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-5.0.2.6-galaxys2att.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:onei9100normalger
cls
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-i9100.zip
cls
echo Flashen ...
adb push recovery-clockwork-6.0.1.0-i9100.zip /sdcard/recovery-clockwork-6.0.1.0-i9100.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-6.0.1.0-i9100.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:onei777normalger
cls
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-i777.zip
cls
echo Flashen ...
adb push recovery-clockwork-6.0.1.0-i777.zip /sdcard/recovery-clockwork-6.0.1.0-i777.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-6.0.1.0-i777.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:onetmnormalger
cls
echo Das geraet wird einige male neustarten. Das ist normal
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
adb reboot bootloader
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-5.0.2.7-hercules.img
cls
echo Flashen...
fastboot flash recovery recovery-clockwork-5.0.2.7-hercules.img
fastboot reboot
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:onegsmger
cls
adb reboot bootloader
echo Das geraet wird einige male neustarten. Das ist normal
echo Wenn hier lange "Auf Geraet warten" angezeigt wird, ist Ihr Treiber nicht richtig installiert worden.
echo Wenn alles erfolgreich war werden Sie aufgefordert die Entsperrung des Bootloaders zu bestaetigen.
fastboot oem unlock 
fastboot reboot
adb wait-for-device
echo.
echo Welchen ClockworkMod Recovery moechten Sie installieren?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo 3. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto normal1ger
if "%C%"=="2" goto touch1ger
if "%C%"=="3" goto onegnexger
echo.
echo Ungueltige Eingabe.
goto onegsmger

:normal1ger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-maguro.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.0-maguro.img
fastboot reboot recovery
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:touch1ger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-maguro.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.0-maguro.img
fastboot reboot
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:onesprintger
cls
adb reboot bootloader
echo Das geraet wird einige male neustarten. Das ist normal
echo Wenn hier lange "Auf Geraet warten" angezeigt wird, ist Ihr Treiber nicht richtig installiert worden.
echo Wenn alles erfolgreich war werden Sie aufgefordert die Entsperrung des Bootloaders zu bestaetigen.
fastboot oem unlock
fastboot reboot
adb wait-for-device
echo.
echo Welchen ClockworkMod Recovery moechten Sie installieren?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo 3. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto normal2ger
if "%C%"=="2" goto touch2ger
if "%C%"=="3" goto onegnexger
echo.
echo Ungueltige Eingabe.
goto onesprintger

:normal2ger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-toroplus.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.0-maguro.img
fastboot reboot 
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:touch2ger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo.
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-toroplus.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.0-toroplus.img
fastboot reboot 
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:oneverizonger
cls
adb reboot bootloader
echo Das geraet wird einige male neustarten. Das ist normal
echo Wenn hier lange "Auf Geraet warten" angezeigt wird, ist Ihr Treiber nicht richtig installiert worden.
echo Wenn alles erfolgreich war werden Sie aufgefordert die Entsperrung des Bootloaders zu bestaetigen.
fastboot oem unlock
fastboot reboot
adb wait-for-device
echo.
echo Welchen ClockworkMod Recovery moechten Sie installieren?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo 3. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto normal3ger
if "%C%"=="2" goto touch3ger
if "%C%"=="3" goto onegnexger
echo.
echo Ungueltige Eingabe.
goto oneverizonger

:normal3ger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo.
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-toro.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.0-toro.img
fastboot reboot 
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:touch3ger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo.
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-toro.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.0-toro.img
fastboot reboot 
echo Sie haben CWM installiert.
adb wait-for-device
goto rootger

:driversger
cls
echo.
echo Wenn Ihre Treiber nicht funktionieren probieren Sie einen von diesen: (Den alten Treiber vorher deinstallieren):
echo 1. Samsung Treiber
echo 2. HTC Sync (Installieren Sie den Treiber, Sie brauchen HTC Sync nicht mitinstallieren)
echo 3. Sony Treiber (oeffnet eine Website)
echo 4. Motorola Device Manager 
echo 5. LG Treiber (oeffnet eine Website)
echo 6. PDAnet's Treiber (nur GNex)
echo 7. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto driver1ger
if "%C%"=="6" goto driver4ger
if "%C%"=="2" goto driver5ger
if "%C%"=="3" goto driver2ger
if "%C%"=="5" goto driver7ger
if "%C%"=="4" goto driver6ger
if "%C%"=="7" goto menuger
echo.
echo Ungueltige Eingabe.
goto driversger

:driver7ger
start http://www.lgforum.com/resources
goto menuger

:driver6ger
cls
echo Runterladen...
wget -q -N http://www.mymotocast.com/download/MDM?platform=windows
echo Motorola Device Manager wird nun installiert.
start MotorolaDeviceManager_2.2.28.exe
pause
goto menuger

:driver2ger
start http://developer.sonymobile.com/downloads/drivers/
goto menuger

:driver5ger
cls
echo Runterladen...
wget -q -N http://dl4.htc.com/managed-assets/support/software/htc-sync/htc_sync_setup_3.2.20.exe
cls
echo HTC Sync wird nun installiert.
start htc_sync_setup_3.2.20.exe
pause
goto menuger

:driver1ger
cls
echo Runterladen...
wget -q -N --no-check-certificate https://dl.dropbox.com/s/h8jraq6ubopbp0a/SAMSUNG_USB_Driver_for_Mobile_Phones_1_5_6_0.exe?dl=1
ren "SAMSUNG_USB_Driver_for_Mobile_Phones_1_5_6_0.exe?dl=1" "SAMSUNG_USB_Driver_for_Mobile_Phones_1_5_6_0.exe"
cls
echo Der Treiber wird nun installiert.
start SAMSUNG_USB_Driver_for_Mobile_Phones_1_5_6_0.exe
pause
goto menuger

:driver4ger
if exist %PROGRAMFILES(X86)% (
cls
echo Runterladen...
wget -q -N http://pdanet.co/bin/PdaNetA350x64.exe
cls
echo Der Treiber wird nun installiert.
start PdaNetA350x64.exe
pause
goto menuger
) else (
cls
echo Runterladen...
wget -q -N http://pdanet.co/bin/PdaNetA350.exe
cls
echo Der Treiber wird nun installiert.
start PdaNetA350.exe
pause
goto menuger
)

:cwmger
cls
echo.
echo Welchen ClockworkMod Recovery moechten Sie installieren?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo 3. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto normalger
if "%C%"=="2" goto touchger
if "%C%"=="3" goto menuger
echo.
echo Ungueltige Eingabe.
goto cwmger

:normalger
cls
echo.
echo Welches Geraet soll CWM bekommen?
echo.
echo 1. Samsung Galaxy Nexus 
echo 2. Samsung Galaxy S2
echo 3. Samsung Galaxy S3
echo 4. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto nexusgger
if "%C%"=="2" goto s2ger
if "%C%"=="3" goto s3ger
if "%C%"=="4" goto cwmger
echo.
echo Ungueltige Eingabe.
goto normalger

:s3ger
cls
echo 1. GT-I9300
echo 2. AT and T
echo 3. Sprint
echo 4. T-Mobile
echo 5. US Cellular
echo 6. Verizon
echo 7. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto s3origger
if "%C%"=="2" goto s3attger
if "%C%"=="3" goto s3sprintger
if "%C%"=="4" goto s3tmger
if "%C%"=="5" goto s3usger
if "%C%"=="6" goto s3verizonger
if "%C%"=="7" goto normalger
echo.
echo Ungueltige Eingabe.
goto s3ger

:s3origger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-i9300.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.2-i9300.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:s3attger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2att.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2att.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:s3sprintger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2spr.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2spr.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:s3tmger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2tmo.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2tmo.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:s3usger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2usc.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2usc.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:s3verizonger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.2-d2vzw.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.2-d2vzw.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:s2ger
cls
echo 1. AT and T
echo 2. GT-I9100
echo 3. SGH-I777
echo 4. T-Mobile
echo 5. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto s2attger
if "%C%"=="2" goto s2origger
if "%C%"=="3" goto s2sghger
if "%C%"=="4" goto s2tmger
if "%C%"=="5" goto normalger
echo.
echo Ungueltige Eingabe.
goto s2ger

:s2attger
cls
echo Ihr Geraet sollte nun NICHT im fastboot Modus sein.
pause
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-5.0.2.6-galaxys2att.zip
cls
echo Flashen ...
adb push recovery-clockwork-5.0.2.6-galaxys2att.zip /sdcard/recovery-clockwork-5.0.2.6-galaxys2att.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-5.0.2.6-galaxys2att.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo Sie haben CWM installiert.
pause
goto menuger

:s2origger
cls
echo Ihr Geraet sollte nun NICHT im fastboot Modus sein.
pause
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-i9100.zip
cls
echo Flashen ...
adb push recovery-clockwork-6.0.1.0-i9100.zip /sdcard/recovery-clockwork-6.0.1.0-i9100.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-6.0.1.0-i9100.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo Sie haben CWM installiert.
pause
goto menuger

:s2sghger
cls
echo Ihr Geraet sollte nun NICHT im fastboot Modus sein.
pause
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-i777.zip
cls
echo Flashen ...
adb push recovery-clockwork-6.0.1.0-i777.zip /sdcard/recovery-clockwork-6.0.1.0-i777.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-6.0.1.0-i777.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo Sie haben CWM installiert.
pause
goto menuger

:s2tmger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-5.0.2.7-hercules.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-5.0.2.7-hercules.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:nexusger
cls
echo 1. GSM
echo 2. Sprint
echo 3. Verizon
echo 4. zurueck
echo
set /P C=Option waehlen:
if "%C%"=="1" goto cwmgsmger
if "%C%"=="2" goto cwmsprintger
if "%C%"=="3" goto cwmverizonger
if "%C%"=="4" goto normalger
echo.
echo Ungueltige Eingabe.
goto nexusger

:cwmgsmger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-maguro.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.0-maguro.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:cwmsprintger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-toroplus.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.0-toroplus.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:cwmverizonger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-6.0.1.0-toro.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-6.0.1.0-toro.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:touchger
cls
echo.
echo Welches Geraet soll CWM bekommen?
echo.
echo 1. Samsung Galaxy Nexus 
echo 2. Samsung Galaxy S2
echo 3. Samsung Galaxy S3
echo 4. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto nexustouchger
if "%C%"=="2" goto s2touchger
if "%C%"=="3" goto s3touchger
if "%C%"=="4" goto cwmger
echo.
echo Ungueltige Eingabe.
goto touchger

:s3touchger
cls
echo 1. GT-I9300
echo 2. Sprint
echo 3. T-Mobile
echo 4. Verizon
echo 5. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto s3origtouchger
if "%C%"=="2" goto s3sprinttouchger
if "%C%"=="3" goto s3tmtouchger
if "%C%"=="4" goto s3verizontouchger
if "%C%"=="5" goto touchger
echo.
echo Ungueltige Eingabe.
goto s3touchger

:s3origtouchger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-i9300.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-i9300.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:s3sprinttouchger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-d2spr.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-d2spr.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:s3tmtouchger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-d2tmo.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-d2tmo.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:s3verizontouchger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-d2vzw.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-d2vzw.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:s2touchger
cls
echo 1. AT and T
echo 2. SGH-I777
echo 3. GT-I9100
echo 4. T-Mobile
echo 5. zurueck
echo.
set /P C=Option waehlen:
if "%C%"=="1" goto s2atttouchger
if "%C%"=="2" goto s2sghtouchger
if "%C%"=="3" goto s2s2touchger
if "%C%"=="4" goto s2tmtouchger
if "%C%"=="5" goto touchger
echo.
echo Ungueltige Eingabe.
goto s2touchger

:s2atttouchger
cls
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-5.8.1.5-galaxys2att.zip
cls
echo Flashen ...
adb push recovery-clockwork-touch-5.8.1.5-galaxys2att.zip /sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2att.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2att.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo Sie haben CWM installiert.
pause
goto menuger

:s2sghtouchger
cls
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-i777.zip
cls
echo Flashen ...
adb push recovery-clockwork-touch-6.0.1.0-i777.zip /sdcard/recovery-clockwork-touch-6.0.1.0-i777.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-touch-6.0.1.0-i777.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo Sie haben CWM installiert.
pause
goto menuger

:s2s2touchger
cls
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-5.8.1.5-galaxys2.zip
cls
echo Flashen ...
adb push recovery-clockwork-touch-5.8.1.5-galaxys2.zip /sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-touch-5.8.1.5-galaxys2.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo Sie haben CWM installiert.
pause
goto menuger

:s2tmtouchger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
adb reboot bootloader
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-hercules.img
cls
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.2-hercules.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:nexustouchger
cls
echo 1. GSM
echo 2. Sprint
echo 3. Verizon
echo 4. zurueck
echo
set /P C=Option waehlen:
if "%C%"=="1" goto cwmtouchgsmger
if "%C%"=="2" goto cwmtouchsprintger
if "%C%"=="3" goto cwmtouchverizonger
if "%C%"=="4" goto touchger
echo.
echo Ungueltige Eingabe.
goto nexustouchger

:cwmtouchgsmger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-maguro.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.0-maguro.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:cwmtouchsprintger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
echo Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-toroplus.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.0-toroplus.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:cwmtouchverizonger
cls
adb shell mv /system/recovery-from-boot.p /system/recovery-from-boot.p-old
adb shell mv /system/etc/install-recovery.sh /system/etc/install-recovery.sh-old
Runterladen...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.0-toro.img
cls
adb reboot bootloader
echo Flashen...
fastboot flash recovery recovery-clockwork-touch-6.0.1.0-toro.img
fastboot reboot
echo Sie haben CWM installiert.
pause
goto menuger

:rootger
cls
echo Ihr Geraet wird nun gerooted.
echo Runterladen...
wget -q -N http://downloads.noshufou.netdna-cdn.com/superuser/Superuser-3.1.3-arm-signed.zip
ren "Superuser-3.1.3-arm-signed.zip" "Superuser.zip"
cls
echo Flashen ...
adb push Superuser.zip /sdcard/Superuser.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/Superuser.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo Ihr Geraet wurde erfolgreich gerooted.
goto menuger

:root1ger
cls
echo Ihr Geraet sollte nun NICHT im fastboot Modus sein.
pause
echo Ihr Geraet wird nun gerooted.
echo Runterladen...
wget -q -N http://downloads.noshufou.netdna-cdn.com/superuser/Superuser-3.1.3-arm-signed.zip
ren "Superuser-3.1.3-arm-signed.zip" "Superuser.zip"
cls
echo Flashen ...
adb push Superuser.zip /sdcard/Superuser.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/Superuser.zip' >> /cache/recovery/command"
adb shell "reboot recovery"
echo Ihr Geraet wurde erfolgreich gerooted.
pause
goto menuger

:unlockger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Moechten Sie den Bootloader wirklich entsperren?" ^& vbCrLf ^& "Alle Daten werden geloescht!", _
echo 1 oder 256 oder 48, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto unlock%errorlevel%ger

:unlock1ger
del msg.vbs
cls
adb reboot bootloader
echo Wenn hier lange "Auf Geraet warten" angezeigt wird, ist Ihr Treiber nicht richtig installiert worden.
echo Wenn alles erfolgreich war werden Sie aufgefordert die Entsperrung des Bootloaders zu bestaetigen.
fastboot oem unlock
fastboot reboot
pause
goto menuger

:unlock2ger
del msg.vbs
goto menuger

:allger
cls
echo Warten Sie bis Sie eine Nachricht "Backup erfolgreich" sehen oder Ihr Geraet zum Homescreen zurueckkehrt.
adb backup -apk -shared -all -nosystem -f "%Pfad%" > search.find 2>&1
findstr "adb" search.find >nul
IF %ERRORLEVEL% EQU 1 goto allcompleteger
IF %ERRORLEVEL% EQU 0 goto allfailedger

:allcompleteger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup erfolgreich!", _
echo 1 oder 256 Or 1, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menuger

:allfailedger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup fehlgeschlagen!", _
echo 5 oder 256 oder 16, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
IF %ERRORLEVEL% EQU 2 goto menuger
IF %ERRORLEVEL% EQU 4 goto allger

:systemger
cls
echo Warten Sie bis Sie eine Nachricht "Backup erfolgreich" sehen oder Ihr Geraet zum Homescreen zurueckkehrt.
adb backup -apk -shared -all -system -f "%Pfad%" > search.find 2>&1
findstr "adb" search.find >nul
IF %ERRORLEVEL% EQU 1 goto systemcompleteger
IF %ERRORLEVEL% EQU 0 goto systemfailedger

:systemcompleteger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup erfolgreich!", _
echo 1 oder 256 oder 1, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menuger

:systemfailedger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup fehlgeschlagen!", _
echo 5 oder 256 oder 16, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
IF %ERRORLEVEL% EQU 2 goto menuger
IF %ERRORLEVEL% EQU 4 goto systemger

:appsdeviceger
cls
echo Warten Sie bis Sie eine Nachricht "Backup erfolgreich" sehen oder Ihr Geraet zum Homescreen zurueckkehrt.
adb backup -all -f "%Pfad%" > search.find 2>&1
findstr "adb" search.find >nul
IF %ERRORLEVEL% EQU 1 goto appsdeviceerfolgreichger
IF %ERRORLEVEL% EQU 0 goto appsdevicefailedger

:appsdevicecompleteger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup erfolgreich!", _
echo 1 oder 256 oder 1, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menuger

:appsdevicefailedger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup fehlgeschlagen!", _
echo 5 oder 256 oder 16, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
IF %ERRORLEVEL% EQU 2 goto menuger
IF %ERRORLEVEL% EQU 4 goto appsdeviceger

:appsger
cls
echo Warten Sie bis Sie eine Nachricht "Backup erfolgreich" sehen oder Ihr Geraet zum Homescreen zurueckkehrt.
adb backup -apk -noshared -nosystem -f "%Pfad%" > search.find 2>&1
findstr "adb" search.find >nul
IF %ERRORLEVEL% EQU 1 goto appscompleteger
IF %ERRORLEVEL% EQU 0 goto appsfailedger

:appscompleteger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup erfolgreich!", _
echo 1 oder 256 oder 1, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menuger

:appsfailedger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup fehlgeschlagen!", _
echo 5 oder 256 oder 16, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
IF %ERRORLEVEL% EQU 2 goto menuger
IF %ERRORLEVEL% EQU 4 goto appsger

:sdger
cls
echo Warten Sie bis Sie eine Nachricht "Backup erfolgreich" sehen oder Ihr Geraet zum Homescreen zurueckkehrt.
adb backup -noapk -shared -nosystem -f "%Pfad%" > search.find 2>&1
findstr "adb" search.find >nul
IF %ERRORLEVEL% EQU 1 goto sdcompleteger
IF %ERRORLEVEL% EQU 0 goto sdfailedger

:sdcompleteger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup erfolgreich!", _
echo 1 oder 256 oder 1, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menuger

:sdfailedger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Backup fehlgeschlagen!", _
echo 5 oder 256 oder 16, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
IF %ERRORLEVEL% EQU 2 goto menuger
IF %ERRORLEVEL% EQU 4 goto sdger

:restoreger
cls
adb restore "%Pfad%" > search.find 2>&1
findstr "adb" search.find >nul
IF %ERRORLEVEL% EQU 1 goto restorecompleteger
IF %ERRORLEVEL% EQU 0 goto restorefailedger

:restorecompleteger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Wiederherstellung erfolgreich!", _
echo 1 oder 256 oder 1, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
goto menuger

:restorefailedger
@echo off &setlocal
>"msg.vbs" (
echo WScript.Quit _
echo MsgBox("Wiederherstellung fehlgeschlagen!", _
echo 5 oder 256 oder 16, _
echo "Ultimate Backup Tool"^)
)
wscript "msg.vbs"
IF %ERRORLEVEL% EQU 2 goto menuger
IF %ERRORLEVEL% EQU 4 goto restoreger

:quitger
taskkill /f /im adb.exe
del msg.vbs
del version.check
del model.check
del manufacturer.check
exit