@echo off

echo ====生成资源 拷贝fbbres库 提交svn====

set resourcesDIR=Res
set tmpResDir=%3

echo 拷贝更新文件到总资源库all_res_svn目录 
xcopy /e /y /q %tmpResDir% fbbres\%tmpResDir%\
echo 成功！

echo 正在上传all_res_svn总资源库
svn add fbbres\%tmpResDir%\* --force

for /f "tokens=1-2 delims=: " %%a in ('svn info %2') do (
	if %%a==Revision  (set LastResVersion=%%b)
)
svn commit -m %1_svn%LastResVersion% fbbres\%tmpResDir%\

echo ====生成资源 拷贝fbbres库 提交svn 成功====



