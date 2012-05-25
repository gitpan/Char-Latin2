@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  aperl510 - execute perlscript on ActivePerl 5.8 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%APERL510BIN%" == "" goto SetWin95
  %APERL510BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET APERL510BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET APERL510BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable APERL510BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl510\bin\perl.exe echo SET APERL510BIN=Z:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist Y:\Perl510\bin\perl.exe echo SET APERL510BIN=Y:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist X:\Perl510\bin\perl.exe echo SET APERL510BIN=X:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist W:\Perl510\bin\perl.exe echo SET APERL510BIN=W:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist V:\Perl510\bin\perl.exe echo SET APERL510BIN=V:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist U:\Perl510\bin\perl.exe echo SET APERL510BIN=U:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist T:\Perl510\bin\perl.exe echo SET APERL510BIN=T:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist S:\Perl510\bin\perl.exe echo SET APERL510BIN=S:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist R:\Perl510\bin\perl.exe echo SET APERL510BIN=R:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist Q:\Perl510\bin\perl.exe echo SET APERL510BIN=Q:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist P:\Perl510\bin\perl.exe echo SET APERL510BIN=P:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist O:\Perl510\bin\perl.exe echo SET APERL510BIN=O:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist N:\Perl510\bin\perl.exe echo SET APERL510BIN=N:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist M:\Perl510\bin\perl.exe echo SET APERL510BIN=M:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist L:\Perl510\bin\perl.exe echo SET APERL510BIN=L:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist K:\Perl510\bin\perl.exe echo SET APERL510BIN=K:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist J:\Perl510\bin\perl.exe echo SET APERL510BIN=J:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist I:\Perl510\bin\perl.exe echo SET APERL510BIN=I:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist H:\Perl510\bin\perl.exe echo SET APERL510BIN=H:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist G:\Perl510\bin\perl.exe echo SET APERL510BIN=G:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist F:\Perl510\bin\perl.exe echo SET APERL510BIN=F:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist E:\Perl510\bin\perl.exe echo SET APERL510BIN=E:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist D:\Perl510\bin\perl.exe echo SET APERL510BIN=D:\Perl510\bin\perl.exe>APERL510BIN.$$$
  if exist C:\Perl510\bin\perl.exe echo SET APERL510BIN=C:\Perl510\bin\perl.exe>APERL510BIN.$$$

  if exist APERL510BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl510\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable APERL510BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type APERL510BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type APERL510BIN.$$$ >> C:\AUTOEXEC.BAT
  del APERL510BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable APERL510BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%APERL510BIN%" == "" goto SetWinNT
  %APERL510BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl510\bin\perl.exe echo "APERL510BIN"="Z:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist Y:\Perl510\bin\perl.exe echo "APERL510BIN"="Y:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist X:\Perl510\bin\perl.exe echo "APERL510BIN"="X:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist W:\Perl510\bin\perl.exe echo "APERL510BIN"="W:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist V:\Perl510\bin\perl.exe echo "APERL510BIN"="V:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist U:\Perl510\bin\perl.exe echo "APERL510BIN"="U:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist T:\Perl510\bin\perl.exe echo "APERL510BIN"="T:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist S:\Perl510\bin\perl.exe echo "APERL510BIN"="S:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist R:\Perl510\bin\perl.exe echo "APERL510BIN"="R:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist Q:\Perl510\bin\perl.exe echo "APERL510BIN"="Q:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist P:\Perl510\bin\perl.exe echo "APERL510BIN"="P:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist O:\Perl510\bin\perl.exe echo "APERL510BIN"="O:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist N:\Perl510\bin\perl.exe echo "APERL510BIN"="N:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist M:\Perl510\bin\perl.exe echo "APERL510BIN"="M:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist L:\Perl510\bin\perl.exe echo "APERL510BIN"="L:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist K:\Perl510\bin\perl.exe echo "APERL510BIN"="K:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist J:\Perl510\bin\perl.exe echo "APERL510BIN"="J:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist I:\Perl510\bin\perl.exe echo "APERL510BIN"="I:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist H:\Perl510\bin\perl.exe echo "APERL510BIN"="H:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist G:\Perl510\bin\perl.exe echo "APERL510BIN"="G:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist F:\Perl510\bin\perl.exe echo "APERL510BIN"="F:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist E:\Perl510\bin\perl.exe echo "APERL510BIN"="E:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist D:\Perl510\bin\perl.exe echo "APERL510BIN"="D:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$
  if exist C:\Perl510\bin\perl.exe echo "APERL510BIN"="C:\\Perl510\\bin\\perl.exe">APERL510BIN.$$$

  if exist APERL510BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl510\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable APERL510BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type APERL510BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>APERL510BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>APERL510BIN.REG
  echo.>>APERL510BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>APERL510BIN.REG
  type APERL510BIN.$$$ >> APERL510BIN.REG
  APERL510BIN.REG
  del APERL510BIN.REG
  del APERL510BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable APERL510BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

aperl510 - execute perlscript on ActivePerl 5.8 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<aperl510> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when ActivePerl 5.8 and other version of perl are on the one
computer. Do not set perl5.10's bin directory to %PATH%.

It is necessary to install perl5.10 in "\Perl510\bin" directory of the drive of
either. This software is executed by perl5.10, and find the perl5.10 and execute it.

 Find perl5.10 order by,
     Z:\Perl510\bin\perl.exe
     Y:\Perl510\bin\perl.exe
     X:\Perl510\bin\perl.exe
                 :
                 :
     C:\Perl510\bin\perl.exe

When found it at last, set its path to environment variable APERL510BIN.

=head1 EXAMPLES

    C:\> aperl510 foo.pl
    [..execute foo.pl by perl5.10..]

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
