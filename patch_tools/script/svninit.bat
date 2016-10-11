@echo off
setlocal enabledelayedexpansion

echo ====获取或更新svn脚本 开始====

:: ===项目选择===
set choose_project=%1

:: ===设备类型（android/ios）===
set device_type=%2

:: ===平台类型===
set platform_type=%3

:: ===默认线路===
set svn_line=%4

:: ===语言类型===
set language_type=%5

:: ===版本库Res===
set res_svn=%6

:: ===发布库FBB===
set fbb_svn=%7

:: ===资源文件夹名字===
set resources_name=%8

if not exist fbbres (md fbbres)
if not exist res (md res)

if not exist fbbres/%resources_name%/ (
	echo 信息：发布库不存在，正在根据fbb_svn自动获取，请稍候！
	svn co %fbb_svn% fbbres -q
) else (
	svn cleanup fbbres
	svn update fbbres
)

for /f "tokens=1-3 delims=: " %%a in ('svn info fbbres/%resources_name%') do (
	if %%a==URL (set fbb_svn_path=%%b:%%c)
)
echo 信息：发布库库当前地址为%fbb_svn_path%

if not exist res/%resources_name%/ (
	echo 信息：产品库不存在，正在根据res_svn自动获取，请稍候！
	svn co %res_svn% Res -q
) else (
	svn cleanup Res
	svn update Res
)

for /f "tokens=1-3 delims=: " %%a in ('svn info res/%resources_name%') do (
	if %%a==URL (set res_svn_path=%%b:%%c)
)
echo 信息：产品库当前地址为%res_svn_path%

::获取svn信息 设置版本相关数据 进行完整流程
call script/svninfo.bat %choose_project% %device_type% %platform_type% %svn_line% %language_type% %res_svn% %fbb_svn% %resources_name%


