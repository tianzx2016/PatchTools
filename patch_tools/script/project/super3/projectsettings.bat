@echo off
setlocal enabledelayedexpansion

echo ====项目新加参数设置脚本 开始====

:: ===版本文件路径(各项目内SvnInfo.bat传出)===
set versionlistpath=fbbres\vfiles

set choose_project=%1
:: ===打图设置(项目内传出)===
set a=
@set /p a=是否打图？（Y/N）
if /i "%a%"=="Y" (
	echo 您选择了需要打图！
	set pack_pic=1
) else (
	echo 您选择了不需要打图！
	set pack_pic=0
)

::初始化 额外参数配置表加入
echo #版本文件路径>script\project\%choose_project%\configadd.ini
echo versionlistpath=%versionlistpath%>>script\project\%choose_project%\configadd.ini
echo.>>script\project\%choose_project%\configadd.ini
echo #打图设置（1打图0不打图）>>script\project\%choose_project%\configadd.ini
echo pack_pic=%pack_pic% >>script\project\%choose_project%\configadd.ini

echo 新增项目配置(script\project\%choose_project%\configadd.ini)：
echo =====================================================================
echo #版本文件路径
echo versionlistpath=%versionlistpath%
echo #打图设置(1打图0不打图)
echo pack_pic=%pack_pic%
echo =====================================================================

echo ====项目新加参数设置脚本 结束====

