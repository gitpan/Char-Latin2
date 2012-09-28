@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  perl58 - execute perlscript on ActivePerl 5.8 or Strawbery Perl 5.8 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%PERL58BIN%" == "" goto SetWin95
  %PERL58BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET PERL58BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET PERL58BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable PERL58BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl58\bin\perl.exe echo SET PERL58BIN=Z:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist Y:\Perl58\bin\perl.exe echo SET PERL58BIN=Y:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist X:\Perl58\bin\perl.exe echo SET PERL58BIN=X:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist W:\Perl58\bin\perl.exe echo SET PERL58BIN=W:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist V:\Perl58\bin\perl.exe echo SET PERL58BIN=V:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist U:\Perl58\bin\perl.exe echo SET PERL58BIN=U:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist T:\Perl58\bin\perl.exe echo SET PERL58BIN=T:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist S:\Perl58\bin\perl.exe echo SET PERL58BIN=S:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist R:\Perl58\bin\perl.exe echo SET PERL58BIN=R:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist Q:\Perl58\bin\perl.exe echo SET PERL58BIN=Q:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist P:\Perl58\bin\perl.exe echo SET PERL58BIN=P:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist O:\Perl58\bin\perl.exe echo SET PERL58BIN=O:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist N:\Perl58\bin\perl.exe echo SET PERL58BIN=N:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist M:\Perl58\bin\perl.exe echo SET PERL58BIN=M:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist L:\Perl58\bin\perl.exe echo SET PERL58BIN=L:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist K:\Perl58\bin\perl.exe echo SET PERL58BIN=K:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist J:\Perl58\bin\perl.exe echo SET PERL58BIN=J:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist I:\Perl58\bin\perl.exe echo SET PERL58BIN=I:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist H:\Perl58\bin\perl.exe echo SET PERL58BIN=H:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist G:\Perl58\bin\perl.exe echo SET PERL58BIN=G:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist F:\Perl58\bin\perl.exe echo SET PERL58BIN=F:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist E:\Perl58\bin\perl.exe echo SET PERL58BIN=E:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist D:\Perl58\bin\perl.exe echo SET PERL58BIN=D:\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist C:\Perl58\bin\perl.exe echo SET PERL58BIN=C:\Perl58\bin\perl.exe>PERL58BIN.$$$

  if exist Z:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=Z:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist Y:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=Y:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist X:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=X:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist W:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=W:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist V:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=V:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist U:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=U:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist T:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=T:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist S:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=S:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist R:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=R:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist Q:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=Q:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist P:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=P:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist O:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=O:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist N:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=N:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist M:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=M:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist L:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=L:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist K:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=K:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist J:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=J:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist I:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=I:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist H:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=H:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist G:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=G:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist F:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=F:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist E:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=E:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist D:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=D:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$
  if exist C:\strawberry\Perl58\bin\perl.exe echo SET PERL58BIN=C:\strawberry\Perl58\bin\perl.exe>PERL58BIN.$$$

  if exist PERL58BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl58\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable PERL58BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type PERL58BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type PERL58BIN.$$$ >> C:\AUTOEXEC.BAT
  del PERL58BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL58BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%PERL58BIN%" == "" goto SetWinNT
  %PERL58BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl58\bin\perl.exe echo "PERL58BIN"="Z:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist Y:\Perl58\bin\perl.exe echo "PERL58BIN"="Y:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist X:\Perl58\bin\perl.exe echo "PERL58BIN"="X:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist W:\Perl58\bin\perl.exe echo "PERL58BIN"="W:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist V:\Perl58\bin\perl.exe echo "PERL58BIN"="V:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist U:\Perl58\bin\perl.exe echo "PERL58BIN"="U:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist T:\Perl58\bin\perl.exe echo "PERL58BIN"="T:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist S:\Perl58\bin\perl.exe echo "PERL58BIN"="S:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist R:\Perl58\bin\perl.exe echo "PERL58BIN"="R:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist Q:\Perl58\bin\perl.exe echo "PERL58BIN"="Q:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist P:\Perl58\bin\perl.exe echo "PERL58BIN"="P:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist O:\Perl58\bin\perl.exe echo "PERL58BIN"="O:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist N:\Perl58\bin\perl.exe echo "PERL58BIN"="N:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist M:\Perl58\bin\perl.exe echo "PERL58BIN"="M:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist L:\Perl58\bin\perl.exe echo "PERL58BIN"="L:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist K:\Perl58\bin\perl.exe echo "PERL58BIN"="K:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist J:\Perl58\bin\perl.exe echo "PERL58BIN"="J:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist I:\Perl58\bin\perl.exe echo "PERL58BIN"="I:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist H:\Perl58\bin\perl.exe echo "PERL58BIN"="H:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist G:\Perl58\bin\perl.exe echo "PERL58BIN"="G:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist F:\Perl58\bin\perl.exe echo "PERL58BIN"="F:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist E:\Perl58\bin\perl.exe echo "PERL58BIN"="E:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist D:\Perl58\bin\perl.exe echo "PERL58BIN"="D:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist C:\Perl58\bin\perl.exe echo "PERL58BIN"="C:\\Perl58\\bin\\perl.exe">PERL58BIN.$$$

  if exist Z:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="Z:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist Y:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="Y:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist X:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="X:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist W:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="W:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist V:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="V:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist U:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="U:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist T:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="T:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist S:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="S:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist R:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="R:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist Q:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="Q:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist P:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="P:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist O:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="O:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist N:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="N:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist M:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="M:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist L:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="L:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist K:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="K:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist J:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="J:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist I:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="I:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist H:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="H:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist G:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="G:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist F:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="F:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist E:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="E:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist D:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="D:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$
  if exist C:\strawberry\Perl58\bin\perl.exe echo "PERL58BIN"="C:\\strawberry\\Perl58\\bin\\perl.exe">PERL58BIN.$$$

  if exist PERL58BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl58\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable PERL58BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type PERL58BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>PERL58BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>PERL58BIN.REG
  echo.>>PERL58BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>PERL58BIN.REG
  type PERL58BIN.$$$ >> PERL58BIN.REG
  PERL58BIN.REG
  del PERL58BIN.REG
  del PERL58BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL58BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

perl58 - execute perlscript on ActivePerl 5.8 or Strawbery Perl 5.8 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<perl58> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl 5.8 and other version of perl are on the one
computer. Do not set perl 5.8's bin directory to %PATH%.

It is necessary to install perl 5.8 in "\Perl58\bin" directory of the drive of
either. This software is executed by perl 5.8, and find the perl 5.8 and execute it.

 Find perl 5.8 order by,
     Z:\Perl58\bin\perl.exe
     Y:\Perl58\bin\perl.exe
     X:\Perl58\bin\perl.exe
                 :
                 :
     C:\Perl58\bin\perl.exe

     Z:\strawberry\Perl58\bin\perl.exe
     Y:\strawberry\Perl58\bin\perl.exe
     X:\strawberry\Perl58\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl58\bin\perl.exe

When found it at last, set its path to environment variable PERL58BIN.

=head1 EXAMPLES

    C:\> perl58 foo.pl
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

ActivePerl
http://www.activestate.com/activeperl

Strawberry Perl
http://strawberryperl.com/

=cut

:END
