@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  sperl64518 - execute perlscript on Strawbery Perl x64 5.18 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012, 2013 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%SPERL64518BIN%" == "" goto SetWin95
  %SPERL64518BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET SPERL64518BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET SPERL64518BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable SPERL64518BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=Z:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist Y:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=Y:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist X:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=X:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist W:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=W:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist V:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=V:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist U:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=U:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist T:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=T:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist S:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=S:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist R:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=R:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist Q:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=Q:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist P:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=P:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist O:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=O:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist N:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=N:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist M:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=M:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist L:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=L:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist K:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=K:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist J:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=J:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist I:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=I:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist H:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=H:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist G:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=G:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist F:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=F:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist E:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=E:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist D:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=D:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$
  if exist C:\strawberry\Perl64518\bin\perl.exe echo SET SPERL64518BIN=C:\strawberry\Perl64518\bin\perl.exe>SPERL64518BIN.$$$

  if exist SPERL64518BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl64518\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable SPERL64518BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type SPERL64518BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  type SPERL64518BIN.$$$ >> C:\AUTOEXEC.BAT
  del SPERL64518BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL64518BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%SPERL64518BIN%" == "" goto SetWinNT
  %SPERL64518BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="Z:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist Y:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="Y:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist X:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="X:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist W:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="W:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist V:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="V:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist U:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="U:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist T:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="T:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist S:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="S:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist R:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="R:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist Q:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="Q:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist P:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="P:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist O:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="O:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist N:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="N:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist M:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="M:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist L:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="L:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist K:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="K:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist J:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="J:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist I:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="I:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist H:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="H:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist G:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="G:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist F:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="F:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist E:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="E:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist D:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="D:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$
  if exist C:\strawberry\Perl64518\bin\perl.exe echo "SPERL64518BIN"="C:\\strawberry\\Perl64518\\bin\\perl.exe">SPERL64518BIN.$$$

  if exist SPERL64518BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl64518\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable SPERL64518BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type SPERL64518BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>SPERL64518BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>SPERL64518BIN.REG
  echo.>>SPERL64518BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>SPERL64518BIN.REG
  type SPERL64518BIN.$$$ >> SPERL64518BIN.REG
  SPERL64518BIN.REG
  del SPERL64518BIN.REG
  del SPERL64518BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL64518BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

sperl64518 - execute perlscript on Strawbery Perl x64 5.18 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<sperl64518> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl x64 5.18 and other version of perl are on the one
computer. Do not set perl x64 5.18's bin directory to %PATH%.

It is necessary to install perl x64 5.18 in "\Perl64518\bin" directory of the drive of
either. This software is executed by perl x64 5.18, and find the perl x64 5.18 and execute it.

 Find perl x64 5.18 order by,
     Z:\strawberry\Perl64518\bin\perl.exe
     Y:\strawberry\Perl64518\bin\perl.exe
     X:\strawberry\Perl64518\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl64518\bin\perl.exe

When found it at last, set its path to environment variable SPERL64518BIN.

=head1 EXAMPLES

    C:\> sperl64518 foo.pl
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

Strawberry Perl
http://strawberryperl.com/

=cut

:END
