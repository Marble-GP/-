@echo off

rem ********************** 設定箇所 **********************************
rem ↓ OBS studio (64bit) のパスを指定
set obs_path="C:\Program Files\obs-studio\bin\64bit"
rem ↓ OBS studio (64bit) の実行ファイル名を指定
set obs_exe_name="obs64.exe"
rem ↓ OBS studioで追加した録画用のシーン名
set scene_name="DesktopRecording"
rem ↓ OBS studioで録画をやめるキー入力
set rec_key=121
rem reference: https://learn.microsoft.com/ja-jp/windows/win32/inputdev/virtual-key-codes
rem ******************************************************************

set VBS_rec_command="Set a=CreateObject(""Excel.Application""):a.ExecuteExcel4Macro(""CALL(""""user32"""",""""keybd_event"""",""""JJJJJ"""",%rec_key%,0,1,0)""):a.ExecuteExcel4Macro(""CALL(""""user32"""",""""keybd_event"""",""""JJJJJ"""",%rec_key%,0,2,0)""):close()"

set rec_end_time_min=

:time_setting
set /P rec_end_time_min="Enter the recording time (min) :"
if "%rec_end_time_min%" == "" ( goto :time_setting)

set /a rec_end_time_sec=%rec_end_time_min% * 60

rem OBS studioをウインドウ最小化状態で起動して録画開始
cd %obs_path%
start "" %obs_exe_name% --scene %scene_name% --minimize-to-tray --disable-shutdown-check --startrecording
rem 指定の時間だけ待機
echo recording...
powershell sleep %rec_end_time_sec%

rem レコード開始・終了のホットキーを実行
mshta vbscript:execute(%VBS_rec_command%)
echo wait for rendering...
powershell sleep 1
rem OBS studioの強制終了
taskkill /IM %obs_exe_name% /T

