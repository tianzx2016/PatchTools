@echo off
setlocal enabledelayedexpansion

echo ====��ȡsvn��Ϣ ���ð汾������� ������������ ��ʼ====

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

:: ===�ϴΰ汾��===
set last_version=0.0.0.0.0
:: ===���ΰ汾��===
set version=0.0.0.0.0
:: ===�ϴη�����汾��(FBB)===
set last_FBB_svn_version=0
:: ===���η�����汾��===
set FBB_svn_version=0
:: ===�ϴβ�Ʒ��汾��(Res)===
set last_Res_svn_version=0
:: ===���β�Ʒ��汾��===
set Res_svn_version=0

for /f "tokens=1-3 delims=: " %%a in ('svn info res') do (
	if %%a==URL (set res_svn_path=%%b:%%c)
	if %%a==Relative (set svn_line_real=%%c)
)
set svn_line_real=%svn_line_real:~2%
echo ��Ϣ����Ʒ�⵱ǰ��ַΪ%res_svn_path%
echo.
echo ��Ϣ����Ʒ�⵱ǰ��·Ϊ%svn_line_real%
echo.

for /f "tokens=1-2 delims=<>= " %%a in ('svn log res -l 1 --xml') do (
	if %%a==revision (set Res_svn_version=%%b)
)
set Res_svn_version=%Res_svn_version:"=%

for /f "tokens=1-2 delims=<>= " %%a in ('svn log fbbres/%resources_name% -l 1 --xml') do (
	if %%a==msg (set last_commit_log=%%b)
	if %%a==revision (set last_commit_version=%%b)
)

if "%last_commit_log%"=="/msg" set last_commit_log=
set last_commit_version=%last_commit_version:"=%

if "%last_commit_log%"=="" (
	goto 1
) else (
	for /f "tokens=1-2 delims=_" %%a in ("%last_commit_log%") do (
		set last_version=%%a
		set last_Res_svn_version=%%b
		set last_Res_svn_version=!last_Res_svn_version:~3!
	)

	if "!last_version!"=="" goto 1
	if "!last_Res_svn_version!"=="" goto 1
	set last_FBB_svn_version=%last_commit_version%

	for /f "tokens=1-3 delims=." %%a in ("!last_version!") do (
		set version=%%a.%%b.%%c.%Res_svn_version%.%Res_svn_version%
	)

	goto 2
)

:1
echo.
echo ��1��3��5λ�ǰ汾�ţ�5ȡ���ǲ�Ʒ��svn��revision
echo ��2�Ƿ�ǿ�Ƹ�����������ز���4�Ƿ�ǿ�Ƹ��²�����ز�����Ĭ�Ϻ�ǰһλ��ͬ��
echo ��2��4λĬ�Ϻͺ�һλ��ͬ��
@set /p last_version=�������ϴΰ汾�ţ���ʽΪ1.x.x.x.x����
echo.
@set /p version=�����뱾�ΰ汾�ţ���ʽΪ1.x.x.x.x����
echo.
@set /p last_FBB_svn_version=�������ϴη�����汾�ţ�
echo.
@set /p FBB_svn_version=�����뱾�η�����汾�ţ�������0)��
echo.
@set /p last_Res_svn_version=�������ϴβ�Ʒ��汾�ţ�
echo.
@set /p Res_svn_version=�����뱾�β�Ʒ��汾�ţ�
echo.

:2
echo ��Ϣ���ѻ�ȡ���²���
echo ��Ϣ���豸����      %device_type%
echo ��Ϣ��ƽ̨����      %platform_type%
echo ��Ϣ��Ĭ�ϲ�Ʒ���ַ      %res_svn%/%svn_line%
echo ��Ϣ����ǰ��Ʒ���ַ      %res_svn_path%
echo ��Ϣ����ǰ��Ʒ����·      %svn_line_real%
echo ��Ϣ����������      %language_type%
echo ��Ϣ���ϴΰ汾��      %last_version%
echo ��Ϣ�����ΰ汾��      %version%
echo ��Ϣ���ϴη�����汾��      %last_FBB_svn_version%
echo ��Ϣ�����η�����汾�ţ�������0)      %FBB_svn_version%
echo ��Ϣ���ϴβ�Ʒ��汾��      %last_Res_svn_version%
echo ��Ϣ�����β�Ʒ��汾��      %Res_svn_version%
echo �������
for /f "tokens=1,2 delims==" %%a in (script\project\%choose_project%\configadd.ini) do (
	echo ��Ϣ��%%a:%%b   
)

set a=
@set /p a=�Ƿ�����Щ����ֱ�ӷ�������Y/N��
if /i "%a%"=="Y" (
	goto 4
) else (
	goto 1
)

:4
rem=========== �������� ===============

rem fbbres_svn �汾��
set beginRSvnVersion=%last_FBB_svn_version%
set endRRSvnVersion=%FBB_svn_version%

rem res_svn �汾��
set resSvnVersionBegin=%last_Res_svn_version%
set resSvnVersionEnd=%Res_svn_version%

rem �Ƿ��ȫͼ
::set packpic=%pack_pic%

rem Patch �汾��
set startVersion=%last_version%
set gameVersion=%version%


rem �豸ƽ̨��ios/android��
set device=%device_type%

rem ƽ̨���ͣ��鿴Res\src\translate\translate.xls��
set platformtype=%platform_type%

rem ��������
set tradition=%language_type%

rem ��������
set platformname=%choose_project%_%device%_%platformtype%_%svn_line%_%tradition%_

rem ��ԴSVN��ַ��Ĭ�ϼ��ɣ�
for /f "tokens=1-3 delims=: " %%a in ('svn info Res/%resources_name%') do (
	if %%a==URL (set resSvnPath=%%b:%%c)
)
echo ��Ʒ���ַΪ��%resSvnPath%

rem ����SVN��ַ
for /f "tokens=1-3 delims=: " %%a in ('svn info fbbres/%resources_name%') do (
	if %%a==URL (set svnPath=%%b:%%c)
)
echo �������ַΪ��%svnPath%

rem ftp��ַ
set ftp_path=%ftp_path%

:: ==============����================
call script/compile.bat %startVersion% %gameVersion% %platformname% %platformtype% %resSvnVersionBegin% %resSvnVersionEnd% %resSvnPath% %tradition% %svn_line_real% %choose_project% %device% %resources_name%

:: ==============�ȶ�================
for /f "tokens=1-5 delims=:." %%a in ("%gameVersion%") do (
	set /a "bigVersion=%%a,cVersion=%%b,cVersion2=%%c,resVersion2=%%d,resVersion=%%e"
)
echo beginRSvnVersion:%beginRSvnVersion% 
echo endRRSvnVersion:%endRRSvnVersion% 
echo svnPath:%svnPath% 
echo resVersion:%resVersion% 
echo gameVersion:%gameVersion% 
call script/comparison.bat %beginRSvnVersion% %endRRSvnVersion% %svnPath% %resVersion% %gameVersion% %choose_project%


:: ==============������Ŀ�ڲ�����ȶԽ�� ����ɾ�����ɸ����ļ�================
if exist script/project/%choose_project%/comparisonresults.bat (
	call script/project/%choose_project%/comparisonresults.bat %beginRSvnVersion% %endRRSvnVersion% %svnPath% %resVersion% %gameVersion% %resources_name% %choose_project%
)

:: ==============���================
call script/package.bat %platformname% %startVersion% %gameVersion% %resources_name%

echo ====�������� ����====



