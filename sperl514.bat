@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  sperl514 - execute perlscript on Strawbery Perl 5.14 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%SPERL514BIN%" == "" goto SetWin95
  %SPERL514BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET SPERL514BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET SPERL514BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable SPERL514BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=Z:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist Y:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=Y:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist X:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=X:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist W:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=W:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist V:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=V:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist U:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=U:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist T:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=T:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist S:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=S:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist R:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=R:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist Q:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=Q:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist P:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=P:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist O:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=O:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist N:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=N:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist M:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=M:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist L:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=L:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist K:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=K:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist J:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=J:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist I:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=I:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist H:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=H:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist G:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=G:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist F:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=F:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist E:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=E:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist D:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=D:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$
  if exist C:\strawberry\Perl514\bin\perl.exe echo SET SPERL514BIN=C:\strawberry\Perl514\bin\perl.exe>SPERL514BIN.$$$

  if exist SPERL514BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl514\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable SPERL514BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type SPERL514BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type SPERL514BIN.$$$ >> C:\AUTOEXEC.BAT
  del SPERL514BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL514BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%SPERL514BIN%" == "" goto SetWinNT
  %SPERL514BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="Z:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist Y:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="Y:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist X:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="X:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist W:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="W:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist V:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="V:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist U:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="U:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist T:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="T:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist S:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="S:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist R:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="R:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist Q:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="Q:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist P:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="P:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist O:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="O:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist N:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="N:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist M:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="M:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist L:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="L:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist K:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="K:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist J:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="J:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist I:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="I:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist H:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="H:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist G:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="G:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist F:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="F:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist E:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="E:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist D:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="D:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$
  if exist C:\strawberry\Perl514\bin\perl.exe echo "SPERL514BIN"="C:\\strawberry\\Perl514\\bin\\perl.exe">SPERL514BIN.$$$

  if exist SPERL514BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl514\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable SPERL514BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type SPERL514BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>SPERL514BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>SPERL514BIN.REG
  echo.>>SPERL514BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>SPERL514BIN.REG
  type SPERL514BIN.$$$ >> SPERL514BIN.REG
  SPERL514BIN.REG
  del SPERL514BIN.REG
  del SPERL514BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL514BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

sperl514 - execute perlscript on Strawbery Perl 5.14 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<sperl514> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl 5.14 and other version of perl are on the one
computer. Do not set perl 5.14's bin directory to %PATH%.

It is necessary to install perl 5.14 in "\Perl514\bin" directory of the drive of
either. This software is executed by perl 5.14, and find the perl 5.14 and execute it.

 Find perl 5.14 order by,
     Z:\strawberry\Perl514\bin\perl.exe
     Y:\strawberry\Perl514\bin\perl.exe
     X:\strawberry\Perl514\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl514\bin\perl.exe

When found it at last, set its path to environment variable SPERL514BIN.

=head1 EXAMPLES

    C:\> sperl514 foo.pl
    [..execute foo.pl by perl 5.14..]

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
