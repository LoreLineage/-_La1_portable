@echo off
rem ## Получаю букву диска
SET /P Disk=<drive.txt
rem ## Удаляю файл с запилью о букве диска
del drive.txt
rem ## Удаляю виртуальный диск
subst %Disk%: /D