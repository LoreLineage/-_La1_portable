@echo off
rem ## Сохраняю путь
pushd %~dp0
rem ## Проверяю, не остановлено ли?
if NOT exist SQL\data\mysql_mini.pid goto :NOTSTARTED
rem ## Он существует?, он работает?
SET /P pid=<SQL\data\mysql_mini.pid
netstat -anop tcp | FIND /I " %pid%" >NUL
IF ERRORLEVEL 1 goto :NOTRUNNING
IF ERRORLEVEL 0 goto :RUNNING 
:NOTRUNNING
rem ## Если сервер упал, удаляем файл
del SQL\data\mysql_mini.pid 
:NOTSTARTED
rem ## Проверяю не занят ли порт
netstat -anp tcp | FIND /I "0.0.0.0:3311" >NUL
IF ERRORLEVEL 1 goto NOTFOUND
echo Port 3311 NOT FREE
goto END
rem ## Запускаю сервер
%Disk%:
:start SQL\bin\mysqld-opt.exe --defaults-file=/SQL/bin/my-small.cnf
start SQL\bin\mysqld-opt.exe
rem ## Информация для пользователя
CLS
echo  MySQL working %Disk%:\ [port 3311]
goto :END
:RUNNING
CLS
echo.
echo  MySQL already running.
:END
echo.
pause
rem ## Возврат
popd