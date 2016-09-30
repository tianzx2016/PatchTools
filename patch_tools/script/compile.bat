@echo off
setlocal enabledelayedexpansion

echo ==============编译  开始================

rem ========= 配置 ================
rem 起始版本号
set startVersion=%1

rem 游戏版本号
set gameVersion=%2

rem 平台标识
set platformname=%3

rem 平台类型
set platformtype=%4

rem 资源版本号配置
set resSvnVersionBegin=%5
set resSvnVersionEnd=%6

rem 产品库 资源SVN路径
set resSvnPath=%7

rem 繁体 1 简体 0
set traditional=%8

:: ===默认线路===
set svn_line=%9

:: :: ===项目选择===
shift /0
set choose_project=%9

::  ===设备类型（android/ios）===
shift /0
set device=%9

:: ===资源文件夹名字===
shift /0
set resources_name=%9



for /f "tokens=1-5 delims=:." %%a in ("%gameVersion%") do (
set /a "bigVersion=%%a,cVersion=%%b,cVersion2=%%c,resVersion2=%%d,resVersion=%%e"
)

if exist script/project/%choose_project%/compile.bat (
	echo ====项目内编译 需项目自己添加相关批处理内容 把编译完的资源拷贝到根目录%resources_name%====
	call script/project/%choose_project%/compile.bat %gameVersion% %platformtype% %resSvnVersionBegin% %resSvnVersionEnd% %traditional% %svn_line% %device% %resources_name% %choose_project%
	echo ====项目内编译 end===
)
:: ====生成资源 拷贝fbbres库 提交svn====
call script/upload.bat %gameVersion% %resSvnPath% %resources_name%

::echo ====fbbres\%resources_name%\
svn update fbbres\%resources_name%\

::call script/comparison.bat %last_release_svn_version% %endVersion% %svnPath% %resVersion% %gameVersion% %versionfilePath%
echo ==============编译  结束================
pause