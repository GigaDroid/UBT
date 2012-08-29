#!/bin/bash
# =========================================================================
# Configuration
# =========================================================================
# 1. Configure where your ADB binary is installed
export AdbCmd="<Path_to_ADB_Binary>"
if [ ! -f ${AdbCmd} ]; then
	"Exiting now: Could not find adb command"
	exit 100
fi

# 2. Configure your backup file
export BackupDir="<Path_to_your_Backup>"
if [ ! -d ${BackupDir} ]; then
	mkdir -p $BackupDir
fi

# 3. Configure your backup file name (e.g: backup_20120828.ab)
# e.g: export BackupFileName="backup_$(date +%F).ab"
export BackupFileName="backup_$(date +"%Y-%m-%d_%H-%M").ab"

# 4. Make sure this script is executable
# chmod u+x backup_android_to_mac.sh

# =========================================================================
# Do not change below here ( Credits go to Gigadroid from xda-developers)
# =========================================================================
clear

cat <<_EOI


				    * Ultimate Backup tool *
				        by Gigadroid
				     xda-developers.com

 Notices: 
 - Make sure that USB Debugging is enabled!
 - This will not back up SMS messages!
 - Set a desktop backup password under Developer Options. It seems it would fail otherwise!
 - The backup will be saved in ${BackupDir}/${BackupFileName}. Configure in Script
 - The script will try to create the backup directory if it can (check permissions)
 
 ------------------------------
 - IMPORTANT: Pre-requisites
 ------------------------------
 
 Open script and modify in the configuration part the following:
 
 a. Path to the adb binary
 b. Configure youd Backup Directory
 c. Configure the backup file name
 d. Make sure this script is executable (e.g: chmod u+x $(basename $0))
 
--------------------------------
- ** MENU **
- (ctrl-c or 7 exits)
--------------------------------

 What would you like to do?

 1. Backup all without system apps
 2. Backup all with system apps (unsafe)
 3. Backup app and device data (not the APKs themselves)
 4. Backup apps
 5. Backup device shared storage / SD card contents
 6. Restore. Choose Backup to restore. This will ask for a filename (with complete path)
 7. Quit

_EOI

read input

case $input in
    1)
        echo "Look at your phone."
		echo "Wait until you see a message saying 'Backup complete' or your phone returns to the home screen."
		${AdbCmd} backup -apk -shared -all -nosystem -f $BackupDir/${BackupFileName} 
		ExitCode=$?
		;;
    2)
        echo "Look at your phone."
		echo "Wait until you see a message saying 'Backup complete' or your phone returns to the home screen."
		${AdbCmd} backup -apk -shared -all -system -f $BackupDir/${BackupFileName} 
		ExitCode=$?
		;;
	3)
		echo "Look at your phone."
		echo "Wait until you see a message saying 'Backup complete' or your phone returns to the home screen."
		${AdbCmd} backup -all -f $BackupDir/${BackupFileName}
		ExitCode=$?
		;;
	4)
		echo "Look at your phone."
		echo "Wait until you see a message saying 'Backup complete' or your phone returns to the home screen."
		${AdbCmd} backup -apk -noshared - nosystem -f $BackupDir/${BackupFileName}
		ExitCode=$?
		;;
	5)
		echo "Look at your phone."
		echo "Wait until you see a message saying 'Backup complete' or your phone returns to the home screen."
		${AdbCmd} backup -noapk -shared -nosystem -f $BackupDir/${BackupFileName}
		ExitCode=$?
		;;
	6) 
		echo "Look at your phone and type your password."
		read FileNameInput
		if [  -f $FileNameInput ]; then
			${AdbCmd} restore ${FileNameInput}	
			ExitCode=$?
		else
			echo "ERR: Could not find file. Please check backup file exists and try again. Copy COMPLETE path correctly"
			exit 100
		fi
                ;;
	7)
		echo "Do nothing: exit"
		exit 0
		;;
	*) echo "Wrong input. Exiting now"
		ExitCode=100 ;;
esac

if [ $ExitCode -gt 0 ]; then
	echo "An error ocurred!"
else
	echo "SUCESSS!!!"
fi

exit $ExitCode