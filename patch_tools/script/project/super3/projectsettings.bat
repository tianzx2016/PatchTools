@echo off
setlocal enabledelayedexpansion

echo ====��Ŀ�¼Ӳ������ýű� ��ʼ====

:: ===�汾�ļ�·��(����Ŀ��SvnInfo.bat����)===
set versionlistpath=fbbres\vfiles

set choose_project=%1
:: ===��ͼ����(��Ŀ�ڴ���)===
set a=
@set /p a=�Ƿ��ͼ����Y/N��
if /i "%a%"=="Y" (
	echo ��ѡ������Ҫ��ͼ��
	set pack_pic=1
) else (
	echo ��ѡ���˲���Ҫ��ͼ��
	set pack_pic=0
)

::��ʼ�� ����������ñ����
echo #�汾�ļ�·��>script\project\%choose_project%\configadd.ini
echo versionlistpath=%versionlistpath%>>script\project\%choose_project%\configadd.ini
echo.>>script\project\%choose_project%\configadd.ini
echo #��ͼ���ã�1��ͼ0����ͼ��>>script\project\%choose_project%\configadd.ini
echo pack_pic=%pack_pic% >>script\project\%choose_project%\configadd.ini

echo ������Ŀ����(script\project\%choose_project%\configadd.ini)��
echo =====================================================================
echo #�汾�ļ�·��
echo versionlistpath=%versionlistpath%
echo #��ͼ����(1��ͼ0����ͼ)
echo pack_pic=%pack_pic%
echo =====================================================================

echo ====��Ŀ�¼Ӳ������ýű� ����====

