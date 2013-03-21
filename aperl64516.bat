@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  aperl64516 - execute perlscript on ActivePerl x64 5.16 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012, 2013 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%APERL64516BIN%" == "" goto SetWin95
  %APERL64516BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET APERL64516BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET APERL64516BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable APERL64516BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl64516\bin\perl.exe echo SET APERL64516BIN=Z:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist Y:\Perl64516\bin\perl.exe echo SET APERL64516BIN=Y:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist X:\Perl64516\bin\perl.exe echo SET APERL64516BIN=X:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist W:\Perl64516\bin\perl.exe echo SET APERL64516BIN=W:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist V:\Perl64516\bin\perl.exe echo SET APERL64516BIN=V:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist U:\Perl64516\bin\perl.exe echo SET APERL64516BIN=U:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist T:\Perl64516\bin\perl.exe echo SET APERL64516BIN=T:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist S:\Perl64516\bin\perl.exe echo SET APERL64516BIN=S:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist R:\Perl64516\bin\perl.exe echo SET APERL64516BIN=R:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist Q:\Perl64516\bin\perl.exe echo SET APERL64516BIN=Q:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist P:\Perl64516\bin\perl.exe echo SET APERL64516BIN=P:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist O:\Perl64516\bin\perl.exe echo SET APERL64516BIN=O:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist N:\Perl64516\bin\perl.exe echo SET APERL64516BIN=N:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist M:\Perl64516\bin\perl.exe echo SET APERL64516BIN=M:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist L:\Perl64516\bin\perl.exe echo SET APERL64516BIN=L:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist K:\Perl64516\bin\perl.exe echo SET APERL64516BIN=K:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist J:\Perl64516\bin\perl.exe echo SET APERL64516BIN=J:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist I:\Perl64516\bin\perl.exe echo SET APERL64516BIN=I:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist H:\Perl64516\bin\perl.exe echo SET APERL64516BIN=H:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist G:\Perl64516\bin\perl.exe echo SET APERL64516BIN=G:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist F:\Perl64516\bin\perl.exe echo SET APERL64516BIN=F:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist E:\Perl64516\bin\perl.exe echo SET APERL64516BIN=E:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist D:\Perl64516\bin\perl.exe echo SET APERL64516BIN=D:\Perl64516\bin\perl.exe>APERL64516BIN.$$$
  if exist C:\Perl64516\bin\perl.exe echo SET APERL64516BIN=C:\Perl64516\bin\perl.exe>APERL64516BIN.$$$

  if exist APERL64516BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl64516\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable APERL64516BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type APERL64516BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  type APERL64516BIN.$$$ >> C:\AUTOEXEC.BAT
  del APERL64516BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable APERL64516BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%APERL64516BIN%" == "" goto SetWinNT
  %APERL64516BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl64516\bin\perl.exe echo "APERL64516BIN"="Z:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist Y:\Perl64516\bin\perl.exe echo "APERL64516BIN"="Y:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist X:\Perl64516\bin\perl.exe echo "APERL64516BIN"="X:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist W:\Perl64516\bin\perl.exe echo "APERL64516BIN"="W:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist V:\Perl64516\bin\perl.exe echo "APERL64516BIN"="V:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist U:\Perl64516\bin\perl.exe echo "APERL64516BIN"="U:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist T:\Perl64516\bin\perl.exe echo "APERL64516BIN"="T:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist S:\Perl64516\bin\perl.exe echo "APERL64516BIN"="S:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist R:\Perl64516\bin\perl.exe echo "APERL64516BIN"="R:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist Q:\Perl64516\bin\perl.exe echo "APERL64516BIN"="Q:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist P:\Perl64516\bin\perl.exe echo "APERL64516BIN"="P:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist O:\Perl64516\bin\perl.exe echo "APERL64516BIN"="O:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist N:\Perl64516\bin\perl.exe echo "APERL64516BIN"="N:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist M:\Perl64516\bin\perl.exe echo "APERL64516BIN"="M:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist L:\Perl64516\bin\perl.exe echo "APERL64516BIN"="L:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist K:\Perl64516\bin\perl.exe echo "APERL64516BIN"="K:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist J:\Perl64516\bin\perl.exe echo "APERL64516BIN"="J:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist I:\Perl64516\bin\perl.exe echo "APERL64516BIN"="I:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist H:\Perl64516\bin\perl.exe echo "APERL64516BIN"="H:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist G:\Perl64516\bin\perl.exe echo "APERL64516BIN"="G:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist F:\Perl64516\bin\perl.exe echo "APERL64516BIN"="F:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist E:\Perl64516\bin\perl.exe echo "APERL64516BIN"="E:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist D:\Perl64516\bin\perl.exe echo "APERL64516BIN"="D:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$
  if exist C:\Perl64516\bin\perl.exe echo "APERL64516BIN"="C:\\Perl64516\\bin\\perl.exe">APERL64516BIN.$$$

  if exist APERL64516BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl64516\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable APERL64516BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type APERL64516BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>APERL64516BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>APERL64516BIN.REG
  echo.>>APERL64516BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>APERL64516BIN.REG
  type APERL64516BIN.$$$ >> APERL64516BIN.REG
  APERL64516BIN.REG
  del APERL64516BIN.REG
  del APERL64516BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable APERL64516BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

aperl64516 - execute perlscript on ActivePerl x64 5.16 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<aperl64516> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when ActivePerl x64 5.16 and other version of perl are on the one
computer. Do not set perl x64 5.16's bin directory to %PATH%.

It is necessary to install perl x64 5.16 in "\Perl64516\bin" directory of the drive of
either. This software is executed by perl x64 5.16, and find the perl x64 5.16 and execute it.

 Find perl x64 5.16 order by,
     Z:\Perl64516\bin\perl.exe
     Y:\Perl64516\bin\perl.exe
     X:\Perl64516\bin\perl.exe
                 :
                 :
     C:\Perl64516\bin\perl.exe

When found it at last, set its path to environment variable APERL64516BIN.

=head1 EXAMPLES

    C:\> aperl64516 foo.pl
    [..execute foo.pl by perl x64 5.16..]

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
