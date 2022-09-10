# List of all current Functions with a basic description.


## Initialization Functions and Variables
---
Set-Var : Creates a standard variable for three items re-used throughout almost every other function in this module. 

1. Date - Simple MM-DD-YY format.
2. Log - Standardizes C:\Logs for all logging and results.
3. Temp - Standardizes C:\Temp for downloading neccessary files to disk.

---

### Get-BatteryDiagnostics

This command will generate a few power reports and copy them to the $Log directory. This is especially useful when diagnosing charging or sleep issues for laptops. 

1. System Sleep Diagnostics
2. Sleep Study Report
3. Battery Report 
4. System Power Report

---
### Get-RepairLogs

This command gathers SFC, DISM, and Chkdsk logs and combines them in the $Log Directory. Currently it will pull the last 150 lines of the SFC and DISM reports to make them a little more manageable. 

---
### Install-PoweshellCore

This was a fun project to assist with updating PowershellCore. It requires another module to download the correct (latest) version from GitHub. 

Dependancies - PSReleaseTools
Pre-Configured Download - Windows x64

---
### New-Password

Generates a random password based on 5+ character word and some random numbers.

---
### Get-PSExec

Downloads PSExec from Microsoft and unzips it into a temp folder. Has a parameter for -Regedit which will open a system level regedit window in the session.

---
### Get-Sysmon

Downloads and installs Sysmon from Sysinternals