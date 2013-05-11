@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  sperl518 - execute perlscript on Strawbery Perl 5.18 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012, 2013 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%SPERL518BIN%" == "" goto SetWin95
  %SPERL518BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET SPERL518BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET SPERL518BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable SPERL518BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=Z:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist Y:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=Y:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist X:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=X:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist W:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=W:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist V:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=V:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist U:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=U:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist T:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=T:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist S:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=S:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist R:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=R:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist Q:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=Q:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist P:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=P:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist O:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=O:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist N:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=N:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist M:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=M:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist L:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=L:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist K:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=K:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist J:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=J:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist I:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=I:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist H:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=H:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist G:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=G:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist F:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=F:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist E:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=E:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist D:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=D:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$
  if exist C:\strawberry\Perl518\bin\perl.exe echo SET SPERL518BIN=C:\strawberry\Perl518\bin\perl.exe>SPERL518BIN.$$$

  if exist SPERL518BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl518\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable SPERL518BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type SPERL518BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  type SPERL518BIN.$$$ >> C:\AUTOEXEC.BAT
  del SPERL518BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL518BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%SPERL518BIN%" == "" goto SetWinNT
  %SPERL518BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="Z:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist Y:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="Y:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist X:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="X:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist W:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="W:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist V:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="V:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist U:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="U:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist T:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="T:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist S:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="S:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist R:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="R:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist Q:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="Q:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist P:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="P:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist O:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="O:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist N:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="N:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist M:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="M:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist L:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="L:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist K:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="K:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist J:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="J:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist I:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="I:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist H:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="H:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist G:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="G:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist F:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="F:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist E:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="E:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist D:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="D:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$
  if exist C:\strawberry\Perl518\bin\perl.exe echo "SPERL518BIN"="C:\\strawberry\\Perl518\\bin\\perl.exe">SPERL518BIN.$$$

  if exist SPERL518BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl518\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable SPERL518BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type SPERL518BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>SPERL518BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>SPERL518BIN.REG
  echo.>>SPERL518BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>SPERL518BIN.REG
  type SPERL518BIN.$$$ >> SPERL518BIN.REG
  SPERL518BIN.REG
  del SPERL518BIN.REG
  del SPERL518BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL518BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

sperl518 - execute perlscript on Strawbery Perl 5.18 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<sperl518> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl 5.18 and other version of perl are on the one
computer. Do not set perl 5.18's bin directory to %PATH%.

It is necessary to install perl 5.18 in "\Perl518\bin" directory of the drive of
either. This software is executed by perl 5.18, and find the perl 5.18 and execute it.

 Find perl 5.18 order by,
     Z:\strawberry\Perl518\bin\perl.exe
     Y:\strawberry\Perl518\bin\perl.exe
     X:\strawberry\Perl518\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl518\bin\perl.exe

When found it at last, set its path to environment variable SPERL518BIN.

=head1 EXAMPLES

    C:\> sperl518 foo.pl
    [..execute foo.pl by perl 5.18..]

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
