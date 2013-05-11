@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  cperl - execute perlscript on Cygwin Perl without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012, 2013 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%CPERLBIN%" == "" goto SetWin95
  %CPERLBIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET CPERLBIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET CPERLBIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable CPERLBIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\cygwin\bin\perl.exe echo SET CPERLBIN=Z:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist Y:\cygwin\bin\perl.exe echo SET CPERLBIN=Y:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist X:\cygwin\bin\perl.exe echo SET CPERLBIN=X:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist W:\cygwin\bin\perl.exe echo SET CPERLBIN=W:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist V:\cygwin\bin\perl.exe echo SET CPERLBIN=V:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist U:\cygwin\bin\perl.exe echo SET CPERLBIN=U:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist T:\cygwin\bin\perl.exe echo SET CPERLBIN=T:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist S:\cygwin\bin\perl.exe echo SET CPERLBIN=S:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist R:\cygwin\bin\perl.exe echo SET CPERLBIN=R:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist Q:\cygwin\bin\perl.exe echo SET CPERLBIN=Q:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist P:\cygwin\bin\perl.exe echo SET CPERLBIN=P:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist O:\cygwin\bin\perl.exe echo SET CPERLBIN=O:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist N:\cygwin\bin\perl.exe echo SET CPERLBIN=N:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist M:\cygwin\bin\perl.exe echo SET CPERLBIN=M:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist L:\cygwin\bin\perl.exe echo SET CPERLBIN=L:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist K:\cygwin\bin\perl.exe echo SET CPERLBIN=K:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist J:\cygwin\bin\perl.exe echo SET CPERLBIN=J:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist I:\cygwin\bin\perl.exe echo SET CPERLBIN=I:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist H:\cygwin\bin\perl.exe echo SET CPERLBIN=H:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist G:\cygwin\bin\perl.exe echo SET CPERLBIN=G:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist F:\cygwin\bin\perl.exe echo SET CPERLBIN=F:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist E:\cygwin\bin\perl.exe echo SET CPERLBIN=E:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist D:\cygwin\bin\perl.exe echo SET CPERLBIN=D:\cygwin\bin\perl.exe>CPERLBIN.$$$
  if exist C:\cygwin\bin\perl.exe echo SET CPERLBIN=C:\cygwin\bin\perl.exe>CPERLBIN.$$$

  if exist CPERLBIN.$$$ goto L2

  echo ***********************************************************
  echo "\cygwin\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable CPERLBIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type CPERLBIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  type CPERLBIN.$$$ >> C:\AUTOEXEC.BAT
  del CPERLBIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable CPERLBIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%CPERLBIN%" == "" goto SetWinNT
  %CPERLBIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\cygwin\bin\perl.exe echo "CPERLBIN"="Z:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist Y:\cygwin\bin\perl.exe echo "CPERLBIN"="Y:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist X:\cygwin\bin\perl.exe echo "CPERLBIN"="X:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist W:\cygwin\bin\perl.exe echo "CPERLBIN"="W:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist V:\cygwin\bin\perl.exe echo "CPERLBIN"="V:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist U:\cygwin\bin\perl.exe echo "CPERLBIN"="U:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist T:\cygwin\bin\perl.exe echo "CPERLBIN"="T:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist S:\cygwin\bin\perl.exe echo "CPERLBIN"="S:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist R:\cygwin\bin\perl.exe echo "CPERLBIN"="R:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist Q:\cygwin\bin\perl.exe echo "CPERLBIN"="Q:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist P:\cygwin\bin\perl.exe echo "CPERLBIN"="P:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist O:\cygwin\bin\perl.exe echo "CPERLBIN"="O:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist N:\cygwin\bin\perl.exe echo "CPERLBIN"="N:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist M:\cygwin\bin\perl.exe echo "CPERLBIN"="M:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist L:\cygwin\bin\perl.exe echo "CPERLBIN"="L:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist K:\cygwin\bin\perl.exe echo "CPERLBIN"="K:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist J:\cygwin\bin\perl.exe echo "CPERLBIN"="J:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist I:\cygwin\bin\perl.exe echo "CPERLBIN"="I:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist H:\cygwin\bin\perl.exe echo "CPERLBIN"="H:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist G:\cygwin\bin\perl.exe echo "CPERLBIN"="G:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist F:\cygwin\bin\perl.exe echo "CPERLBIN"="F:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist E:\cygwin\bin\perl.exe echo "CPERLBIN"="E:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist D:\cygwin\bin\perl.exe echo "CPERLBIN"="D:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$
  if exist C:\cygwin\bin\perl.exe echo "CPERLBIN"="C:\\cygwin\\bin\\perl.exe">CPERLBIN.$$$

  if exist CPERLBIN.$$$ goto L3

  echo ***********************************************************
  echo "\cygwin\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable CPERLBIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type CPERLBIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>CPERLBIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>CPERLBIN.REG
  echo.>>CPERLBIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>CPERLBIN.REG
  type CPERLBIN.$$$ >> CPERLBIN.REG
  CPERLBIN.REG
  del CPERLBIN.REG
  del CPERLBIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable CPERLBIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

cperl - execute perlscript on Cygwin Perl without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<cperl> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when Cygwin perl and other version of perl are on the one
computer. Do not set Cygwin perl bin directory to %PATH%.

It is necessary to install perl in "\cygwin\bin\perl.exe" directory of the drive of
either. This software is executed by perl, and find the perl and execute it.

 Find perl order by,
     Z:\cygwin\bin\perl.exe
     Y:\cygwin\bin\perl.exe
     X:\cygwin\bin\perl.exe
                 :
                 :
     C:\cygwin\bin\perl.exe

When found it at last, set its path to environment variable CPERLBIN.

=head1 EXAMPLES

    C:\> cperl foo.pl
    [..execute foo.pl by perl ..]

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

Cygwin
http://www.cygwin.com/

=cut

:END
