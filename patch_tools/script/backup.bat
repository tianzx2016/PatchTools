@echo off

set wgv=%1
echo ===(�汾����,��Ҫ�����ڴ���comparisonresultsʱ�����ʵ�ʱ�򱸷�һ�ݰ汾��������)===
echo ===�汾���ݵ� output\history===
if exist output\histroy\%wgv%\ rd /s /q output\histroy\%wgv%\
xcopy /q /y /s output\patch output\histroy\%wgv%\
echo �ɹ�



