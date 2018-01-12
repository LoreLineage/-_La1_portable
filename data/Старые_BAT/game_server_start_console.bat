@echo off 
title L1J-En Server Console 
:start
%CDROM%udrive\bin\java.exe -version
%CDROM%udrive\bin\java.exe -server -Xmx1024m -Xincgc -cp -Djava.library.path="%CDROM%udrive\l1jserver.jar";-Djava.library.path="%CDROM%udrive\lib\slf4j-api-1.7.5.jar";-Djava.library.path="%CDROM%udrive\lib\slf4j-simple-1.7.5.jar";-Djava.library.path="%CDROM%udrive\lib\guava-17.0.jar";-Djava.library.path="%CDROM%udrive\lib\bonecp-0.8.0.RELEASE.jar";-Djava.library.path="%CDROM%udrive\lib\mysql-connector-java-5.1.31-bin.jar";-Djava.library.path="%CDROM%udrive\lib\javolution.jar"
l1j.server.Server
pause
if ERRORLEVEL 2 goto restart 
if ERRORLEVEL 1 goto error 
goto end 
:restart 
echo Admin Restart ... 
:error 
echo Server terminated abnormaly 
:end 
echo server terminated 