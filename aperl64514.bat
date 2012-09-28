@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  aperl64514 - execute perlscript on ActivePerl x64 5.14 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%APERL64514BIN%" == "" goto SetWin95
  %APERL64514BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET APERL64514BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET APERL64514BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable APERL64514BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl64514\bin\perl.exe echo SET APERL64514BIN=Z:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist Y:\Perl64514\bin\perl.exe echo SET APERL64514BIN=Y:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist X:\Perl64514\bin\perl.exe echo SET APERL64514BIN=X:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist W:\Perl64514\bin\perl.exe echo SET APERL64514BIN=W:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist V:\Perl64514\bin\perl.exe echo SET APERL64514BIN=V:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist U:\Perl64514\bin\perl.exe echo SET APERL64514BIN=U:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist T:\Perl64514\bin\perl.exe echo SET APERL64514BIN=T:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist S:\Perl64514\bin\perl.exe echo SET APERL64514BIN=S:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist R:\Perl64514\bin\perl.exe echo SET APERL64514BIN=R:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist Q:\Perl64514\bin\perl.exe echo SET APERL64514BIN=Q:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist P:\Perl64514\bin\perl.exe echo SET APERL64514BIN=P:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist O:\Perl64514\bin\perl.exe echo SET APERL64514BIN=O:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist N:\Perl64514\bin\perl.exe echo SET APERL64514BIN=N:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist M:\Perl64514\bin\perl.exe echo SET APERL64514BIN=M:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist L:\Perl64514\bin\perl.exe echo SET APERL64514BIN=L:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist K:\Perl64514\bin\perl.exe echo SET APERL64514BIN=K:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist J:\Perl64514\bin\perl.exe echo SET APERL64514BIN=J:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist I:\Perl64514\bin\perl.exe echo SET APERL64514BIN=I:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist H:\Perl64514\bin\perl.exe echo SET APERL64514BIN=H:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist G:\Perl64514\bin\perl.exe echo SET APERL64514BIN=G:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist F:\Perl64514\bin\perl.exe echo SET APERL64514BIN=F:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist E:\Perl64514\bin\perl.exe echo SET APERL64514BIN=E:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist D:\Perl64514\bin\perl.exe echo SET APERL64514BIN=D:\Perl64514\bin\perl.exe>APERL64514BIN.$$$
  if exist C:\Perl64514\bin\perl.exe echo SET APERL64514BIN=C:\Perl64514\bin\perl.exe>APERL64514BIN.$$$

  if exist APERL64514BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl64514\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable APERL64514BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type APERL64514BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type APERL64514BIN.$$$ >> C:\AUTOEXEC.BAT
  del APERL64514BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable APERL64514BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%APERL64514BIN%" == "" goto SetWinNT
  %APERL64514BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl64514\bin\perl.exe echo "APERL64514BIN"="Z:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist Y:\Perl64514\bin\perl.exe echo "APERL64514BIN"="Y:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist X:\Perl64514\bin\perl.exe echo "APERL64514BIN"="X:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist W:\Perl64514\bin\perl.exe echo "APERL64514BIN"="W:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist V:\Perl64514\bin\perl.exe echo "APERL64514BIN"="V:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist U:\Perl64514\bin\perl.exe echo "APERL64514BIN"="U:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist T:\Perl64514\bin\perl.exe echo "APERL64514BIN"="T:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist S:\Perl64514\bin\perl.exe echo "APERL64514BIN"="S:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist R:\Perl64514\bin\perl.exe echo "APERL64514BIN"="R:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist Q:\Perl64514\bin\perl.exe echo "APERL64514BIN"="Q:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist P:\Perl64514\bin\perl.exe echo "APERL64514BIN"="P:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist O:\Perl64514\bin\perl.exe echo "APERL64514BIN"="O:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist N:\Perl64514\bin\perl.exe echo "APERL64514BIN"="N:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist M:\Perl64514\bin\perl.exe echo "APERL64514BIN"="M:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist L:\Perl64514\bin\perl.exe echo "APERL64514BIN"="L:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist K:\Perl64514\bin\perl.exe echo "APERL64514BIN"="K:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist J:\Perl64514\bin\perl.exe echo "APERL64514BIN"="J:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist I:\Perl64514\bin\perl.exe echo "APERL64514BIN"="I:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist H:\Perl64514\bin\perl.exe echo "APERL64514BIN"="H:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist G:\Perl64514\bin\perl.exe echo "APERL64514BIN"="G:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist F:\Perl64514\bin\perl.exe echo "APERL64514BIN"="F:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist E:\Perl64514\bin\perl.exe echo "APERL64514BIN"="E:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist D:\Perl64514\bin\perl.exe echo "APERL64514BIN"="D:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$
  if exist C:\Perl64514\bin\perl.exe echo "APERL64514BIN"="C:\\Perl64514\\bin\\perl.exe">APERL64514BIN.$$$

  if exist APERL64514BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl64514\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable APERL64514BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type APERL64514BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>APERL64514BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>APERL64514BIN.REG
  echo.>>APERL64514BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>APERL64514BIN.REG
  type APERL64514BIN.$$$ >> APERL64514BIN.REG
  APERL64514BIN.REG
  del APERL64514BIN.REG
  del APERL64514BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable APERL64514BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

aperl64514 - execute perlscript on ActivePerl x64 5.14 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<aperl64514> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when ActivePerl x64 5.14 and other version of perl are on the one
computer. Do not set perl x64 5.14's bin directory to %PATH%.

It is necessary to install perl x64 5.14 in "\Perl64514\bin" directory of the drive of
either. This software is executed by perl x64 5.14, and find the perl x64 5.14 and execute it.

 Find perl x64 5.14 order by,
     Z:\Perl64514\bin\perl.exe
     Y:\Perl64514\bin\perl.exe
     X:\Perl64514\bin\perl.exe
                 :
                 :
     C:\Perl64514\bin\perl.exe

When found it at last, set its path to environment variable APERL64514BIN.

=head1 EXAMPLES

    C:\> aperl64514 foo.pl
    [..execute foo.pl by perl x64 5.14..]

=head1 BUGS AND LIMITATIONS

Please patches and report problems to author are welcome.

=head1 AUTHOR

INABA Hitoshi E<lt>ina@cpan.orgE<gt>

This project was originated by INABA Hitoshi.
For any questions, use E<lt>ina@cpan.orgE<gt> so we can share
this file.

=head1 LICENSE AND COPYRIGHT

This software is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

This software is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=head1 SEE ALSO

ActivePerl
http://www.activestate.com/activeperl

=cut

:END
