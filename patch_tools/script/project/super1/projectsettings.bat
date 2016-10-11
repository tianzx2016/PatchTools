@echo off
setlocal enabledelayedexpansion

echo ====项目新加参数设置脚本 开始====

:: ===版本文件路径(各项目内SvnInfo.bat传出)===
set versionlistpath=fbbres\vfiles

set choose_project=%1
:: ===打图设置(项目内传出)===
echo 1.区间资源（打图）
echo 2.区间资源（不打图）
echo 3.完整资源（打图）
echo 4.完整资源（不打图）
set a=
@set /p a=打图设置选择（1~4）：

set pack_pic=%a%

::初始化 额外参数配置表加入
echo #版本文件路径>script\project\%choose_project%\configadd.ini
echo versionlistpath=%versionlistpath%>>script\project\%choose_project%\configadd.ini
echo.>>script\project\%choose_project%\configadd.ini
echo #打图设置(1.区间资源（打图）2.区间资源（不打图）3.完整资源（打图）4.完整资源（不打图））>>script\project\%choose_project%\configadd.ini
echo pack_pic=%pack_pic% >>script\project\%choose_project%\configadd.ini

echo 新增项目配置(script\project\%choose_project%\configadd.ini)：
echo =====================================================================
echo #版本文件路径
echo versionlistpath=%versionlistpath%
echo #打图设置(1.区间资源（打图）2.区间资源（不打图）3.完整资源（打图）4.完整资源（不打图）)
echo pack_pic=%pack_pic%
echo =====================================================================

echo ====项目新加参数设置脚本 结束====

