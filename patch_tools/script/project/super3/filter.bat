@echo off
echo =======================
echo ��ʼ���˷ǵ�ǰ�汾�ļ�
echo =======================

set filterTxtPath=%1
set fileFolder=%2
echo filterTxtPath is %filterTxtPath%
pause
for /f "delims=" %%i in (%filterTxtPath%) do (
	call :DelUnUseFile %fileFolder%%%i
)
goto:EOF
:DelUnUseFile
set delfilepath=%1
if exist %delfilepath% (
	del %delfilepath%
	echo del file %delfilepath%
) else (
	echo not find file %delfilepath%
)