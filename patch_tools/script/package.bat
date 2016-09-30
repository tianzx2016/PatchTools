
echo ==============补丁打包  开始================
set platformname=%1
set bv=%2
set ev=%3
:: ===资源文件夹名字(各项目内ProjectSettings.bat传出)===
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

::下面是上传FTP代码
for /f "tokens=1,2 delims==" %%a in (config.ini) do (
:: ===是否上传（1上传0不上传）===
  if "%%a"=="upload_ftp" set upload_ftp=%%b
:: ===ftp地址===
  if "%%a"=="ftp_path" set ftp_path=%%b
:: ===ftpip===
  if "%%a"=="ftp_ip" set ftp_ip=%%b
:: ===ftp端口===
  if "%%a"=="ftp_port" set ftp_port=%%b
:: ===ftp账号===
  if "%%a"=="ftp_account" set ftp_account=%%b
:: ===ftp密码===
  if "%%a"=="ftp_password" set ftp_password=%%b
 )
echo upload_ftp：	%upload_ftp%
echo ftp_path：		%ftp_path%
echo ftp_ip：		%ftp_ip%
echo ftp_port：		%ftp_port%
echo ftp_account：	%ftp_account%
echo ftp_password：	%ftp_password%

if /i "%upload_ftp%"=="1" (
	goto upload_ftp
)else (
	goto notload_ftp
)

:upload_ftp
echo ==============上传FTP================
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
echo ==============不上传FTP================


echo ==============补丁打包  结束================