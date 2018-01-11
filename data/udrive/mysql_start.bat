@echo off

rem ## Save return path
pushd %~dp0

rem ## Check to see if already stopped
if NOT exist DB\data\mysql_mini.pid goto :NOTSTARTED

rem ## It exists is it running
SET /P pid=<DB\data\mysql_mini.pid
netstat -anop tcp | FIND /I " %pid%" >NUL
IF ERRORLEVEL 1 goto :NOTRUNNING
IF ERRORLEVEL 0 goto :RUNNING 

:NOTRUNNING
rem ## Not shutdown using mysql_stop.bat hence delete file
del DB\data\mysql_mini.pid 

:NOTSTARTED
rem ## Check for another server on this MySQL port
netstat -anp tcp | FIND /I "0.0.0.0:3311" >NUL
IF ERRORLEVEL 1 goto NOTFOUND
echo.
echo  Another server is running on port 3311 cannot run MySQL server
echo.
goto END

rem ## Start server
%Disk%:
:start \bin\mysqld-opt.exe --defaults-file=/bin/my-small.cnf
start \bin\mysqld-opt.exe

rem ## Info to user
CLS
echo.
echo  The MySQL server is working on disk %Disk%:\ [port 3311]
goto :END

:RUNNING
CLS
echo.
echo  This MySQL server already running.
echo  You can stop the server using mysql_stop.bat

:END
echo.
pause

rem ## Return to caller
popd