@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  perl64518 - execute perlscript on ActivePerl x64 5.18 or Strawbery Perl x64 5.18 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012, 2013 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%PERL64518BIN%" == "" goto SetWin95
  %PERL64518BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET PERL64518BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET PERL64518BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable PERL64518BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl64518\bin\perl.exe echo SET PERL64518BIN=Z:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist Y:\Perl64518\bin\perl.exe echo SET PERL64518BIN=Y:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist X:\Perl64518\bin\perl.exe echo SET PERL64518BIN=X:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist W:\Perl64518\bin\perl.exe echo SET PERL64518BIN=W:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist V:\Perl64518\bin\perl.exe echo SET PERL64518BIN=V:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist U:\Perl64518\bin\perl.exe echo SET PERL64518BIN=U:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist T:\Perl64518\bin\perl.exe echo SET PERL64518BIN=T:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist S:\Perl64518\bin\perl.exe echo SET PERL64518BIN=S:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist R:\Perl64518\bin\perl.exe echo SET PERL64518BIN=R:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist Q:\Perl64518\bin\perl.exe echo SET PERL64518BIN=Q:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist P:\Perl64518\bin\perl.exe echo SET PERL64518BIN=P:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist O:\Perl64518\bin\perl.exe echo SET PERL64518BIN=O:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist N:\Perl64518\bin\perl.exe echo SET PERL64518BIN=N:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist M:\Perl64518\bin\perl.exe echo SET PERL64518BIN=M:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist L:\Perl64518\bin\perl.exe echo SET PERL64518BIN=L:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist K:\Perl64518\bin\perl.exe echo SET PERL64518BIN=K:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist J:\Perl64518\bin\perl.exe echo SET PERL64518BIN=J:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist I:\Perl64518\bin\perl.exe echo SET PERL64518BIN=I:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist H:\Perl64518\bin\perl.exe echo SET PERL64518BIN=H:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist G:\Perl64518\bin\perl.exe echo SET PERL64518BIN=G:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist F:\Perl64518\bin\perl.exe echo SET PERL64518BIN=F:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist E:\Perl64518\bin\perl.exe echo SET PERL64518BIN=E:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist D:\Perl64518\bin\perl.exe echo SET PERL64518BIN=D:\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist C:\Perl64518\bin\perl.exe echo SET PERL64518BIN=C:\Perl64518\bin\perl.exe>PERL64518BIN.$$$

  if exist Z:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=Z:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist Y:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=Y:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist X:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=X:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist W:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=W:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist V:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=V:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist U:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=U:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist T:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=T:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist S:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=S:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist R:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=R:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist Q:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=Q:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist P:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=P:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist O:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=O:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist N:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=N:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist M:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=M:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist L:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=L:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist K:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=K:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist J:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=J:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist I:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=I:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist H:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=H:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist G:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=G:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist F:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=F:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist E:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=E:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist D:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=D:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$
  if exist C:\strawberry\Perl64518\bin\perl.exe echo SET PERL64518BIN=C:\strawberry\Perl64518\bin\perl.exe>PERL64518BIN.$$$

  if exist PERL64518BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl64518\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable PERL64518BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type PERL64518BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  type PERL64518BIN.$$$ >> C:\AUTOEXEC.BAT
  del PERL64518BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL64518BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%PERL64518BIN%" == "" goto SetWinNT
  %PERL64518BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl64518\bin\perl.exe echo "PERL64518BIN"="Z:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist Y:\Perl64518\bin\perl.exe echo "PERL64518BIN"="Y:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist X:\Perl64518\bin\perl.exe echo "PERL64518BIN"="X:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist W:\Perl64518\bin\perl.exe echo "PERL64518BIN"="W:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist V:\Perl64518\bin\perl.exe echo "PERL64518BIN"="V:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist U:\Perl64518\bin\perl.exe echo "PERL64518BIN"="U:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist T:\Perl64518\bin\perl.exe echo "PERL64518BIN"="T:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist S:\Perl64518\bin\perl.exe echo "PERL64518BIN"="S:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist R:\Perl64518\bin\perl.exe echo "PERL64518BIN"="R:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist Q:\Perl64518\bin\perl.exe echo "PERL64518BIN"="Q:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist P:\Perl64518\bin\perl.exe echo "PERL64518BIN"="P:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist O:\Perl64518\bin\perl.exe echo "PERL64518BIN"="O:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist N:\Perl64518\bin\perl.exe echo "PERL64518BIN"="N:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist M:\Perl64518\bin\perl.exe echo "PERL64518BIN"="M:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist L:\Perl64518\bin\perl.exe echo "PERL64518BIN"="L:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist K:\Perl64518\bin\perl.exe echo "PERL64518BIN"="K:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist J:\Perl64518\bin\perl.exe echo "PERL64518BIN"="J:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist I:\Perl64518\bin\perl.exe echo "PERL64518BIN"="I:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist H:\Perl64518\bin\perl.exe echo "PERL64518BIN"="H:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist G:\Perl64518\bin\perl.exe echo "PERL64518BIN"="G:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist F:\Perl64518\bin\perl.exe echo "PERL64518BIN"="F:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist E:\Perl64518\bin\perl.exe echo "PERL64518BIN"="E:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist D:\Perl64518\bin\perl.exe echo "PERL64518BIN"="D:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist C:\Perl64518\bin\perl.exe echo "PERL64518BIN"="C:\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$

  if exist Z:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="Z:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist Y:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="Y:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist X:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="X:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist W:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="W:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist V:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="V:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist U:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="U:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist T:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="T:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist S:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="S:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist R:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="R:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist Q:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="Q:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist P:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="P:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist O:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="O:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist N:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="N:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist M:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="M:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist L:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="L:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist K:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="K:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist J:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="J:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist I:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="I:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist H:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="H:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist G:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="G:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist F:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="F:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist E:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="E:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist D:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="D:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$
  if exist C:\strawberry\Perl64518\bin\perl.exe echo "PERL64518BIN"="C:\\strawberry\\Perl64518\\bin\\perl.exe">PERL64518BIN.$$$

  if exist PERL64518BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl64518\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable PERL64518BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type PERL64518BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>PERL64518BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>PERL64518BIN.REG
  echo.>>PERL64518BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>PERL64518BIN.REG
  type PERL64518BIN.$$$ >> PERL64518BIN.REG
  PERL64518BIN.REG
  del PERL64518BIN.REG
  del PERL64518BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL64518BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

perl64518 - execute perlscript on ActivePerl x64 5.18 or Strawbery Perl x64 5.18 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<perl64518> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl x64 5.18 and other version of perl are on the one
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

     Z:\strawberry\Perl64518\bin\perl.exe
     Y:\strawberry\Perl64518\bin\perl.exe
     X:\strawberry\Perl64518\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl64518\bin\perl.exe

When found it at last, set its path to environment variable PERL64518BIN.

=head1 EXAMPLES

    C:\> perl64518 foo.pl
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

Strawberry Perl
http://strawberryperl.com/

=cut

:END
