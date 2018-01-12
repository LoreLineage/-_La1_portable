@echo off

rem ## ��������� ���� ��������
pushd %~dp0

rem ## ��������, ���� ��� ����� �� ������� � :NOTSTARTED
if NOT exist udrive\DB\data\mysql_mini.pid goto :NOTSTARTED
if NOT exist udrive\www\usr\local\apache2\logs\httpd.pid goto :NOTSTARTED

rem ## ��������, �� ����������, �� ��������
SET /P pid=<udrive\DB\data\mysql_mini.pid
netstat -anop tcp | FIND /I " %pid%" >NUL
IF ERRORLEVEL 1 goto :NOTRUNNING
IF ERRORLEVEL 0 goto :RUNNING
SET /P pid=<udrive\www\usr\local\apache2\logs\httpd.pid
netstat -anop tcp | FIND /I " %pid%" >NUL
IF ERRORLEVEL 1 goto :NOTRUNNING
IF ERRORLEVEL 0 goto :RUNNING 

:NOTRUNNING
rem ## Not shutdown using mysql_stop.bat hence delete file
del udrive\DB\data\mysql_mini.pid
del udrive\www\usr\local\apache2\logs\httpd.pid 

:NOTSTARTED
rem ## ��������� ������� ������� ������� �� ���� MySQL �����
netstat -anp tcp | FIND /I "0.0.0.0:3311" >NUL
IF ERRORLEVEL 1 goto NOTFOUND
echo  cannot run MySQL on port  3311
netstat -anp tcp | FIND /I "0.0.0.0:8088" >NUL
IF ERRORLEVEL 1 goto NOTFOUND
echo  cannot run Apache on port 8088 
goto END

:NOTFOUND
echo  Port 3311 is free - OK to run server
echo  Port 8088 is free - OK to run server
rem ## ����� ������ ��������� ����� �����
for %%a in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do CD %%a: 1>> nul 2>&1 & if errorlevel 1 set freedrive=%%a

rem ## ������������ �������� ����� ��������� �����, ���� ������� ������ �������� freedrive
set Disk=%1
if "%Disk%"=="" set Disk=%freedrive%

rem ## � ���� ����� �����, ������� "rem" � �������� leter �����
rem set Disk=w

rem ## �����, ����� ����� ����� ������������, �������� ����
subst %Disk%: "udrive"

rem ## ��������� ����� ����� � ����. ������������ stop.bat 
(set /p dummy=%Disk%) >udrive\DB\data\drive.txt <nul
(set /p dummy=%Disk%) >udrive\www\usr\local\apache2\logs\drive.txt <nul

rem ## Set variable paths
set apachepath=\www\usr\local\apache2\
set apacheit=%Disk%:%apachepath%bin\Apache_8.exe -f %apachepath%conf\httpd.conf -d %apachepath%.
 
rem ## ������ �������
%Disk%:
:start \DB\bin\mysqld-opt.exe --defaults-file=/bin/my-small.cnf
start \DB\bin\mysqld-opt.exe
start %Disk%:\home\admin\program\uniserv.exe "%apacheit%" 

rem ## ���������� ��� ������������
CLS
echo.
echo  ##########################################################
echo  The Web server is working on disk %Disk%:\  localhost:8088
echo.
echo  The MySQL server is working on disk %Disk%:\ [port 3311]
echo  ##########################################################
echo.
goto :END

:RUNNING
CLS
echo.
echo  This Apache server is already running.
echo  This MySQL server already running.
echo  You can stop the server using mysql_stop.bat

:END
echo.
pause

rem ## Return to caller
popd