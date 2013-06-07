@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  dperl - execute perlscript on DWIM Perl without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012, 2013 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%DPERLBIN%" == "" goto SetWin95
  %DPERLBIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET DPERLBIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET DPERLBIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable DPERLBIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=Z:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist Y:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=Y:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist X:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=X:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist W:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=W:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist V:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=V:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist U:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=U:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist T:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=T:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist S:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=S:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist R:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=R:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist Q:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=Q:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist P:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=P:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist O:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=O:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist N:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=N:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist M:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=M:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist L:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=L:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist K:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=K:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist J:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=J:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist I:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=I:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist H:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=H:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist G:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=G:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist F:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=F:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist E:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=E:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist D:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=D:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$
  if exist C:\Dwimperl\perl\bin\perl.exe echo SET DPERLBIN=C:\Dwimperl\perl\bin\perl.exe>DPERLBIN.$$$

  if exist DPERLBIN.$$$ goto L2

  echo ***********************************************************
  echo "\Dwimperl\perl\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable DPERLBIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type DPERLBIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  type DPERLBIN.$$$ >> C:\AUTOEXEC.BAT
  del DPERLBIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable DPERLBIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%DPERLBIN%" == "" goto SetWinNT
  %DPERLBIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="Z:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist Y:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="Y:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist X:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="X:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist W:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="W:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist V:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="V:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist U:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="U:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist T:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="T:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist S:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="S:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist R:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="R:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist Q:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="Q:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist P:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="P:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist O:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="O:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist N:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="N:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist M:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="M:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist L:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="L:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist K:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="K:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist J:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="J:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist I:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="I:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist H:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="H:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist G:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="G:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist F:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="F:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist E:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="E:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist D:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="D:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$
  if exist C:\Dwimperl\perl\bin\perl.exe echo "DPERLBIN"="C:\\Dwimperl\\perl\\bin\\perl.exe">DPERLBIN.$$$

  if exist DPERLBIN.$$$ goto L3

  echo ***********************************************************
  echo "\Dwimperl\perl\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable DPERLBIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type DPERLBIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>DPERLBIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>DPERLBIN.REG
  echo.>>DPERLBIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>DPERLBIN.REG
  type DPERLBIN.$$$ >> DPERLBIN.REG
  DPERLBIN.REG
  del DPERLBIN.REG
  del DPERLBIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable DPERLBIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

dperl - execute perlscript on DWIM Perl without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<dperl> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when DWIM perl and other version of perl are on the one
computer. Do not set DWIM perl bin directory to %PATH%.

It is necessary to install perl in "\Dwimperl\perl\bin\perl.exe" directory of the drive of
either. This software is executed by perl, and find the perl and execute it.

 Find perl order by,
     Z:\Dwimperl\perl\bin\perl.exe
     Y:\Dwimperl\perl\bin\perl.exe
     X:\Dwimperl\perl\bin\perl.exe
                 :
                 :
     C:\Dwimperl\perl\bin\perl.exe

When found it at last, set its path to environment variable DPERLBIN.

=head1 EXAMPLES

    C:\> dperl foo.pl
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

DWIM Perl: Do What I Mean, Perl
http://dwimperl.com/

=cut

:END
