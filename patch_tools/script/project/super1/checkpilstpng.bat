@echo off
echo ��ʼ���plist�ļ�...
for /f "delims=" %%i   in ('dir  /b/a-d/s  output\patch\*.plist')  do (
 call :delplists %%i
)
echo �ɹ���
goto :EOF
:delplists
set filepathbase=%1 
echo %filepathbase%
set plistname=%filepathbase%
set cczname=%filepathbase:.plist=.pvr.ccz%
set pngname=%filepathbase:.plist=.png%

if "%filepathbase:\json\=%"=="%filepathbase%" (
	if exist %cczname% (
	 echo 1
	) else (
	 echo 2
	 if exist %pngname% (echo %pngname%) else (del %filepathbase%)
	)
) else (
 echo 2
)