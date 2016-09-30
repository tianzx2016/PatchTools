@echo off
setlocal enabledelayedexpansion

for /f "tokens=1,2 delims==" %%a in (config.ini) do (
:: ===��Ŀѡ��===
  if "%%a"=="choose_project" set choose_project=%%b
:: ===�豸���ͣ�android/ios��===
  if "%%a"=="device_type" set device_type=%%b
:: ===ƽ̨����===
  if "%%a"=="platform_type" set platform_type=%%b
:: ===Ĭ����·===
  if "%%a"=="svn_line" set svn_line=%%b
:: ===��������===
  if "%%a"=="language_type" set language_type=%%b
::===�汾��Res��svn��ַ===
  if "%%a"=="res_svn" set res_svn=%%b
::===������FBB��svn��ַ===
  if "%%a"=="fbb_svn" set fbb_svn=%%b
::===��Դ�ļ�������(cocos2dxĬ��Resources��U3D��Ĭ��StreamingAssets)===
  if "%%a"=="resources_name" set resources_name=%%b
 )
echo �˶Բ�����Ϣ��
echo ��Ŀѡ��choose_project��:         %choose_project%
echo �豸���ͣ�device_type��:            %device_type%
echo ƽ̨���ͣ�platform_type��:          %platform_type%
echo Ĭ����·��svn_line��:               %svn_line%
echo �������ͣ�language_type��:          %language_type%
echo �汾��Res��res_svn��:               %res_svn%
echo ������FBB��fbb_svn��:               %fbb_svn%
echo ��Դ�ļ������֣�resources_name��:   %resources_name%

::�������Ŀ��ȡ��Ŀ����������� ���浽configadd.txt
if exist script/project/%choose_project%/projectsettings.bat (
	call script/project/%choose_project%/projectsettings.bat %choose_project%
)

::��ȡ�����svn�ű�
call script/svninit.bat %choose_project% %device_type% %platform_type% %svn_line% %language_type% %res_svn% %fbb_svn% %resources_name%

pause