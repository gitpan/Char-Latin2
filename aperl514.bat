@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  aperl514 - execute perlscript on ActivePerl 5.14 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%APERL514BIN%" == "" goto SetWin95
  %APERL514BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET APERL514BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET APERL514BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable APERL514BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl514\bin\perl.exe echo SET APERL514BIN=Z:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist Y:\Perl514\bin\perl.exe echo SET APERL514BIN=Y:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist X:\Perl514\bin\perl.exe echo SET APERL514BIN=X:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist W:\Perl514\bin\perl.exe echo SET APERL514BIN=W:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist V:\Perl514\bin\perl.exe echo SET APERL514BIN=V:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist U:\Perl514\bin\perl.exe echo SET APERL514BIN=U:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist T:\Perl514\bin\perl.exe echo SET APERL514BIN=T:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist S:\Perl514\bin\perl.exe echo SET APERL514BIN=S:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist R:\Perl514\bin\perl.exe echo SET APERL514BIN=R:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist Q:\Perl514\bin\perl.exe echo SET APERL514BIN=Q:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist P:\Perl514\bin\perl.exe echo SET APERL514BIN=P:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist O:\Perl514\bin\perl.exe echo SET APERL514BIN=O:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist N:\Perl514\bin\perl.exe echo SET APERL514BIN=N:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist M:\Perl514\bin\perl.exe echo SET APERL514BIN=M:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist L:\Perl514\bin\perl.exe echo SET APERL514BIN=L:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist K:\Perl514\bin\perl.exe echo SET APERL514BIN=K:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist J:\Perl514\bin\perl.exe echo SET APERL514BIN=J:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist I:\Perl514\bin\perl.exe echo SET APERL514BIN=I:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist H:\Perl514\bin\perl.exe echo SET APERL514BIN=H:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist G:\Perl514\bin\perl.exe echo SET APERL514BIN=G:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist F:\Perl514\bin\perl.exe echo SET APERL514BIN=F:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist E:\Perl514\bin\perl.exe echo SET APERL514BIN=E:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist D:\Perl514\bin\perl.exe echo SET APERL514BIN=D:\Perl514\bin\perl.exe>APERL514BIN.$$$
  if exist C:\Perl514\bin\perl.exe echo SET APERL514BIN=C:\Perl514\bin\perl.exe>APERL514BIN.$$$

  if exist APERL514BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl514\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable APERL514BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type APERL514BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type APERL514BIN.$$$ >> C:\AUTOEXEC.BAT
  del APERL514BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable APERL514BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%APERL514BIN%" == "" goto SetWinNT
  %APERL514BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl514\bin\perl.exe echo "APERL514BIN"="Z:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist Y:\Perl514\bin\perl.exe echo "APERL514BIN"="Y:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist X:\Perl514\bin\perl.exe echo "APERL514BIN"="X:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist W:\Perl514\bin\perl.exe echo "APERL514BIN"="W:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist V:\Perl514\bin\perl.exe echo "APERL514BIN"="V:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist U:\Perl514\bin\perl.exe echo "APERL514BIN"="U:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist T:\Perl514\bin\perl.exe echo "APERL514BIN"="T:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist S:\Perl514\bin\perl.exe echo "APERL514BIN"="S:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist R:\Perl514\bin\perl.exe echo "APERL514BIN"="R:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist Q:\Perl514\bin\perl.exe echo "APERL514BIN"="Q:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist P:\Perl514\bin\perl.exe echo "APERL514BIN"="P:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist O:\Perl514\bin\perl.exe echo "APERL514BIN"="O:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist N:\Perl514\bin\perl.exe echo "APERL514BIN"="N:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist M:\Perl514\bin\perl.exe echo "APERL514BIN"="M:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist L:\Perl514\bin\perl.exe echo "APERL514BIN"="L:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist K:\Perl514\bin\perl.exe echo "APERL514BIN"="K:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist J:\Perl514\bin\perl.exe echo "APERL514BIN"="J:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist I:\Perl514\bin\perl.exe echo "APERL514BIN"="I:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist H:\Perl514\bin\perl.exe echo "APERL514BIN"="H:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist G:\Perl514\bin\perl.exe echo "APERL514BIN"="G:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist F:\Perl514\bin\perl.exe echo "APERL514BIN"="F:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist E:\Perl514\bin\perl.exe echo "APERL514BIN"="E:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist D:\Perl514\bin\perl.exe echo "APERL514BIN"="D:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$
  if exist C:\Perl514\bin\perl.exe echo "APERL514BIN"="C:\\Perl514\\bin\\perl.exe">APERL514BIN.$$$

  if exist APERL514BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl514\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable APERL514BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type APERL514BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>APERL514BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>APERL514BIN.REG
  echo.>>APERL514BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>APERL514BIN.REG
  type APERL514BIN.$$$ >> APERL514BIN.REG
  APERL514BIN.REG
  del APERL514BIN.REG
  del APERL514BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable APERL514BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

aperl514 - execute perlscript on ActivePerl 5.14 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<aperl514> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when ActivePerl 5.14 and other version of perl are on the one
computer. Do not set perl 5.14's bin directory to %PATH%.

It is necessary to install perl 5.14 in "\Perl514\bin" directory of the drive of
either. This software is executed by perl 5.14, and find the perl 5.14 and execute it.

 Find perl 5.14 order by,
     Z:\Perl514\bin\perl.exe
     Y:\Perl514\bin\perl.exe
     X:\Perl514\bin\perl.exe
                 :
                 :
     C:\Perl514\bin\perl.exe

When found it at last, set its path to environment variable APERL514BIN.

=head1 EXAMPLES

    C:\> aperl514 foo.pl
    [..execute foo.pl by perl 5.14..]

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
