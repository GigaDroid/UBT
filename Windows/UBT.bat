@echo off
set /p "Pfad="<"path.save"
cmd /c "start /min adb.bat"
mode con lines=70 cols=89
title Ultimate Backup Tool v1.1
if exist adb.exe (
echo ADB found! Contuniuing...
) else (
echo ADB not found in path!
exit
)
ping 127.0.0.1 >nul
if not defined Pfad (
set Pfad=C:\backup\backup.ab
)
goto menu
:menu
cls
echo				 Ultimate Backup tool v1.1
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
echo If a code is below ADB is working properly:
adb devices
echo If a code is below fastboot is working properly:
fastboot devices
echo.
echo What would you like to do?
echo.
echo ##########################################Backup#########################################
echo. 
echo  1. Set path 
echo  2. Backup all without system apps	
echo  3. Backup all with system apps (unsafe)					     
echo  4. Backup app and device data (not the APKs themselves)			     
echo  5. Backup apps								     
echo  6. Backup device shared storage / SD card contents
echo  7. Backup a single app
echo  8. Restore
echo. 										     
echo #########################################################################################
echo.
echo ##########################################Tools##########################################
echo. 										     
echo  9.  Install Drivers							     
echo  10. Unlock Bootloader (only Galaxy Nexus, will wipe all data)		     
echo  11. Install CWM/ CWM Touch(only Galaxy Nexus, S2 and S3)	     
echo  12. Root your phone (requires custom recovery)				     
echo  13. All in one (only Galaxy Nexus, will wipe all data)			     
echo. 										     
echo #########################################################################################
echo. 
echo  14. Quit
echo.
set /P C=Choose a option:
if "%C%"=="9" goto drivers
if "%C%"=="13" goto one
if "%C%"=="12" goto root1
if "%C%"=="11" goto cwm
if "%C%"=="10" goto unlock
if "%C%"=="14" goto quit
if "%C%"=="8" goto restore
if "%C%"=="6" goto sd
if "%C%"=="5" goto apps
if "%C%"=="4" goto appsdevice
if "%C%"=="3" goto system
if "%C%"=="2" goto all
if "%C%"=="1" goto path 
if "%C%"=="7" goto single

:single 
cls
set /P App=List the package name (e.g. com.google.android.apps.plus) that you would like to backup:
adb backup ^<%App%^> f- %Pfad%
echo Look at your phone.
echo Wait until you see a message saying 'Backup complete' or your phone returns to the home screen.
pause
goto menu

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
echo 1. Galaxy Nexus (GSM)
echo 2. Galaxy Nexus (Sprint)
echo 3. Galaxy Nexus (Verizon) 
echo.
set /P C=Choose a option:
if "%C%"=="1" goto onegsm
if "%C%"=="2" goto onesprint
if "%C%"=="3" goto oneverizon

:onegsm
cls
adb reboot bootloader
echo Your phone will reboot sometimes, that's normal
echo If your Command Prompt displays the message "waiting for device" your driver wasn't successfully installed.
echo If all was successfull, you will be prompted to confirm that you wish to unlock the bootloader.
fastboot oem unlock
fastboot reboot
echo Continue only if the device has booted completely.
pause
echo.
echo Which ClockworkMod Recovery do you wish to install?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo.
set /P C=Choose a option:
if "%C%"=="1" goto normal1
if "%C%"=="2" goto touch1


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
echo Continue only if the device has booted completely.
pause
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
echo Continue only if the device has booted completely.
pause
goto root

:onesprint
cls
adb reboot bootloader
echo Your phone will reboot sometimes, that's normal
echo If your Command Prompt displays the message "waiting for device" your driver wasn't successfully installed.
echo If all was successfull, you will be prompted to confirm that you wish to unlock the bootloader.
fastboot oem unlock
fastboot reboot
echo Continue only if the device has booted completely.
pause
echo.
echo Which ClockworkMod Recovery do you wish to install?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo.
set /P C=Choose a option:
if "%C%"=="1" goto normal2
if "%C%"=="2" goto touch2

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
echo Continue only if the device has booted completely.
pause
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
echo Continue only if the device has booted completely.
pause
goto root

