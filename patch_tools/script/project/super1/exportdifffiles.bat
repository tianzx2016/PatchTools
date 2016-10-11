@echo off
rem echo %1 %2 %3

::cd output

set toversion=%1
set svnurl=%2
set localpath=%3

rem echo toversion is %toversion%
rem echo svnurl is %svnurl%
rem echo localpath is %localpath%
rem echo %svnurl:/fonts/=%

set pngurl=%svnurl:.fnt=.png%
set pnglocalpath=%localpath:.fnt=.png%

set fnturl=%svnurl:.png=.fnt%
set fntlocalpath=%localpath:.png=.fnt%

if not "%svnurl:/fonts/=%"=="%svnurl%" (
	rem echo fonts folder
	rem echo %svnurl%
	if not "%svnurl:.fnt=%"=="%svnurl%" (
		if not exist %pnglocalpath% (
			echo this is font's fnt file, must export png file with the same name.
			svn export -r %toversion% %pngurl%  %pnglocalpath%
		)
	)
	if not "%svnurl:.png=%"=="%svnurl%" (
		if not exist %fntlocalpath% (
			echo this is font's png file, must export fnt file with the same name.		
			svn export -r %toversion% %fnturl%  %fntlocalpath%
		)
	)
)

::cd ..