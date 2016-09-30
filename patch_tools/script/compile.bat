@echo off
setlocal enabledelayedexpansion

echo ==============����  ��ʼ================

rem ========= ���� ================
rem ��ʼ�汾��
set startVersion=%1

rem ��Ϸ�汾��
set gameVersion=%2

rem ƽ̨��ʶ
set platformname=%3

rem ƽ̨����
set platformtype=%4

rem ��Դ�汾������
set resSvnVersionBegin=%5
set resSvnVersionEnd=%6

rem ��Ʒ�� ��ԴSVN·��
set resSvnPath=%7

rem ���� 1 ���� 0
set traditional=%8

:: ===Ĭ����·===
set svn_line=%9

:: :: ===��Ŀѡ��===
shift /0
set choose_project=%9

::  ===�豸���ͣ�android/ios��===
shift /0
set device=%9

:: ===��Դ�ļ�������===
shift /0
set resources_name=%9



for /f "tokens=1-5 delims=:." %%a in ("%gameVersion%") do (
set /a "bigVersion=%%a,cVersion=%%b,cVersion2=%%c,resVersion2=%%d,resVersion=%%e"
)

if exist script/project/%choose_project%/compile.bat (
	echo ====��Ŀ�ڱ��� ����Ŀ�Լ����������������� �ѱ��������Դ��������Ŀ¼%resources_name%====
	call script/project/%choose_project%/compile.bat %gameVersion% %platformtype% %resSvnVersionBegin% %resSvnVersionEnd% %traditional% %svn_line% %device% %resources_name% %choose_project%
	echo ====��Ŀ�ڱ��� end===
)
:: ====������Դ ����fbbres�� �ύsvn====
call script/upload.bat %gameVersion% %resSvnPath% %resources_name%

::echo ====fbbres\%resources_name%\
svn update fbbres\%resources_name%\

::call script/comparison.bat %last_release_svn_version% %endVersion% %svnPath% %resVersion% %gameVersion% %versionfilePath%
echo ==============����  ����================
pause