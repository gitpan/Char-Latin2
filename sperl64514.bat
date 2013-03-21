@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  sperl64514 - execute perlscript on Strawbery Perl x64 5.14 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012, 2013 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%SPERL64514BIN%" == "" goto SetWin95
  %SPERL64514BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET SPERL64514BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET SPERL64514BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable SPERL64514BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=Z:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist Y:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=Y:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist X:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=X:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist W:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=W:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist V:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=V:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist U:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=U:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist T:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=T:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist S:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=S:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist R:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=R:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist Q:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=Q:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist P:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=P:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist O:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=O:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist N:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=N:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist M:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=M:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist L:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=L:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist K:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=K:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist J:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=J:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist I:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=I:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist H:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=H:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist G:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=G:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist F:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=F:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist E:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=E:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist D:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=D:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$
  if exist C:\strawberry\Perl64514\bin\perl.exe echo SET SPERL64514BIN=C:\strawberry\Perl64514\bin\perl.exe>SPERL64514BIN.$$$

  if exist SPERL64514BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl64514\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable SPERL64514BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type SPERL64514BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  type SPERL64514BIN.$$$ >> C:\AUTOEXEC.BAT
  del SPERL64514BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL64514BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%SPERL64514BIN%" == "" goto SetWinNT
  %SPERL64514BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="Z:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist Y:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="Y:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist X:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="X:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist W:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="W:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist V:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="V:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist U:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="U:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist T:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="T:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist S:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="S:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist R:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="R:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist Q:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="Q:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist P:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="P:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist O:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="O:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist N:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="N:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist M:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="M:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist L:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="L:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist K:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="K:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist J:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="J:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist I:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="I:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist H:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="H:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist G:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="G:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist F:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="F:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist E:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="E:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist D:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="D:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$
  if exist C:\strawberry\Perl64514\bin\perl.exe echo "SPERL64514BIN"="C:\\strawberry\\Perl64514\\bin\\perl.exe">SPERL64514BIN.$$$

  if exist SPERL64514BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl64514\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable SPERL64514BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type SPERL64514BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>SPERL64514BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>SPERL64514BIN.REG
  echo.>>SPERL64514BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>SPERL64514BIN.REG
  type SPERL64514BIN.$$$ >> SPERL64514BIN.REG
  SPERL64514BIN.REG
  del SPERL64514BIN.REG
  del SPERL64514BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL64514BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

sperl64514 - execute perlscript on Strawbery Perl x64 5.14 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<sperl64514> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl x64 5.14 and other version of perl are on the one
computer. Do not set perl x64 5.14's bin directory to %PATH%.

It is necessary to install perl x64 5.14 in "\Perl64514\bin" directory of the drive of
either. This software is executed by perl x64 5.14, and find the perl x64 5.14 and execute it.

 Find perl x64 5.14 order by,
     Z:\strawberry\Perl64514\bin\perl.exe
     Y:\strawberry\Perl64514\bin\perl.exe
     X:\strawberry\Perl64514\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl64514\bin\perl.exe

When found it at last, set its path to environment variable SPERL64514BIN.

=head1 EXAMPLES

    C:\> sperl64514 foo.pl
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

Strawberry Perl
http://strawberryperl.com/

=cut

:END
