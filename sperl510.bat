@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  sperl510 - execute perlscript on Strawbery Perl 5.10 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%SPERL510BIN%" == "" goto SetWin95
  %SPERL510BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET SPERL510BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET SPERL510BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable SPERL510BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=Z:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist Y:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=Y:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist X:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=X:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist W:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=W:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist V:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=V:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist U:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=U:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist T:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=T:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist S:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=S:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist R:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=R:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist Q:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=Q:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist P:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=P:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist O:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=O:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist N:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=N:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist M:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=M:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist L:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=L:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist K:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=K:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist J:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=J:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist I:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=I:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist H:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=H:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist G:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=G:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist F:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=F:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist E:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=E:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist D:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=D:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$
  if exist C:\strawberry\Perl510\bin\perl.exe echo SET SPERL510BIN=C:\strawberry\Perl510\bin\perl.exe>SPERL510BIN.$$$

  if exist SPERL510BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl510\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable SPERL510BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type SPERL510BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type SPERL510BIN.$$$ >> C:\AUTOEXEC.BAT
  del SPERL510BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL510BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%SPERL510BIN%" == "" goto SetWinNT
  %SPERL510BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="Z:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist Y:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="Y:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist X:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="X:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist W:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="W:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist V:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="V:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist U:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="U:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist T:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="T:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist S:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="S:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist R:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="R:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist Q:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="Q:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist P:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="P:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist O:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="O:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist N:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="N:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist M:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="M:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist L:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="L:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist K:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="K:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist J:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="J:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist I:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="I:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist H:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="H:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist G:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="G:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist F:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="F:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist E:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="E:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist D:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="D:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$
  if exist C:\strawberry\Perl510\bin\perl.exe echo "SPERL510BIN"="C:\\strawberry\\Perl510\\bin\\perl.exe">SPERL510BIN.$$$

  if exist SPERL510BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl510\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable SPERL510BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type SPERL510BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>SPERL510BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>SPERL510BIN.REG
  echo.>>SPERL510BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>SPERL510BIN.REG
  type SPERL510BIN.$$$ >> SPERL510BIN.REG
  SPERL510BIN.REG
  del SPERL510BIN.REG
  del SPERL510BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL510BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

sperl510 - execute perlscript on Strawbery Perl 5.10 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<sperl510> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl 5.10 and other version of perl are on the one
computer. Do not set perl 5.10's bin directory to %PATH%.

It is necessary to install perl 5.10 in "\Perl510\bin" directory of the drive of
either. This software is executed by perl 5.10, and find the perl 5.10 and execute it.

 Find perl 5.10 order by,
     Z:\strawberry\Perl510\bin\perl.exe
     Y:\strawberry\Perl510\bin\perl.exe
     X:\strawberry\Perl510\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl510\bin\perl.exe

When found it at last, set its path to environment variable SPERL510BIN.

=head1 EXAMPLES

    C:\> sperl510 foo.pl
    [..execute foo.pl by perl 5.10..]

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
