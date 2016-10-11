@echo off
setlocal enabledelayedexpansion

set resourcesDIR=res

:: 游戏版本号
set gameVersion=%1
:: 平台类型
set platformtype=%2
:: 资源版本号配置
set resSvnVersionBegin=%3
set resSvnVersionEnd=%4
:: 产品库 资源SVN路径
::set resSvnPath=%5
:: 繁体 1 简体 0
set traditional=%5
:: ===默认线路===
set svn_line=%6
::  ===设备类型（android/ios）===
set device=%7
:: ===资源文件夹名字===
set tmpResDir=%8
::工程名
set choose_project=%9
:: 是否打包资源(projectsetting.bat中设置)
for /f "tokens=1,2 delims==" %%a in (script\project\%choose_project%\configadd.ini) do (
  if "%%a"=="pack_pic" set packpic=%%b
 )

echo gameVersion:%gameVersion%
echo packpic:%packpic%
echo platformtype:%platformtype%
echo resSvnVersionBegin:%resSvnVersionBegin%
echo resSvnVersionEnd:%resSvnVersionEnd%
::echo resSvnPath:%resSvnPath%
echo traditional:%traditional%
echo svn_line:%svn_line%
echo device:%device%
echo tmpResDir:%tmpResDir%

echo ===开始更新产品库res_svn===
svn update %resourcesDIR%\%tmpResDir%
echo 成功！


echo ===========================================================================
echo 图片文件打包... 
CD res\src
::if %resSvnVersionBegin% GTR 0 (
	if %packpic%==2 (
		echo =========================1.区间资源（不打图）========================
		call setup-client.bat %svn_line% %platformtype% nopic %traditional% %device% %resSvnVersionBegin% %resSvnVersionEnd%
	)
	if %packpic%==1 (
		echo =========================2.区间资源（打图）========================
		call setup-client.bat %svn_line% %platformtype% %device% %traditional% %device% %resSvnVersionBegin% %resSvnVersionEnd%
	)
::)
::if %resSvnVersionBegin%==0 (
	if %packpic%==4 (
		echo =========================3.完整资源（不打图）========================
		call setup-client.bat %svn_line% %platformtype% nopic %traditional% %device%
	)
	if %packpic%==3 (
		echo =========================4.完整资源（打图）========================
		call setup-client.bat %svn_line% %platformtype% %device% %traditional% %device%
	)
::)
PUSHD %~dp0
cd ..\..\..

echo 成功！
echo %CD%============
echo ===========================================================================
echo 拷贝Lua文件到临时目录... %tmpResDir%
if exist %tmpResDir% rd /s /q %tmpResDir%
md %tmpResDir%
xcopy /e /q %resourcesDIR%\%tmpResDir% %tmpResDir%

if exist %tmpResDir%\db rd /s /q %tmpResDir%\db
md %tmpResDir%\db
for /f "tokens=*" %%i in ('dir /b %resourcesDIR%\outputClient\*.lua') do (
xcopy /s /q "%resourcesDIR%\outputClient\%%i" "%tmpResDir%\db"
)
echo 成功！
echo 存在（项目内）
echo ===========================================================================
echo 删除无用文件和文件夹 
if exist %tmpResDir%\*.exe del %tmpResDir%\*.exe
if exist %tmpResDir%\.svn rd /s /q %tmpResDir%\.svn
if exist %tmpResDir%\interface rd /s /q %tmpResDir%\interface
if exist %tmpResDir%\*.dll del %tmpResDir%\*.dll
if exist %tmpResDir%\*.lib del %tmpResDir%\*.lib
if exist %tmpResDir%\*.pdb del %tmpResDir%\*.pdb
if exist %tmpResDir%\*.ini del %tmpResDir%\*.ini
if exist %tmpResDir%\Icon.png del %tmpResDir%\Icon.png
if exist %tmpResDir%\db\Image rd /s /q %tmpResDir%\db\Image
echo 成功！
echo 存在（项目内）
echo ===========================================================================
echo 开始加密LUA... 
::echo ===%CD%\%tmpResDir%
script\tools\encodelua.exe %CD%\%tmpResDir%
xcopy /e /y /q %tmpResDir%\encode %tmpResDir%
rd /s /q %tmpResDir%\encode
if exist %tmpResDir%\codecover rd /s /q %tmpResDir%\codecover
echo 成功！
echo 存在（项目内）
echo ===========================================================================
echo 开始拷贝打包图片资源
if exist %tmpResDir%\Image rd /s /q %tmpResDir%\Image
md %tmpResDir%\Image
xcopy /e /q %resourcesDIR%\outputClient\%device%\Image %tmpResDir%\Image
echo 成功！


::echo =====编译成功，拷贝编译好的资源到临时目录%tmpResDir%=========
::echo （暂时用拷贝Res\%tmpResDir%下的文件到%tmpResDir%临时目录 做为编译完的资源）
::if exist %tmpResDir% rd /s /q %tmpResDir%
::md %tmpResDir%
::xcopy /e /q %resourcesDIR%\%tmpResDir% %tmpResDir%
::echo 成功！

::echo 删除无用文件和文件夹 
::if exist %tmpResDir%\.svn rd /s /q %tmpResDir%\.svn
::cd %tmpResDir%
::for /f "delims=" %%i in ('dir /b /a-d /s "*.meta"') do del %%i
::cd ..
::echo 成功！