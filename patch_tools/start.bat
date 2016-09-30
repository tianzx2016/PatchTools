@echo off
setlocal enabledelayedexpansion

for /f "tokens=1,2 delims==" %%a in (config.ini) do (
:: ===项目选择===
  if "%%a"=="choose_project" set choose_project=%%b
:: ===设备类型（android/ios）===
  if "%%a"=="device_type" set device_type=%%b
:: ===平台类型===
  if "%%a"=="platform_type" set platform_type=%%b
:: ===默认线路===
  if "%%a"=="svn_line" set svn_line=%%b
:: ===语言类型===
  if "%%a"=="language_type" set language_type=%%b
::===版本库Res的svn地址===
  if "%%a"=="res_svn" set res_svn=%%b
::===发布库FBB的svn地址===
  if "%%a"=="fbb_svn" set fbb_svn=%%b
::===资源文件夹名字(cocos2dx默认Resources，U3D的默认StreamingAssets)===
  if "%%a"=="resources_name" set resources_name=%%b
 )
echo 核对参数信息：
echo 项目选择（choose_project）:         %choose_project%
echo 设备类型（device_type）:            %device_type%
echo 平台类型（platform_type）:          %platform_type%
echo 默认线路（svn_line）:               %svn_line%
echo 语言类型（language_type）:          %language_type%
echo 版本库Res（res_svn）:               %res_svn%
echo 发布库FBB（fbb_svn）:               %fbb_svn%
echo 资源文件夹名字（resources_name）:   %resources_name%

::进入各项目获取项目特殊参数设置 保存到configadd.txt
if exist script/project/%choose_project%/projectsettings.bat (
	call script/project/%choose_project%/projectsettings.bat %choose_project%
)

::获取或更新svn脚本
call script/svninit.bat %choose_project% %device_type% %platform_type% %svn_line% %language_type% %res_svn% %fbb_svn% %resources_name%

pause