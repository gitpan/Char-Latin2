@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  perl516 - execute perlscript on ActivePerl 5.16 or Strawbery Perl 5.16 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%PERL516BIN%" == "" goto SetWin95
  %PERL516BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET PERL516BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET PERL516BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable PERL516BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl516\bin\perl.exe echo SET PERL516BIN=Z:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist Y:\Perl516\bin\perl.exe echo SET PERL516BIN=Y:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist X:\Perl516\bin\perl.exe echo SET PERL516BIN=X:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist W:\Perl516\bin\perl.exe echo SET PERL516BIN=W:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist V:\Perl516\bin\perl.exe echo SET PERL516BIN=V:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist U:\Perl516\bin\perl.exe echo SET PERL516BIN=U:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist T:\Perl516\bin\perl.exe echo SET PERL516BIN=T:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist S:\Perl516\bin\perl.exe echo SET PERL516BIN=S:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist R:\Perl516\bin\perl.exe echo SET PERL516BIN=R:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist Q:\Perl516\bin\perl.exe echo SET PERL516BIN=Q:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist P:\Perl516\bin\perl.exe echo SET PERL516BIN=P:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist O:\Perl516\bin\perl.exe echo SET PERL516BIN=O:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist N:\Perl516\bin\perl.exe echo SET PERL516BIN=N:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist M:\Perl516\bin\perl.exe echo SET PERL516BIN=M:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist L:\Perl516\bin\perl.exe echo SET PERL516BIN=L:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist K:\Perl516\bin\perl.exe echo SET PERL516BIN=K:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist J:\Perl516\bin\perl.exe echo SET PERL516BIN=J:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist I:\Perl516\bin\perl.exe echo SET PERL516BIN=I:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist H:\Perl516\bin\perl.exe echo SET PERL516BIN=H:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist G:\Perl516\bin\perl.exe echo SET PERL516BIN=G:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist F:\Perl516\bin\perl.exe echo SET PERL516BIN=F:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist E:\Perl516\bin\perl.exe echo SET PERL516BIN=E:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist D:\Perl516\bin\perl.exe echo SET PERL516BIN=D:\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist C:\Perl516\bin\perl.exe echo SET PERL516BIN=C:\Perl516\bin\perl.exe>PERL516BIN.$$$

  if exist Z:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=Z:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist Y:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=Y:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist X:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=X:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist W:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=W:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist V:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=V:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist U:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=U:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist T:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=T:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist S:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=S:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist R:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=R:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist Q:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=Q:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist P:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=P:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist O:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=O:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist N:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=N:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist M:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=M:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist L:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=L:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist K:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=K:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist J:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=J:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist I:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=I:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist H:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=H:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist G:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=G:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist F:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=F:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist E:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=E:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist D:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=D:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$
  if exist C:\strawberry\Perl516\bin\perl.exe echo SET PERL516BIN=C:\strawberry\Perl516\bin\perl.exe>PERL516BIN.$$$

  if exist PERL516BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl516\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable PERL516BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type PERL516BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type PERL516BIN.$$$ >> C:\AUTOEXEC.BAT
  del PERL516BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL516BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%PERL516BIN%" == "" goto SetWinNT
  %PERL516BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl516\bin\perl.exe echo "PERL516BIN"="Z:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist Y:\Perl516\bin\perl.exe echo "PERL516BIN"="Y:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist X:\Perl516\bin\perl.exe echo "PERL516BIN"="X:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist W:\Perl516\bin\perl.exe echo "PERL516BIN"="W:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist V:\Perl516\bin\perl.exe echo "PERL516BIN"="V:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist U:\Perl516\bin\perl.exe echo "PERL516BIN"="U:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist T:\Perl516\bin\perl.exe echo "PERL516BIN"="T:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist S:\Perl516\bin\perl.exe echo "PERL516BIN"="S:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist R:\Perl516\bin\perl.exe echo "PERL516BIN"="R:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist Q:\Perl516\bin\perl.exe echo "PERL516BIN"="Q:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist P:\Perl516\bin\perl.exe echo "PERL516BIN"="P:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist O:\Perl516\bin\perl.exe echo "PERL516BIN"="O:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist N:\Perl516\bin\perl.exe echo "PERL516BIN"="N:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist M:\Perl516\bin\perl.exe echo "PERL516BIN"="M:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist L:\Perl516\bin\perl.exe echo "PERL516BIN"="L:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist K:\Perl516\bin\perl.exe echo "PERL516BIN"="K:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist J:\Perl516\bin\perl.exe echo "PERL516BIN"="J:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist I:\Perl516\bin\perl.exe echo "PERL516BIN"="I:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist H:\Perl516\bin\perl.exe echo "PERL516BIN"="H:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist G:\Perl516\bin\perl.exe echo "PERL516BIN"="G:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist F:\Perl516\bin\perl.exe echo "PERL516BIN"="F:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist E:\Perl516\bin\perl.exe echo "PERL516BIN"="E:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist D:\Perl516\bin\perl.exe echo "PERL516BIN"="D:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist C:\Perl516\bin\perl.exe echo "PERL516BIN"="C:\\Perl516\\bin\\perl.exe">PERL516BIN.$$$

  if exist Z:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="Z:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist Y:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="Y:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist X:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="X:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist W:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="W:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist V:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="V:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist U:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="U:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist T:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="T:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist S:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="S:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist R:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="R:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist Q:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="Q:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist P:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="P:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist O:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="O:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist N:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="N:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist M:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="M:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist L:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="L:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist K:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="K:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist J:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="J:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist I:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="I:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist H:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="H:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist G:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="G:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist F:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="F:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist E:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="E:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist D:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="D:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$
  if exist C:\strawberry\Perl516\bin\perl.exe echo "PERL516BIN"="C:\\strawberry\\Perl516\\bin\\perl.exe">PERL516BIN.$$$

  if exist PERL516BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl516\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable PERL516BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type PERL516BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>PERL516BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>PERL516BIN.REG
  echo.>>PERL516BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>PERL516BIN.REG
  type PERL516BIN.$$$ >> PERL516BIN.REG
  PERL516BIN.REG
  del PERL516BIN.REG
  del PERL516BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL516BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

perl516 - execute perlscript on ActivePerl 5.16 or Strawbery Perl 5.16 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<perl516> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl 5.16 and other version of perl are on the one
computer. Do not set perl 5.16's bin directory to %PATH%.

It is necessary to install perl 5.16 in "\Perl516\bin" directory of the drive of
either. This software is executed by perl 5.16, and find the perl 5.16 and execute it.

 Find perl 5.16 order by,
     Z:\Perl516\bin\perl.exe
     Y:\Perl516\bin\perl.exe
     X:\Perl516\bin\perl.exe
                 :
                 :
     C:\Perl516\bin\perl.exe

     Z:\strawberry\Perl516\bin\perl.exe
     Y:\strawberry\Perl516\bin\perl.exe
     X:\strawberry\Perl516\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl516\bin\perl.exe

When found it at last, set its path to environment variable PERL516BIN.

=head1 EXAMPLES

    C:\> perl516 foo.pl
    [..execute foo.pl by perl 5.16..]

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
