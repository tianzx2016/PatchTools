@echo off
echo ==============�Ա�  ��ʼ================
set bv=%1
set ev=%2
set sp=%3
set gv=%4
set wgv=%5
set choose_project=%6
for /f "tokens=1-2 delims=: " %%a in ('svn info %sp%') do (
	if %%a==Revision  (set LastResVersion=%%b)
)
echo ========ev:%ev%
echo ========LastResVersion:%LastResVersion%

if %ev%==0 (
set ev=%LastResVersion%
)
echo ����SVN�汾 %sp%:%bv% - %ev% 

cd output
if exist patch rd /s /q patch
md patch
cd ..

::����svn�汾���� ����������ļ�=====
call script/exportdifffiles.bat %bv% %ev% %sp% output\patch %choose_project%

echo �ɹ�!

echo �ж��Ƿ����ļ�
cd output/patch
for /f %%i in ('dir /s *.*^|find /i "���ļ�"') do set num=%%i 
if %num% == 0 (
 echo û���ļ�����
 pause
 cd ..
 if exist patch rd /s /q patch
 cd ..
 exit
) else (
 echo ����%num%���ļ�
)
cd ../..
echo ==============�Ա�  ����================

