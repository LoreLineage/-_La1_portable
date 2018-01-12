@echo off
rem ## Сохраняю путь
pushd %~dp0
rem ## Проверяю, не остановлено ли?
if NOT exist SQL\data\mysql_mini.pid goto :ALREADYKILLED
rem ## Он существует?, он работает?
SET /P pid=<SQL\data\mysql_mini.pid
netstat -anop tcp | FIND /I " %pid%" >NUL
IF ERRORLEVEL 1 goto :NOTRUNNING
IF ERRORLEVEL 0 goto :RUNNING 
:NOTRUNNING
rem ## Если сервер упал, удаляем файл
del SQL\data\mysql_mini.pid 
goto :ALREADYKILLED
rem ## It is running so shut server down
:RUNNING
rem ## Getdrive letter
SET /P Disk=<SQL\data\drive.txt

rem ## Remove pid file server was closed
del SQL\data\mysql_mini.pid

rem ## Remove disk file
del SQL\data\drive.txt

rem ## Kill server
SQL\bin\mysqladmin.exe --port=3311 --user=root --password=root shutdown

rem ## Kill drive
subst %Disk%: /D

echo  MySQL Stopped

goto :END

:ALREADYKILLED
echo  MySQL already stopped
:END
echo.

pause

rem ## Return to caller
popd