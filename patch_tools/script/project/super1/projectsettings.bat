@echo off
setlocal enabledelayedexpansion

echo ====��Ŀ�¼Ӳ������ýű� ��ʼ====

:: ===�汾�ļ�·��(����Ŀ��SvnInfo.bat����)===
set versionlistpath=fbbres\vfiles

set choose_project=%1
:: ===��ͼ����(��Ŀ�ڴ���)===
echo 1.������Դ����ͼ��
echo 2.������Դ������ͼ��
echo 3.������Դ����ͼ��
echo 4.������Դ������ͼ��
set a=
@set /p a=��ͼ����ѡ��1~4����

set pack_pic=%a%

::��ʼ�� ����������ñ����
echo #�汾�ļ�·��>script\project\%choose_project%\configadd.ini
echo versionlistpath=%versionlistpath%>>script\project\%choose_project%\configadd.ini
echo.>>script\project\%choose_project%\configadd.ini
echo #��ͼ����(1.������Դ����ͼ��2.������Դ������ͼ��3.������Դ����ͼ��4.������Դ������ͼ����>>script\project\%choose_project%\configadd.ini
echo pack_pic=%pack_pic% >>script\project\%choose_project%\configadd.ini

echo ������Ŀ����(script\project\%choose_project%\configadd.ini)��
echo =====================================================================
echo #�汾�ļ�·��
echo versionlistpath=%versionlistpath%
echo #��ͼ����(1.������Դ����ͼ��2.������Դ������ͼ��3.������Դ����ͼ��4.������Դ������ͼ��)
echo pack_pic=%pack_pic%
echo =====================================================================

echo ====��Ŀ�¼Ӳ������ýű� ����====

