@echo off
echo ==============对比  开始================
set bv=%1
set ev=%2
set sp=%3
set gv=%4
set wgv=%5
set choose_project=%6
for /f "tokens=1-2 delims=: " %%a in ('svn info %sp%') do (
	if %%a==Revision  (set LastResVersion=%%b)
)
echo ========ev:%ev%
echo ========LastResVersion:%LastResVersion%

if %ev%==0 (
set ev=%LastResVersion%
)
echo 导出SVN版本 %sp%:%bv% - %ev% 

cd output
if exist patch rd /s /q patch
md patch
cd ..

::根据svn版本区间 导出差异的文件=====
call script/exportdifffiles.bat %bv% %ev% %sp% output\patch %choose_project%

echo 成功!

echo 判断是否有文件
cd output/patch
for /f %%i in ('dir /s *.*^|find /i "个文件"') do set num=%%i 
if %num% == 0 (
 echo 没有文件更新
 pause
 cd ..
 if exist patch rd /s /q patch
 cd ..
 exit
) else (
 echo 更新%num%个文件
)
cd ../..
echo ==============对比  结束================

