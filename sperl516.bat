@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  sperl516 - execute perlscript on Strawbery Perl 5.8 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%SPERL516BIN%" == "" goto SetWin95
  %SPERL516BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET SPERL516BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET SPERL516BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable SPERL516BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=Z:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist Y:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=Y:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist X:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=X:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist W:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=W:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist V:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=V:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist U:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=U:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist T:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=T:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist S:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=S:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist R:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=R:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist Q:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=Q:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist P:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=P:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist O:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=O:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist N:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=N:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist M:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=M:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist L:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=L:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist K:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=K:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist J:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=J:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist I:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=I:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist H:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=H:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist G:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=G:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist F:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=F:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist E:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=E:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist D:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=D:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$
  if exist C:\strawberry\Perl516\bin\perl.exe echo SET SPERL516BIN=C:\strawberry\Perl516\bin\perl.exe>SPERL516BIN.$$$

  if exist SPERL516BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl516\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable SPERL516BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type SPERL516BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type SPERL516BIN.$$$ >> C:\AUTOEXEC.BAT
  del SPERL516BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL516BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%SPERL516BIN%" == "" goto SetWinNT
  %SPERL516BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="Z:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist Y:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="Y:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist X:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="X:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist W:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="W:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist V:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="V:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist U:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="U:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist T:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="T:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist S:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="S:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist R:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="R:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist Q:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="Q:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist P:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="P:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist O:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="O:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist N:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="N:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist M:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="M:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist L:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="L:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist K:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="K:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist J:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="J:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist I:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="I:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist H:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="H:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist G:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="G:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist F:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="F:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist E:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="E:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist D:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="D:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$
  if exist C:\strawberry\Perl516\bin\perl.exe echo "SPERL516BIN"="C:\\strawberry\\Perl516\\bin\\perl.exe">SPERL516BIN.$$$

  if exist SPERL516BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl516\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable SPERL516BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type SPERL516BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>SPERL516BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>SPERL516BIN.REG
  echo.>>SPERL516BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>SPERL516BIN.REG
  type SPERL516BIN.$$$ >> SPERL516BIN.REG
  SPERL516BIN.REG
  del SPERL516BIN.REG
  del SPERL516BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL516BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

sperl516 - execute perlscript on Strawbery Perl 5.8 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<sperl516> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl5.16 and other version of perl are on the one
computer. Do not set perl5.16's bin directory to %PATH%.

It is necessary to install perl5.16 in "\Perl516\bin" directory of the drive of
either. This software is executed by perl5.16, and find the perl5.16 and execute it.

 Find perl5.16 order by,
     Z:\strawberry\Perl516\bin\perl.exe
     Y:\strawberry\Perl516\bin\perl.exe
     X:\strawberry\Perl516\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl516\bin\perl.exe

When found it at last, set its path to environment variable SPERL516BIN.

=head1 EXAMPLES

    C:\> sperl516 foo.pl
    [..execute foo.pl by perl5.16..]

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
