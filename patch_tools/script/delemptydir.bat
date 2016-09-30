@echo ==== 开始清理空文件夹... ====
dir %1 /ad /b /s |sort /r >>empty.txt
for /f %%i in (empty.txt) do rd /q %%i
del empty.txt
echo ==== 清理完成 ====