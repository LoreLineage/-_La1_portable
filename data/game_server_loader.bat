@echo off 
title serverloader 
:start
%CDROM%udrive\bin\java.exe -version
%CDROM%udrive\bin\java.exe -server -Xms512m -Xmx512m -Djava.library.path="%CDROM%udrive\l1jloader.jar;
pause