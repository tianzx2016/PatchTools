@echo off
setlocal enabledelayedexpansion

echo ====��ȡ�����svn�ű� ��ʼ====

:: ===��Ŀѡ��===
set choose_project=%1

:: ===�豸���ͣ�android/ios��===
set device_type=%2

:: ===ƽ̨����===
set platform_type=%3

:: ===Ĭ����·===
set svn_line=%4

:: ===��������===
set language_type=%5

:: ===�汾��Res===
set res_svn=%6

:: ===������FBB===
set fbb_svn=%7

:: ===��Դ�ļ�������===
set resources_name=%8

if not exist fbbres (md fbbres)
if not exist res (md res)

if not exist fbbres/%resources_name%/ (
	echo ��Ϣ�������ⲻ���ڣ����ڸ���fbb_svn�Զ���ȡ�����Ժ�
	svn co %fbb_svn% fbbres -q
) else (
	svn cleanup fbbres
	svn update fbbres
)

for /f "tokens=1-3 delims=: " %%a in ('svn info fbbres/%resources_name%') do (
	if %%a==URL (set fbb_svn_path=%%b:%%c)
)
echo ��Ϣ��������⵱ǰ��ַΪ%fbb_svn_path%

if not exist res/%resources_name%/ (
	echo ��Ϣ����Ʒ�ⲻ���ڣ����ڸ���res_svn�Զ���ȡ�����Ժ�
	svn co %res_svn% Res -q
) else (
	svn cleanup Res
	svn update Res
)

for /f "tokens=1-3 delims=: " %%a in ('svn info res/%resources_name%') do (
	if %%a==URL (set res_svn_path=%%b:%%c)
)
echo ��Ϣ����Ʒ�⵱ǰ��ַΪ%res_svn_path%

::��ȡsvn��Ϣ ���ð汾������� ������������
call script/svninfo.bat %choose_project% %device_type% %platform_type% %svn_line% %language_type% %res_svn% %fbb_svn% %resources_name%


