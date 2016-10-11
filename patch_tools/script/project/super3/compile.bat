@echo off
setlocal enabledelayedexpansion

set resourcesDIR=res

:: ��Ϸ�汾��
set gameVersion=%1
:: ƽ̨����
set platformtype=%2
:: ��Դ�汾������
set resSvnVersionBegin=%3
set resSvnVersionEnd=%4
:: ��Ʒ�� ��ԴSVN·��
::set resSvnPath=%5
:: ���� 1 ���� 0
set traditional=%5
:: ===Ĭ����·===
set svn_line=%6
::  ===�豸���ͣ�android/ios��===
set device=%7
:: ===��Դ�ļ�������===
set tmpResDir=%8
::������
set choose_project=%9
:: �Ƿ�����Դ(projectsetting.bat������)
for /f "tokens=1,2 delims==" %%a in (script\project\%choose_project%\configadd.ini) do (
  if "%%a"=="pack_pic" set packpic=%%b
 )

echo gameVersion:%gameVersion%
echo packpic:%packpic%
echo platformtype:%platformtype%
echo resSvnVersionBegin:%resSvnVersionBegin%
echo resSvnVersionEnd:%resSvnVersionEnd%
::echo resSvnPath:%resSvnPath%
echo traditional:%traditional%
echo svn_line:%svn_line%
echo device:%device%
echo tmpResDir:%tmpResDir%

echo ===��ʼ���²�Ʒ��res_svn===
svn update %resourcesDIR%\%tmpResDir%
echo �ɹ���


echo ===========================================================================
echo ͼƬ�ļ����... 
CD res\src
::if %resSvnVersionBegin% GTR 0 (
	if %packpic%==2 (
		echo =========================1.������Դ������ͼ��========================
		call setup-client.bat %svn_line% %platformtype% nopic %traditional% %device% %resSvnVersionBegin% %resSvnVersionEnd%
	)
	if %packpic%==1 (
		echo =========================2.������Դ����ͼ��========================
		call setup-client.bat %svn_line% %platformtype% %device% %traditional% %device% %resSvnVersionBegin% %resSvnVersionEnd%
	)
::)
::if %resSvnVersionBegin%==0 (
	if %packpic%==4 (
		echo =========================3.������Դ������ͼ��========================
		call setup-client.bat %svn_line% %platformtype% nopic %traditional% %device%
	)
	if %packpic%==3 (
		echo =========================4.������Դ����ͼ��========================
		call setup-client.bat %svn_line% %platformtype% %device% %traditional% %device%
	)
::)
PUSHD %~dp0
cd ..\..\..

echo �ɹ���
echo %CD%============
echo ===========================================================================
echo ����Lua�ļ�����ʱĿ¼... %tmpResDir%
if exist %tmpResDir% rd /s /q %tmpResDir%
md %tmpResDir%
xcopy /e /q %resourcesDIR%\%tmpResDir% %tmpResDir%

if exist %tmpResDir%\db rd /s /q %tmpResDir%\db
md %tmpResDir%\db
for /f "tokens=*" %%i in ('dir /b %resourcesDIR%\outputClient\*.lua') do (
xcopy /s /q "%resourcesDIR%\outputClient\%%i" "%tmpResDir%\db"
)
echo �ɹ���
echo ���ڣ���Ŀ�ڣ�
echo ===========================================================================
echo ɾ�������ļ����ļ��� 
if exist %tmpResDir%\*.exe del %tmpResDir%\*.exe
if exist %tmpResDir%\.svn rd /s /q %tmpResDir%\.svn
if exist %tmpResDir%\interface rd /s /q %tmpResDir%\interface
if exist %tmpResDir%\*.dll del %tmpResDir%\*.dll
if exist %tmpResDir%\*.lib del %tmpResDir%\*.lib
if exist %tmpResDir%\*.pdb del %tmpResDir%\*.pdb
if exist %tmpResDir%\*.ini del %tmpResDir%\*.ini
if exist %tmpResDir%\Icon.png del %tmpResDir%\Icon.png
if exist %tmpResDir%\db\Image rd /s /q %tmpResDir%\db\Image
echo �ɹ���
echo ���ڣ���Ŀ�ڣ�
echo ===========================================================================
echo ��ʼ����LUA... 
::echo ===%CD%\%tmpResDir%
script\tools\encodelua.exe %CD%\%tmpResDir%
xcopy /e /y /q %tmpResDir%\encode %tmpResDir%
rd /s /q %tmpResDir%\encode
if exist %tmpResDir%\codecover rd /s /q %tmpResDir%\codecover
echo �ɹ���
echo ���ڣ���Ŀ�ڣ�
echo ===========================================================================
echo ��ʼ�������ͼƬ��Դ
if exist %tmpResDir%\Image rd /s /q %tmpResDir%\Image
md %tmpResDir%\Image
xcopy /e /q %resourcesDIR%\outputClient\%device%\Image %tmpResDir%\Image
echo �ɹ���


::echo =====����ɹ�����������õ���Դ����ʱĿ¼%tmpResDir%=========
::echo ����ʱ�ÿ���Res\%tmpResDir%�µ��ļ���%tmpResDir%��ʱĿ¼ ��Ϊ���������Դ��
::if exist %tmpResDir% rd /s /q %tmpResDir%
::md %tmpResDir%
::xcopy /e /q %resourcesDIR%\%tmpResDir% %tmpResDir%
::echo �ɹ���

::echo ɾ�������ļ����ļ��� 
::if exist %tmpResDir%\.svn rd /s /q %tmpResDir%\.svn
::cd %tmpResDir%
::for /f "delims=" %%i in ('dir /b /a-d /s "*.meta"') do del %%i
::cd ..
::echo �ɹ���