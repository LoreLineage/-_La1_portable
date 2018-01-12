@echo off
rem ## Поск свободной буквы диска
for %%a in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do CD %%a: 1>> nul 2>&1 & if errorlevel 1 set freedrive=%%a
rem ## Используем параметр пакетного файла, если он включен freedrive
set Disk=%1
if "%Disk%"=="" set Disk=%freedrive%
rem ## Чтобы присвоить постоянную букву диску, удалить «rem» и сменить букву диска
rem set Disk=w
rem ## Определив, какую букву использовать, создаем диск
subst %Disk%: "udrive"
rem ## Сохраняем букву диска в файл. для стоп-бат 
(set /p dummy=%Disk%) >\drive.txt <nul
rem ## Устанавливаем переменные пути
set apachepath=\usr\local\apache2\
set apacheit=%Disk%:%apachepath%bin\Apache_8.exe -f %apachepath%conf\httpd.conf -d %apachepath%.
pause