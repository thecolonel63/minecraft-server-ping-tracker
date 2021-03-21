@echo off
cls
set /p addr="Enter Address: "
set /p port="Enter Port (Leave blank for 25565): "
if not defined %%port%% set port=25565
cd %cd%\working_dir\
type %cd%\text\text1.txt>%cd%\ping\view_serverping.php
echo %addr%' ); >> %cd%\ping\view_serverping.php
type %cd%\text\text2.txt>>%cd%\ping\view_serverping.php
echo %port%' ); >> %cd%\ping\view_serverping.php
type %cd%\text\text3.txt>>%cd%\ping\view_serverping.php
cd..