@echo off

rem ********************** 設定箇所 **********************************
rem ↓ ffmpeg.exe のパスを指定
set ffmpeg_path=C:\ffmpeg-4.3.2-2021-02-27-full_build\bin\ffmpeg.exe
rem ******************************************************************

set rec_URL=
set filename=
set rec_start_time=
set rec_end_time=
set append_command=
set ts_filename=
set mp3_filename=

:target_URL
set /P rec_URL="Enter the URL to record  :"
if "%rec_URL%" == "" ( goto :target_URL )

:target_filename
set /P filename="[Optional] Enter the file name to save (default is yyyy-MMdd-hhmmss) :"
if "%filename%" == "" ( set filename= 
) else ( set mp3_filename=%filename%.mp3 )


@REM set /P rec_start_time="[Optional] Enter the start time (HH:MM:SS) :"
set /P rec_end_time="[Optional] Enter the recording time (HH:MM:SS, default is unlimited) :"


rem 時刻によるファイル名の自動設定
set rec_date=%date%
set rec_time=%time%
set y=%rec_date:~0,4%
set Mth=%rec_date:~5,2%
set d=%rec_date:~8,2%
set h=%rec_time:~0,2%
set m=%rec_time:~3,2%
set s=%rec_time:~6,2%

rem 任意引数の設定
if "%rec_end_time%" == "" ( set append_command= 
) else ( set append_command=--hls-duration %rec_end_time% )

rem ファイル名の自動設定
if "%filename%" == "" ( mp3_filename=%y%-%Mth%%d%-%h%%m%%s%.mp3 )

rem Streamlinkによる録音実行
set ts_filename=%y%-%Mth%%d%-%h%%m%%s%.ts
Streamlink %rec_URL% --default-stream best %append_command% -o %ts_filename%

rem ffmpegによるmp3変換
%ffmpeg_path% -i %ts_filename% %mp3_filename%
del %ts_filename%