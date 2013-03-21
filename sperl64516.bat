@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  sperl64516 - execute perlscript on Strawbery Perl x64 5.16 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012, 2013 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%SPERL64516BIN%" == "" goto SetWin95
  %SPERL64516BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET SPERL64516BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET SPERL64516BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable SPERL64516BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=Z:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist Y:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=Y:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist X:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=X:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist W:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=W:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist V:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=V:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist U:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=U:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist T:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=T:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist S:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=S:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist R:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=R:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist Q:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=Q:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist P:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=P:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist O:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=O:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist N:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=N:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist M:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=M:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist L:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=L:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist K:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=K:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist J:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=J:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist I:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=I:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist H:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=H:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist G:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=G:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist F:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=F:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist E:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=E:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist D:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=D:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$
  if exist C:\strawberry\Perl64516\bin\perl.exe echo SET SPERL64516BIN=C:\strawberry\Perl64516\bin\perl.exe>SPERL64516BIN.$$$

  if exist SPERL64516BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl64516\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable SPERL64516BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type SPERL64516BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  type SPERL64516BIN.$$$ >> C:\AUTOEXEC.BAT
  del SPERL64516BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL64516BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%SPERL64516BIN%" == "" goto SetWinNT
  %SPERL64516BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="Z:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist Y:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="Y:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist X:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="X:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist W:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="W:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist V:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="V:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist U:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="U:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist T:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="T:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist S:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="S:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist R:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="R:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist Q:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="Q:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist P:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="P:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist O:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="O:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist N:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="N:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist M:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="M:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist L:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="L:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist K:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="K:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist J:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="J:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist I:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="I:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist H:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="H:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist G:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="G:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist F:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="F:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist E:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="E:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist D:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="D:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$
  if exist C:\strawberry\Perl64516\bin\perl.exe echo "SPERL64516BIN"="C:\\strawberry\\Perl64516\\bin\\perl.exe">SPERL64516BIN.$$$

  if exist SPERL64516BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl64516\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable SPERL64516BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type SPERL64516BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>SPERL64516BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>SPERL64516BIN.REG
  echo.>>SPERL64516BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>SPERL64516BIN.REG
  type SPERL64516BIN.$$$ >> SPERL64516BIN.REG
  SPERL64516BIN.REG
  del SPERL64516BIN.REG
  del SPERL64516BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL64516BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

sperl64516 - execute perlscript on Strawbery Perl x64 5.16 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<sperl64516> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl x64 5.16 and other version of perl are on the one
computer. Do not set perl x64 5.16's bin directory to %PATH%.

It is necessary to install perl x64 5.16 in "\Perl64516\bin" directory of the drive of
either. This software is executed by perl x64 5.16, and find the perl x64 5.16 and execute it.

 Find perl x64 5.16 order by,
     Z:\strawberry\Perl64516\bin\perl.exe
     Y:\strawberry\Perl64516\bin\perl.exe
     X:\strawberry\Perl64516\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl64516\bin\perl.exe

When found it at last, set its path to environment variable SPERL64516BIN.

=head1 EXAMPLES

    C:\> sperl64516 foo.pl
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

Strawberry Perl
http://strawberryperl.com/

=cut

:END
