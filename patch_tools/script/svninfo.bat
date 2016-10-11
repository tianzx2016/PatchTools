@echo off
setlocal enabledelayedexpansion

echo ====获取svn信息 设置版本相关数据 进行完整流程 开始====

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

:: ===上次版本号===
set last_version=0.0.0.0.0
:: ===本次版本号===
set version=0.0.0.0.0
:: ===上次发布库版本号(FBB)===
set last_FBB_svn_version=0
:: ===本次发布库版本号===
set FBB_svn_version=0
:: ===上次产品库版本号(Res)===
set last_Res_svn_version=0
:: ===本次产品库版本号===
set Res_svn_version=0

for /f "tokens=1-3 delims=: " %%a in ('svn info res') do (
	if %%a==URL (set res_svn_path=%%b:%%c)
	if %%a==Relative (set svn_line_real=%%c)
)
set svn_line_real=%svn_line_real:~2%
echo 信息：产品库当前地址为%res_svn_path%
echo.
echo 信息：产品库当前线路为%svn_line_real%
echo.

for /f "tokens=1-2 delims=<>= " %%a in ('svn log res -l 1 --xml') do (
	if %%a==revision (set Res_svn_version=%%b)
)
set Res_svn_version=%Res_svn_version:"=%

for /f "tokens=1-2 delims=<>= " %%a in ('svn log fbbres/%resources_name% -l 1 --xml') do (
	if %%a==msg (set last_commit_log=%%b)
	if %%a==revision (set last_commit_version=%%b)
)

if "%last_commit_log%"=="/msg" set last_commit_log=
set last_commit_version=%last_commit_version:"=%

if "%last_commit_log%"=="" (
	goto 1
) else (
	for /f "tokens=1-2 delims=_" %%a in ("%last_commit_log%") do (
		set last_version=%%a
		set last_Res_svn_version=%%b
		set last_Res_svn_version=!last_Res_svn_version:~3!
	)

	if "!last_version!"=="" goto 1
	if "!last_Res_svn_version!"=="" goto 1
	set last_FBB_svn_version=%last_commit_version%

	for /f "tokens=1-3 delims=." %%a in ("!last_version!") do (
		set version=%%a.%%b.%%c.%Res_svn_version%.%Res_svn_version%
	)

	goto 2
)

:1
echo.
echo （1、3、5位是版本号）5取的是产品库svn的revision
echo （2是否强制根本完整版相关参数4是否强制更新补丁相关参数，默认和前一位相同）
echo （2、4位默认和后一位相同）
@set /p last_version=请输入上次版本号（格式为1.x.x.x.x）：
echo.
@set /p version=请输入本次版本号（格式为1.x.x.x.x）：
echo.
@set /p last_FBB_svn_version=请输入上次发布库版本号：
echo.
@set /p FBB_svn_version=请输入本次发布库版本号（最新填0)：
echo.
@set /p last_Res_svn_version=请输入上次产品库版本号：
echo.
@set /p Res_svn_version=请输入本次产品库版本号：
echo.

:2
echo 信息：已获取以下参数
echo 信息：设备类型      %device_type%
echo 信息：平台类型      %platform_type%
echo 信息：默认产品库地址      %res_svn%/%svn_line%
echo 信息：当前产品库地址      %res_svn_path%
echo 信息：当前产品库线路      %svn_line_real%
echo 信息：语言类型      %language_type%
echo 信息：上次版本号      %last_version%
echo 信息：本次版本号      %version%
echo 信息：上次发布库版本号      %last_FBB_svn_version%
echo 信息：本次发布库版本号（最新填0)      %FBB_svn_version%
echo 信息：上次产品库版本号      %last_Res_svn_version%
echo 信息：本次产品库版本号      %Res_svn_version%
echo 额外参数
for /f "tokens=1,2 delims==" %%a in (script\project\%choose_project%\configadd.ini) do (
	echo 信息：%%a:%%b   
)

set a=
@set /p a=是否用这些参数直接发布？（Y/N）
if /i "%a%"=="Y" (
	goto 4
) else (
	goto 1
)

:4
rem=========== 基础设置 ===============

rem fbbres_svn 版本号
set beginRSvnVersion=%last_FBB_svn_version%
set endRRSvnVersion=%FBB_svn_version%

rem res_svn 版本号
set resSvnVersionBegin=%last_Res_svn_version%
set resSvnVersionEnd=%Res_svn_version%

rem 是否打全图
::set packpic=%pack_pic%

rem Patch 版本号
set startVersion=%last_version%
set gameVersion=%version%


rem 设备平台（ios/android）
set device=%device_type%

rem 平台类型（查看Res\src\translate\translate.xls）
set platformtype=%platform_type%

rem 语言设置
set tradition=%language_type%

rem 补丁命名
set platformname=%choose_project%_%device%_%platformtype%_%svn_line%_%tradition%_

rem 资源SVN地址（默认即可）
for /f "tokens=1-3 delims=: " %%a in ('svn info Res/%resources_name%') do (
	if %%a==URL (set resSvnPath=%%b:%%c)
)
echo 产品库地址为：%resSvnPath%

rem 发布SVN地址
for /f "tokens=1-3 delims=: " %%a in ('svn info fbbres/%resources_name%') do (
	if %%a==URL (set svnPath=%%b:%%c)
)
echo 发布库地址为：%svnPath%

rem ftp地址
set ftp_path=%ftp_path%

:: ==============编译================
call script/compile.bat %startVersion% %gameVersion% %platformname% %platformtype% %resSvnVersionBegin% %resSvnVersionEnd% %resSvnPath% %tradition% %svn_line_real% %choose_project% %device% %resources_name%

:: ==============比对================
for /f "tokens=1-5 delims=:." %%a in ("%gameVersion%") do (
	set /a "bigVersion=%%a,cVersion=%%b,cVersion2=%%c,resVersion2=%%d,resVersion=%%e"
)
echo beginRSvnVersion:%beginRSvnVersion% 
echo endRRSvnVersion:%endRRSvnVersion% 
echo svnPath:%svnPath% 
echo resVersion:%resVersion% 
echo gameVersion:%gameVersion% 
call script/comparison.bat %beginRSvnVersion% %endRRSvnVersion% %svnPath% %resVersion% %gameVersion% %choose_project%


:: ==============根据项目内部处理比对结果 用于删除不可更新文件================
if exist script/project/%choose_project%/comparisonresults.bat (
	call script/project/%choose_project%/comparisonresults.bat %beginRSvnVersion% %endRRSvnVersion% %svnPath% %resVersion% %gameVersion% %resources_name% %choose_project%
)

:: ==============打包================
call script/package.bat %platformname% %startVersion% %gameVersion% %resources_name%

echo ====本次流程 结束====



