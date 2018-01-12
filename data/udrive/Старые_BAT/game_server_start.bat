@echo off 
title gameserver 
:start
%CDROM%udrive\bin\java.exe -version
%CDROM%udrive\bin\java.exe -server -Xmx512m -Xincgc -jar -Djava.library.path="%CDROM%udrive\l1jserver.jar
PAUSE