:oneverizon
cls
adb reboot bootloader
echo Your phone will reboot sometimes, that's normal
echo If your Command Prompt displays the message "waiting for device" your driver wasn't successfully installed.
echo If all was successfull, you will be prompted to confirm that you wish to unlock the bootloader.
fastboot oem unlock
fastboot reboot
echo Continue only if the device has booted completely.
pause
echo.
echo Which ClockworkMod Recovery do you wish to install?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo.
set /P C=Choose a option:
if "%C%"=="1" goto normal3
if "%C%"=="2" goto touch3

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
echo Continue only if the device has booted completely.
pause
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
echo Continue only if the device has booted completely.
pause
goto root

:drivers
cls
echo.
echo If your drivers don't work try on from these (uninstall your previous drivers first):
echo 1. Samsung Driver
echo 2. PDAnet's Driver (32-bit) (only GNex)
echo 3. PDAnet's Driver (64-bit) (only GNex)
echo 4. HTC Sync (installs the drivers, you don't need to install HTC Sync to make it work)
echo 5. Sony Drivers (will open a website)
echo 6. Motorola Device Manager 
echo 7. LG Drivers (will open a website)
echo.
set /P C=Choose a option:
if "%C%"=="1" goto driver1
if "%C%"=="2" goto driver3
if "%C%"=="3" goto driver4
if "%C%"=="4" goto driver5
if "%C%"=="5" goto driver2
if "%C%"=="7" goto driver7
if "%C%"=="6" goto driver6

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

:driver3
cls
echo Downloading...
wget -q -N http://pdanet.co/bin/PdaNetA350.exe
cls
echo The driver will now be installed
start PdaNetA350.exe
pause
goto menu

:driver4
cls
echo Downloading...
wget -q -N http://pdanet.co/bin/PdaNetA350x64.exe
cls
echo The driver will now be installed
start PdaNetA350x64.exe
pause
goto menu

:cwm
cls
echo.
echo Which ClockworkMod Recovery do you wish to install?
echo.
echo 1. Standard ClockworkMod Recovery
echo 2. ClockworkMod Touch Recovery 
echo.

echo Your phone may not be in fastboot mode.
set /P C=Choose a option:
if "%C%"=="1" goto normal
if "%C%"=="2" goto touch

:normal
cls
echo.
echo Which device schould get CWM?
echo.
echo 1. Samsung Galaxy Nexus 
echo 2. Samsung Galaxy S2
echo 3. Samsung Galaxy S3
echo.
set /P C=Choose a option:
if "%C%"=="1" goto nexus
if "%C%"=="2" goto s2
if "%C%"=="3" goto s3

:s3
cls
echo 1. GT-I9300
echo 2. AT&T
echo 3. Sprint
echo 4. T-Mobile
echo 5. US Cellular
echo 6. Verizon
echo.
set /P C=Choose a option:
if "%C%"=="1" goto s3orig
if "%C%"=="2" goto s3att
if "%C%"=="3" goto s3sprint
if "%C%"=="4" goto s3tm
if "%C%"=="5" goto s3us
if "%C%"=="6" goto s3verizon

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
echo 1. AT&T
echo 2. GT-I9100
echo 3. SGH-I777
echo 4. galaxys2 (dont ask me what this means, I have it from clockworkmod.com. If you now what it means send me a PM)
echo 5. T-Mobile
echo.
set /P C=Choose a option:
if "%C%"=="1" goto s2att
if "%C%"=="2" goto s2orig
if "%C%"=="3" goto s2sgh
if "%C%"=="4" goto s2s2
if "%C%"=="5" goto s2tm

:s2att
cls
echo Your phone may not be in fastboot mode.
pause
echo Your phone will now be rooted.
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
echo Your phone will now be rooted.
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
echo Your phone will now be rooted.
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

:s2s2
cls
echo Your phone may not be in fastboot mode.
pause
echo Your phone will now be rooted.
echo Downloading...
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-4.0.1.5-galaxys2.zip
cls
echo Flashing ...
adb push recovery-clockwork-4.0.1.5-galaxys2.zip /sdcard/recovery-clockwork-4.0.1.5-galaxys2.zip
adb shell "echo 'boot-recovery ' > /cache/recovery/command"
adb shell "echo '--update_package=/sdcard/recovery-clockwork-4.0.1.5-galaxys2.zip' >> /cache/recovery/command"
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
echo
set /P C=Choose a option:
if "%C%"=="1" goto cwmgsm
if "%C%"=="2" goto cwmsprint
if "%C%"=="3" goto cwmverizon


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
echo.
set /P C=Choose a option:
if "%C%"=="1" goto nexustouch
if "%C%"=="2" goto s2touch
if "%C%"=="3" goto s3touch

:s3touch
cls
echo 1. GT-I9300
echo 2. Sprint
echo 3. T-Mobile
echo 4. Verizon
echo.
set /P C=Choose a option:
if "%C%"=="1" goto s3origtouch
if "%C%"=="2" goto s3sprinttouch
if "%C%"=="3" goto s3tmtouch
if "%C%"=="4" goto s3verizontouch

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
echo 1. AT&T
echo 2. SGH-I777
echo 3. galaxys2 
echo 4. T-Mobile
echo.
set /P C=Choose a option:
if "%C%"=="1" goto s2atttouch
if "%C%"=="2" goto s2sghtouch
if "%C%"=="3" goto s2s2touch
if "%C%"=="4" goto s2tmtouch

:s2atttouch
cls
echo Your phone may not be in fastboot mode.
pause
echo Your phone will now be rooted.
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
echo Your phone may not be in fastboot mode.
pause
echo Your phone will now be rooted.
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
echo Your phone may not be in fastboot mode.
pause
echo Your phone will now be rooted.
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
wget -q -N http://download2.clockworkmod.com/recoveries/recovery-clockwork-touch-6.0.1.2-hercules.img
cls
adb reboot bootloader
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
echo
set /P C=Choose a option:
if "%C%"=="1" goto cwmtouchgsm
if "%C%"=="2" goto cwmtouchsprint
if "%C%"=="3" goto cwmtouchverizon

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
pause
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
cls
adb reboot
echo If your Command Prompt displays the message "waiting for device" your driver wasn't successfully installed.
echo If all was successfull, you will be prompted to confirm that you wish to unlock the bootloader.
fastboot oem unlock
fastboot reboot
pause
goto menu

:all
cls
echo Look at your phone.
echo Wait until you see a message saying 'Backup complete' or your phone returns to the home screen.
adb backup -apk -shared -all -nosystem -f %Pfad%
pause
goto menu

:system
cls
echo Look at your phone.
echo Wait until you see a message saying 'Backup complete' or your phone returns to the home screen.
adb backup -apk -shared -all -system -f %Pfad%
pause
goto menu

:appsdevice
cls
echo Look at your phone.
echo Wait until you see a message saying 'Backup complete' or your phone returns to the home screen.
adb backup -all -f %Pfad%
pause
goto menu

:apps
cls
echo Look at your phone.
echo Wait until you see a message saying 'Backup complete' or your phone returns to the home screen.
adb backup -apk -noshared -nosystem -f %Pfad%
pause
goto menu

:sd
cls
echo Look at your phone.
echo Wait until you see a message saying 'Backup complete' or your phone returns to the home screen.
adb backup -noapk -shared -nosystem -f %Pfad%
pause
goto menu

:restore
cls
echo Look at your phone and type your password.
adb restore "%Pfad%"
pause
goto menu

:quit
taskkill /f /im adb.exe
exit
:end
