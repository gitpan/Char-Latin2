@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  aperl64518 - execute perlscript on ActivePerl x64 5.18 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012, 2013 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%APERL64518BIN%" == "" goto SetWin95
  %APERL64518BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET APERL64518BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET APERL64518BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable APERL64518BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl64518\bin\perl.exe echo SET APERL64518BIN=Z:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist Y:\Perl64518\bin\perl.exe echo SET APERL64518BIN=Y:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist X:\Perl64518\bin\perl.exe echo SET APERL64518BIN=X:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist W:\Perl64518\bin\perl.exe echo SET APERL64518BIN=W:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist V:\Perl64518\bin\perl.exe echo SET APERL64518BIN=V:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist U:\Perl64518\bin\perl.exe echo SET APERL64518BIN=U:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist T:\Perl64518\bin\perl.exe echo SET APERL64518BIN=T:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist S:\Perl64518\bin\perl.exe echo SET APERL64518BIN=S:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist R:\Perl64518\bin\perl.exe echo SET APERL64518BIN=R:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist Q:\Perl64518\bin\perl.exe echo SET APERL64518BIN=Q:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist P:\Perl64518\bin\perl.exe echo SET APERL64518BIN=P:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist O:\Perl64518\bin\perl.exe echo SET APERL64518BIN=O:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist N:\Perl64518\bin\perl.exe echo SET APERL64518BIN=N:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist M:\Perl64518\bin\perl.exe echo SET APERL64518BIN=M:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist L:\Perl64518\bin\perl.exe echo SET APERL64518BIN=L:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist K:\Perl64518\bin\perl.exe echo SET APERL64518BIN=K:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist J:\Perl64518\bin\perl.exe echo SET APERL64518BIN=J:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist I:\Perl64518\bin\perl.exe echo SET APERL64518BIN=I:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist H:\Perl64518\bin\perl.exe echo SET APERL64518BIN=H:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist G:\Perl64518\bin\perl.exe echo SET APERL64518BIN=G:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist F:\Perl64518\bin\perl.exe echo SET APERL64518BIN=F:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist E:\Perl64518\bin\perl.exe echo SET APERL64518BIN=E:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist D:\Perl64518\bin\perl.exe echo SET APERL64518BIN=D:\Perl64518\bin\perl.exe>APERL64518BIN.$$$
  if exist C:\Perl64518\bin\perl.exe echo SET APERL64518BIN=C:\Perl64518\bin\perl.exe>APERL64518BIN.$$$

  if exist APERL64518BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl64518\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable APERL64518BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type APERL64518BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  type APERL64518BIN.$$$ >> C:\AUTOEXEC.BAT
  del APERL64518BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable APERL64518BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%APERL64518BIN%" == "" goto SetWinNT
  %APERL64518BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl64518\bin\perl.exe echo "APERL64518BIN"="Z:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist Y:\Perl64518\bin\perl.exe echo "APERL64518BIN"="Y:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist X:\Perl64518\bin\perl.exe echo "APERL64518BIN"="X:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist W:\Perl64518\bin\perl.exe echo "APERL64518BIN"="W:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist V:\Perl64518\bin\perl.exe echo "APERL64518BIN"="V:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist U:\Perl64518\bin\perl.exe echo "APERL64518BIN"="U:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist T:\Perl64518\bin\perl.exe echo "APERL64518BIN"="T:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist S:\Perl64518\bin\perl.exe echo "APERL64518BIN"="S:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist R:\Perl64518\bin\perl.exe echo "APERL64518BIN"="R:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist Q:\Perl64518\bin\perl.exe echo "APERL64518BIN"="Q:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist P:\Perl64518\bin\perl.exe echo "APERL64518BIN"="P:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist O:\Perl64518\bin\perl.exe echo "APERL64518BIN"="O:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist N:\Perl64518\bin\perl.exe echo "APERL64518BIN"="N:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist M:\Perl64518\bin\perl.exe echo "APERL64518BIN"="M:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist L:\Perl64518\bin\perl.exe echo "APERL64518BIN"="L:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist K:\Perl64518\bin\perl.exe echo "APERL64518BIN"="K:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist J:\Perl64518\bin\perl.exe echo "APERL64518BIN"="J:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist I:\Perl64518\bin\perl.exe echo "APERL64518BIN"="I:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist H:\Perl64518\bin\perl.exe echo "APERL64518BIN"="H:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist G:\Perl64518\bin\perl.exe echo "APERL64518BIN"="G:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist F:\Perl64518\bin\perl.exe echo "APERL64518BIN"="F:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist E:\Perl64518\bin\perl.exe echo "APERL64518BIN"="E:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist D:\Perl64518\bin\perl.exe echo "APERL64518BIN"="D:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$
  if exist C:\Perl64518\bin\perl.exe echo "APERL64518BIN"="C:\\Perl64518\\bin\\perl.exe">APERL64518BIN.$$$

  if exist APERL64518BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl64518\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable APERL64518BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type APERL64518BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>APERL64518BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>APERL64518BIN.REG
  echo.>>APERL64518BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>APERL64518BIN.REG
  type APERL64518BIN.$$$ >> APERL64518BIN.REG
  APERL64518BIN.REG
  del APERL64518BIN.REG
  del APERL64518BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable APERL64518BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

aperl64518 - execute perlscript on ActivePerl x64 5.18 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<aperl64518> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when ActivePerl x64 5.18 and other version of perl are on the one
computer. Do not set perl x64 5.18's bin directory to %PATH%.

It is necessary to install perl x64 5.18 in "\Perl64518\bin" directory of the drive of
either. This software is executed by perl x64 5.18, and find the perl x64 5.18 and execute it.

 Find perl x64 5.18 order by,
     Z:\Perl64518\bin\perl.exe
     Y:\Perl64518\bin\perl.exe
     X:\Perl64518\bin\perl.exe
                 :
                 :
     C:\Perl64518\bin\perl.exe

When found it at last, set its path to environment variable APERL64518BIN.

=head1 EXAMPLES

    C:\> aperl64518 foo.pl
    [..execute foo.pl by perl x64 5.18..]

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
