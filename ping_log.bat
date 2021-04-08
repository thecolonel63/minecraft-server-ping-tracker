@echo off

:download_section

if not exist "%cd%\working_dir\has_seen_vbs_message" goto download_vbs

if not exist "%cd%\working_dir\has_seen_audio_message" goto download_audio_notifier

if exist "%cd%\working_dir\write_names.bat" call "%cd%\working_dir\write_names.bat"

call "%cd%\working_dir\address.bat"

goto new_ping

:new_ping

call "%cd%\working_dir\ping.bat"

fc "%cd%\working_dir\out_original.txt" "%cd%\working_dir\stored_out_original.txt">nul 2>&1

set SEL=%ERRORLEVEL%

type "%cd%\working_dir\out_original.txt" | findstr online>"%cd%\working_dir\online.txt"

fc "%cd%\working_dir\online.txt" "%cd%\working_dir\online_stored.txt">nul 2>&1

set DIFFCOUNT=%ERRORLEVEL%

fc "%cd%\working_dir\out_original.txt" "%cd%\working_dir\text\no_info.txt">nul 2>&1

set NOINFO=%ERRORLEVEL%

fc "%cd%\working_dir\out_original.txt" "%cd%\working_dir\text\blank.txt">nul 2>&1

set BLANK=%ERRORLEVEL%

cls

if %SEL% geq 1 if %NOINFO% geq 1 if %BLANK% geq 1 if %DIFFCOUNT% geq 1 goto copy

goto new_ping

:copy

copy "%cd%\working_dir\out_original.txt" "%cd%\working_dir\stored_out_original.txt"nul 2>&1

type "%cd%\working_dir\stored_out_original.txt" | findstr online>"%cd%\working_dir\online_stored.txt"

echo ===================================================================== >>log.txt

echo %date% %time:~0,-3%>>%cd%\log.txt

type "%cd%\working_dir\stored_out_original.txt" | findstr [ | findstr /v Array | findstr /v sample >>"%cd%\log.txt"

echo ===================================================================== >>log.txt

if exist "%cd%\working_dir\open_log.vbs" start "%cd%\working_dir\open_log.vbs"

if exist "%cd%\working_dir\player_detector.bat" start /min "%cd%\working_dir\player_detector.bat"

goto new_ping

:download_vbs

cls

choice /m "Install On-Screen Log Update Notifier?"

if %ERRORLEVEL% equ 1 curl -L https://www.dropbox.com/s/lpi4wn9y04b6ps1/open_log.vbs?dl=1 --output "%cd%\working_dir\open_log.vbs"

echo.>"%cd%\working_dir\has_seen_vbs_message"

goto download_section

:download_audio_notifier

cls

choice /m "Install individual player audio notifier?"

set AUDLVL=%ERRORLEVEL%

if %AUDLVL% equ 1 curl -L https://www.dropbox.com/s/0od62w64p5g0auk/player_detector.bat?dl=1 --output "%cd%\working_dir\player_detector.bat"

if %AUDLVL% equ 1 mkdir "%cd%\working_dir\sounds"

if %AUDLVL% equ 1 curl -L https://www.dropbox.com/s/zy8dyte46wv38o9/generic.wav?dl=1 --output "%cd%\working_dir\sounds\generic.wav"

if %AUDLVL% equ 1 curl -L https://www.dropbox.com/s/v8raeg2ui8p8dbe/write_names.bat?dl=1 --output "%cd%\working_dir\write_names.bat"

echo.>"%cd%\working_dir\has_seen_audio_message"

goto download_section