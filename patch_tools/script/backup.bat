@echo off

set wgv=%1
echo ===(版本备份,需要在你在处理comparisonresults时，合适的时候备份一份版本补丁内容)===
echo ===版本备份到 output\history===
if exist output\histroy\%wgv%\ rd /s /q output\histroy\%wgv%\
xcopy /q /y /s output\patch output\histroy\%wgv%\
echo 成功



