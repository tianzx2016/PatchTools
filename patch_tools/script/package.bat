
echo ==============�������  ��ʼ================
set platformname=%1
set bv=%2
set ev=%3
:: ===��Դ�ļ�������(����Ŀ��ProjectSettings.bat����)===
set resources_name=%4

for /f "tokens=1-2 delims=:" %%a in ('svn info ./res/%resources_name%') do (
	if %%a==Last^ Changed^ Rev  (set LastVersionclient=%%b)
)
if "%LastVersionclient:~0,1%"==" " set "LastVersionclient=%LastVersionclient:~1%"

set packname=%platformname%%bv%-%ev%_svn%LastVersionclient%
cd output\pack
7z a %packname%.tar *
cd ../..
7z a output\patch\%packname%.tar.gz output\pack\%packname%.tar

del /f /q /s *.tar

::�������ϴ�FTP����
for /f "tokens=1,2 delims==" %%a in (config.ini) do (
:: ===�Ƿ��ϴ���1�ϴ�0���ϴ���===
  if "%%a"=="upload_ftp" set upload_ftp=%%b
:: ===ftp��ַ===
  if "%%a"=="ftp_path" set ftp_path=%%b
:: ===ftpip===
  if "%%a"=="ftp_ip" set ftp_ip=%%b
:: ===ftp�˿�===
  if "%%a"=="ftp_port" set ftp_port=%%b
:: ===ftp�˺�===
  if "%%a"=="ftp_account" set ftp_account=%%b
:: ===ftp����===
  if "%%a"=="ftp_password" set ftp_password=%%b
 )
echo upload_ftp��	%upload_ftp%
echo ftp_path��		%ftp_path%
echo ftp_ip��		%ftp_ip%
echo ftp_port��		%ftp_port%
echo ftp_account��	%ftp_account%
echo ftp_password��	%ftp_password%

if /i "%upload_ftp%"=="1" (
	goto upload_ftp
)else (
	goto notload_ftp
)

:upload_ftp
echo ==============�ϴ�FTP================
echo open %ftp_ip% %ftp_port% >ftp.up
echo %ftp_account%>>ftp.up
echo %ftp_password%>>ftp.up
echo cd %ftp_path% >>ftp.up
echo binary>>ftp.up
echo put "output\patch\%packname%.tar.gz">>ftp.up
echo bye>>ftp.up
FTP -s:ftp.up
del ftp.up /q
del patch\%packname%.tar.gz

:notload_ftp
echo ==============���ϴ�FTP================


echo ==============�������  ����================