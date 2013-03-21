@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  perl55 - execute perlscript on ActivePerl 5.5 or Strawbery Perl 5.5 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012, 2013 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%PERL55BIN%" == "" goto SetWin95
  %PERL55BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET PERL55BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET PERL55BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable PERL55BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl55\bin\perl.exe echo SET PERL55BIN=Z:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist Y:\Perl55\bin\perl.exe echo SET PERL55BIN=Y:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist X:\Perl55\bin\perl.exe echo SET PERL55BIN=X:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist W:\Perl55\bin\perl.exe echo SET PERL55BIN=W:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist V:\Perl55\bin\perl.exe echo SET PERL55BIN=V:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist U:\Perl55\bin\perl.exe echo SET PERL55BIN=U:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist T:\Perl55\bin\perl.exe echo SET PERL55BIN=T:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist S:\Perl55\bin\perl.exe echo SET PERL55BIN=S:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist R:\Perl55\bin\perl.exe echo SET PERL55BIN=R:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist Q:\Perl55\bin\perl.exe echo SET PERL55BIN=Q:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist P:\Perl55\bin\perl.exe echo SET PERL55BIN=P:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist O:\Perl55\bin\perl.exe echo SET PERL55BIN=O:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist N:\Perl55\bin\perl.exe echo SET PERL55BIN=N:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist M:\Perl55\bin\perl.exe echo SET PERL55BIN=M:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist L:\Perl55\bin\perl.exe echo SET PERL55BIN=L:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist K:\Perl55\bin\perl.exe echo SET PERL55BIN=K:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist J:\Perl55\bin\perl.exe echo SET PERL55BIN=J:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist I:\Perl55\bin\perl.exe echo SET PERL55BIN=I:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist H:\Perl55\bin\perl.exe echo SET PERL55BIN=H:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist G:\Perl55\bin\perl.exe echo SET PERL55BIN=G:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist F:\Perl55\bin\perl.exe echo SET PERL55BIN=F:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist E:\Perl55\bin\perl.exe echo SET PERL55BIN=E:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist D:\Perl55\bin\perl.exe echo SET PERL55BIN=D:\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist C:\Perl55\bin\perl.exe echo SET PERL55BIN=C:\Perl55\bin\perl.exe>PERL55BIN.$$$

  if exist Z:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=Z:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist Y:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=Y:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist X:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=X:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist W:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=W:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist V:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=V:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist U:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=U:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist T:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=T:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist S:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=S:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist R:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=R:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist Q:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=Q:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist P:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=P:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist O:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=O:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist N:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=N:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist M:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=M:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist L:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=L:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist K:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=K:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist J:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=J:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist I:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=I:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist H:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=H:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist G:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=G:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist F:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=F:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist E:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=E:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist D:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=D:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$
  if exist C:\strawberry\Perl55\bin\perl.exe echo SET PERL55BIN=C:\strawberry\Perl55\bin\perl.exe>PERL55BIN.$$$

  if exist PERL55BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl55\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable PERL55BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type PERL55BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  type PERL55BIN.$$$ >> C:\AUTOEXEC.BAT
  del PERL55BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL55BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%PERL55BIN%" == "" goto SetWinNT
  %PERL55BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl55\bin\perl.exe echo "PERL55BIN"="Z:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist Y:\Perl55\bin\perl.exe echo "PERL55BIN"="Y:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist X:\Perl55\bin\perl.exe echo "PERL55BIN"="X:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist W:\Perl55\bin\perl.exe echo "PERL55BIN"="W:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist V:\Perl55\bin\perl.exe echo "PERL55BIN"="V:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist U:\Perl55\bin\perl.exe echo "PERL55BIN"="U:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist T:\Perl55\bin\perl.exe echo "PERL55BIN"="T:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist S:\Perl55\bin\perl.exe echo "PERL55BIN"="S:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist R:\Perl55\bin\perl.exe echo "PERL55BIN"="R:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist Q:\Perl55\bin\perl.exe echo "PERL55BIN"="Q:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist P:\Perl55\bin\perl.exe echo "PERL55BIN"="P:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist O:\Perl55\bin\perl.exe echo "PERL55BIN"="O:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist N:\Perl55\bin\perl.exe echo "PERL55BIN"="N:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist M:\Perl55\bin\perl.exe echo "PERL55BIN"="M:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist L:\Perl55\bin\perl.exe echo "PERL55BIN"="L:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist K:\Perl55\bin\perl.exe echo "PERL55BIN"="K:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist J:\Perl55\bin\perl.exe echo "PERL55BIN"="J:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist I:\Perl55\bin\perl.exe echo "PERL55BIN"="I:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist H:\Perl55\bin\perl.exe echo "PERL55BIN"="H:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist G:\Perl55\bin\perl.exe echo "PERL55BIN"="G:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist F:\Perl55\bin\perl.exe echo "PERL55BIN"="F:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist E:\Perl55\bin\perl.exe echo "PERL55BIN"="E:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist D:\Perl55\bin\perl.exe echo "PERL55BIN"="D:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist C:\Perl55\bin\perl.exe echo "PERL55BIN"="C:\\Perl55\\bin\\perl.exe">PERL55BIN.$$$

  if exist Z:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="Z:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist Y:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="Y:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist X:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="X:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist W:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="W:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist V:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="V:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist U:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="U:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist T:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="T:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist S:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="S:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist R:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="R:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist Q:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="Q:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist P:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="P:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist O:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="O:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist N:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="N:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist M:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="M:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist L:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="L:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist K:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="K:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist J:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="J:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist I:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="I:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist H:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="H:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist G:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="G:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist F:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="F:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist E:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="E:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist D:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="D:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$
  if exist C:\strawberry\Perl55\bin\perl.exe echo "PERL55BIN"="C:\\strawberry\\Perl55\\bin\\perl.exe">PERL55BIN.$$$

  if exist PERL55BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl55\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable PERL55BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type PERL55BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>PERL55BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>PERL55BIN.REG
  echo.>>PERL55BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>PERL55BIN.REG
  type PERL55BIN.$$$ >> PERL55BIN.REG
  PERL55BIN.REG
  del PERL55BIN.REG
  del PERL55BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL55BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

perl55 - execute perlscript on ActivePerl 5.5 or Strawbery Perl 5.5 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<perl55> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl 5.5 and other version of perl are on the one
computer. Do not set perl 5.5's bin directory to %PATH%.

It is necessary to install perl 5.5 in "\Perl55\bin" directory of the drive of
either. This software is executed by perl 5.5, and find the perl 5.5 and execute it.

 Find perl 5.5 order by,
     Z:\Perl55\bin\perl.exe
     Y:\Perl55\bin\perl.exe
     X:\Perl55\bin\perl.exe
                 :
                 :
     C:\Perl55\bin\perl.exe

     Z:\strawberry\Perl55\bin\perl.exe
     Y:\strawberry\Perl55\bin\perl.exe
     X:\strawberry\Perl55\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl55\bin\perl.exe

When found it at last, set its path to environment variable PERL55BIN.

=head1 EXAMPLES

    C:\> perl55 foo.pl
    [..execute foo.pl by perl 5.5..]

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
