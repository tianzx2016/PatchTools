@echo off

echo ====������Դ ����fbbres�� �ύsvn====

set resourcesDIR=Res
set tmpResDir=%3

echo ���������ļ�������Դ��all_res_svnĿ¼ 
xcopy /e /y /q %tmpResDir% fbbres\%tmpResDir%\
echo �ɹ���

echo �����ϴ�all_res_svn����Դ��
svn add fbbres\%tmpResDir%\* --force

for /f "tokens=1-2 delims=: " %%a in ('svn info %2') do (
	if %%a==Revision  (set LastResVersion=%%b)
)
svn commit -m %1_svn%LastResVersion% fbbres\%tmpResDir%\

echo ====������Դ ����fbbres�� �ύsvn �ɹ�====



