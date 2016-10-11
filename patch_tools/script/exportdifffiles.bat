@echo off
setlocal enabledelayedexpansion
echo =====根据svn版本区间 导出差异的文件  开始=====
set from_version=%1
set to_version=%2
set url=%3
set tempdir=%4
set choose_project=%5

if %to_version%==0 (
svn diff --summarize -r %from_version% %url% > file_list.txt
)
if  %to_version% GTR 0 (
svn diff --summarize -r %from_version%:%to_version% %url% > file_list.txt
)


for /f "delims=" %%i in (file_list.txt) do (
	call :export %%i
)
echo =====根据svn版本区间 导出差异的文件  结束=====

goto :EOF
:export
set fullpath=%2
set filename=%~nx2
set "filepath=!fullpath:%filename%=!"
set "filepath=!filepath:%url%=!"
set "filepath=%filepath:/=\%"
echo to_version = %to_version% 
echo to_version2 = %tempdir%%filepath%
echo to_version3 = %tempdir%%filepath%%filename%
if not exist %tempdir%%filepath% mkdir %tempdir%%filepath%
set ok=%tempdir%%filepath%%filename%
::echo to_version4 = %fullpath%
svn export -r %to_version% %fullpath% %tempdir%%filepath%%filename%
::echo %CD%
if exist script/project/%choose_project%/ExportDiffFiles.bat (
	:: ====依次检测项目内是否有什么特殊需要导出的文件（例如：super3中的字体和图片必须一起导出）=====
	call script/project/%choose_project%/exportdiffFiles.bat %to_version% %fullpath% %tempdir%%filepath%%filename% 
)



