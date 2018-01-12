@echo off
echo.
rem ## Save return path
pushd %~dp0

rem ## Check to see if already stopped
if NOT exist udrive\DB\data\mysql_mini.pid goto :ALREADYKILLED
if NOT exist udrive\www\usr\local\apache2\logs\httpd.pid goto :ALREADYKILLED

rem ## It exists is it running
SET /P pid=<udrive\DB\data\mysql_mini.pid
netstat -anop tcp | FIND /I " %pid%" >NUL
IF ERRORLEVEL 1 goto :NOTRUNNING
IF ERRORLEVEL 0 goto :RUNNING
SET /P pid=<udrive\www\usr\local\apache2\logs\httpd.pid
netstat -anop tcp | FIND /I " %pid%" >NUL
IF ERRORLEVEL 1 goto :NOTRUNNING
IF ERRORLEVEL 0 goto :RUNNING 

:NOTRUNNING
rem ## Not running clean-up
del udrive\DB\data\mysql_mini.pid
del udrive\www\usr\local\apache2\logs\httpd.pid 
goto :ALREADYKILLED

rem ## It is running so shut server down
:RUNNING
rem ## Getdrive letter
SET /P Disk=<udrive\DB\data\drive.txt
SET /P Disk=<udrive\www\usr\local\apache2\logs\drive.txt

rem ## Kill Apache process and all it's sub-processes
SET killstring= -t "%pid%"
udrive\www\home\admin\program\pskill.exe  Apache_8.exe c
echo  Apache Stopped

rem ## Kill SQL server
SET killstring= -t "%pid%"
udrive\DB\bin\mysqladmin.exe --port=3311 --user=root --password=root shutdown
echo  MySQL Stopped

rem ## Remove pid file server was closed
del udrive\DB\data\mysql_mini.pid
del udrive\www\usr\local\apache2\logs\httpd.pid

rem ## Remove disk file
del udrive\DB\data\drive.txt
del udrive\www\usr\local\apache2\logs\drive.txt

rem ## Kill drive
subst %Disk%: /D

goto :END

:ALREADYKILLED
echo  MySQL already stopped
echo  Apache already stopped
:END
echo.
pause


rem ## Return to caller
popd