@echo off

rem ********************** �ݒ�ӏ� **********************************
rem �� OBS studio (64bit) �̃p�X���w��
set obs_path="C:\Program Files\obs-studio\bin\64bit"
rem �� OBS studio (64bit) �̎��s�t�@�C�������w��
set obs_exe_name="obs64.exe"
rem �� OBS studio�Œǉ������^��p�̃V�[����
set scene_name="DesktopRecording"
rem �� OBS studio�Ř^�����߂�L�[����
set rec_key=121
rem reference: https://learn.microsoft.com/ja-jp/windows/win32/inputdev/virtual-key-codes
rem ******************************************************************

set VBS_rec_command="Set a=CreateObject(""Excel.Application""):a.ExecuteExcel4Macro(""CALL(""""user32"""",""""keybd_event"""",""""JJJJJ"""",%rec_key%,0,1,0)""):a.ExecuteExcel4Macro(""CALL(""""user32"""",""""keybd_event"""",""""JJJJJ"""",%rec_key%,0,2,0)""):close()"

set rec_end_time_min=

:time_setting
set /P rec_end_time_min="Enter the recording time (min) :"
if "%rec_end_time_min%" == "" ( goto :time_setting)

set /a rec_end_time_sec=%rec_end_time_min% * 60

rem OBS studio���E�C���h�E�ŏ�����ԂŋN�����Ę^��J�n
cd %obs_path%
start "" %obs_exe_name% --scene %scene_name% --minimize-to-tray --disable-shutdown-check --startrecording
rem �w��̎��Ԃ����ҋ@
echo recording...
powershell sleep %rec_end_time_sec%

rem ���R�[�h�J�n�E�I���̃z�b�g�L�[�����s
mshta vbscript:execute(%VBS_rec_command%)
echo wait for rendering...
powershell sleep 1
rem OBS studio�̋����I��
taskkill /IM %obs_exe_name% /T

