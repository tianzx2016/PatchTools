@echo off
setlocal enabledelayedexpansion

echo ==============项目内部特殊处理比对结果  开始================

set bv=%1
set ev=%2
set sp=%3
set gv=%4
set wgv=%5
set resources_name=%6
set choose_project=%7
::projectsettings.bat中设置
for /f "tokens=1,2 delims==" %%a in (script\project\%choose_project%\configadd.ini) do (
  if "%%a"=="versionlistpath" set vp=%%b
 )


echo 删除版本文件，此文件绝对不能更新
if exist output\patch\publicscript\versiondefine.lua del output\patch\publicscript\versiondefine.lua
if exist output\patch\publicscript\serverinfo.lua del output\patch\publicscript\serverinfo.lua

rem if exist res\src\pic\versionfilter.txt (
rem 	call script/filter.bat res\src\pic\versionfilter.txt output\patch\
rem )
if exist fullfilter.txt (
	call script/project/%choose_project%/filter.bat fullfilter.txt output\patch\
)

echo 检查不可更新plist
call script/project/%choose_project%/checkpilstpng.bat

echo 生成更新文件列表   vp=%vp% gv=%gv%
if exist %vp%\versionlist.xml del %vp%\versionlist.xml
svn update %vp%
::echo 拷贝到output\patch\webconfig\
xcopy /q /y /s %vp%\versionlist.xml output\patch\webconfig\
::echo %CD%\output\patch  %gv%
script\tools\versionExporter.exe %CD%\output\patch %gv%

xcopy /q /y /s output\patch\webconfig\versionlist.xml %vp%
echo 上传versionlist.xml文件
svn commit -m %wgv% %vp%\
echo 成功

::echo 版本备份,需要在你在处理ComparisonResults时，合适的时候备份一份版本补丁内容
::if exist histroy\%wgv%\ rd /s /q histroy\%wgv%\
::xcopy /q /y /s output\patch histroy\%wgv%\
::echo 成功
call script/backup.bat %wgv%

echo 生成补丁包
if exist output\pack rd /s /q output\pack
cd output
md pack
cd ..

xcopy /q /y /s output\patch output\pack\%resources_name%\
xcopy /q /y /s output\patch\webconfig\versionlist.xml output\pack\
if exist output\vlencode rd /s /q output\vlencode
xcopy /q /y /s output\patch\webconfig\versionlist.lua output\vlencode\
script\tools\encodelua.exe %CD%\output\vlencode
xcopy /q /y /s output\vlencode\encode output\pack\
rd /s /q output\vlencode
echo ^<update^>	>>output\pack\version.txt
echo	^<curversion^>%wgv%^<^/curversion^>	>>output\pack\version.txt
echo	^<lastapkpath^>discard^<^/lastapkpath^>	>>output\pack\version.txt
echo	^<httpapkurl^>discard^<^/httpapkurl^>	>>output\pack\version.txt
echo ^<^/update^>	>>output\pack\version.txt

echo ^<update^>	>>output\pack\version.xml
echo	^<curversion^>%wgv%^<^/curversion^>	>>output\pack\version.xml
echo	^<lastapkpath^>discard^<^/lastapkpath^>	>>output\pack\version.xml
echo	^<httpapkurl^>discard^<^/httpapkurl^>	>>output\pack\version.xml
echo ^<^/update^>	>>output\pack\version.xml

for /f "tokens=1-5 delims=:." %%a in ("%wgv%") do (
set /a "bigVersion=%%a,cVersion=%%b,cVersion2=%%c,resVersion2=%%d,resVersion=%%e"
)

echo G_NEW_VERSION^=^{%bigVersion%^,%cVersion%^,%cVersion2%^,%resVersion2%^,%resVersion%^}^;	>>output\pack\version.lua
echo 清理目录
::if exist file_list.txt del file_list.txt
if exist encodeLog.log del encodeLog.log
if exist output\patch rd /s /q output\patch

echo ==============项目内部特殊处理比对结果  结束================