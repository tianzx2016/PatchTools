@echo ==== ��ʼ������ļ���... ====
dir %1 /ad /b /s |sort /r >>empty.txt
for /f %%i in (empty.txt) do rd /q %%i
del empty.txt
echo ==== ������� ====