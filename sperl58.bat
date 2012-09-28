@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  sperl58 - execute perlscript on Strawbery Perl 5.8 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%SPERL58BIN%" == "" goto SetWin95
  %SPERL58BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET SPERL58BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET SPERL58BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable SPERL58BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=Z:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist Y:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=Y:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist X:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=X:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist W:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=W:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist V:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=V:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist U:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=U:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist T:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=T:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist S:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=S:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist R:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=R:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist Q:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=Q:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist P:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=P:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist O:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=O:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist N:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=N:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist M:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=M:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist L:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=L:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist K:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=K:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist J:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=J:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist I:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=I:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist H:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=H:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist G:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=G:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist F:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=F:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist E:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=E:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist D:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=D:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$
  if exist C:\strawberry\Perl58\bin\perl.exe echo SET SPERL58BIN=C:\strawberry\Perl58\bin\perl.exe>SPERL58BIN.$$$

  if exist SPERL58BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl58\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable SPERL58BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type SPERL58BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type SPERL58BIN.$$$ >> C:\AUTOEXEC.BAT
  del SPERL58BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL58BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%SPERL58BIN%" == "" goto SetWinNT
  %SPERL58BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="Z:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist Y:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="Y:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist X:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="X:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist W:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="W:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist V:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="V:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist U:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="U:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist T:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="T:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist S:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="S:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist R:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="R:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist Q:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="Q:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist P:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="P:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist O:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="O:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist N:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="N:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist M:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="M:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist L:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="L:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist K:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="K:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist J:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="J:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist I:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="I:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist H:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="H:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist G:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="G:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist F:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="F:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist E:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="E:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist D:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="D:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$
  if exist C:\strawberry\Perl58\bin\perl.exe echo "SPERL58BIN"="C:\\strawberry\\Perl58\\bin\\perl.exe">SPERL58BIN.$$$

  if exist SPERL58BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl58\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable SPERL58BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type SPERL58BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>SPERL58BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>SPERL58BIN.REG
  echo.>>SPERL58BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>SPERL58BIN.REG
  type SPERL58BIN.$$$ >> SPERL58BIN.REG
  SPERL58BIN.REG
  del SPERL58BIN.REG
  del SPERL58BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL58BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

sperl58 - execute perlscript on Strawbery Perl 5.8 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<sperl58> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl 5.8 and other version of perl are on the one
computer. Do not set perl 5.8's bin directory to %PATH%.

It is necessary to install perl 5.8 in "\Perl58\bin" directory of the drive of
either. This software is executed by perl 5.8, and find the perl 5.8 and execute it.

 Find perl 5.8 order by,
     Z:\strawberry\Perl58\bin\perl.exe
     Y:\strawberry\Perl58\bin\perl.exe
     X:\strawberry\Perl58\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl58\bin\perl.exe

When found it at last, set its path to environment variable SPERL58BIN.

=head1 EXAMPLES

    C:\> sperl58 foo.pl
    [..execute foo.pl by perl 5.8..]

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
