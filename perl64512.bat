@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  perl64512 - execute perlscript on ActivePerl x64 5.12 or Strawbery Perl x64 5.12 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012, 2013 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%PERL64512BIN%" == "" goto SetWin95
  %PERL64512BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET PERL64512BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET PERL64512BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable PERL64512BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl64512\bin\perl.exe echo SET PERL64512BIN=Z:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist Y:\Perl64512\bin\perl.exe echo SET PERL64512BIN=Y:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist X:\Perl64512\bin\perl.exe echo SET PERL64512BIN=X:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist W:\Perl64512\bin\perl.exe echo SET PERL64512BIN=W:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist V:\Perl64512\bin\perl.exe echo SET PERL64512BIN=V:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist U:\Perl64512\bin\perl.exe echo SET PERL64512BIN=U:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist T:\Perl64512\bin\perl.exe echo SET PERL64512BIN=T:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist S:\Perl64512\bin\perl.exe echo SET PERL64512BIN=S:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist R:\Perl64512\bin\perl.exe echo SET PERL64512BIN=R:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist Q:\Perl64512\bin\perl.exe echo SET PERL64512BIN=Q:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist P:\Perl64512\bin\perl.exe echo SET PERL64512BIN=P:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist O:\Perl64512\bin\perl.exe echo SET PERL64512BIN=O:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist N:\Perl64512\bin\perl.exe echo SET PERL64512BIN=N:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist M:\Perl64512\bin\perl.exe echo SET PERL64512BIN=M:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist L:\Perl64512\bin\perl.exe echo SET PERL64512BIN=L:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist K:\Perl64512\bin\perl.exe echo SET PERL64512BIN=K:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist J:\Perl64512\bin\perl.exe echo SET PERL64512BIN=J:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist I:\Perl64512\bin\perl.exe echo SET PERL64512BIN=I:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist H:\Perl64512\bin\perl.exe echo SET PERL64512BIN=H:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist G:\Perl64512\bin\perl.exe echo SET PERL64512BIN=G:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist F:\Perl64512\bin\perl.exe echo SET PERL64512BIN=F:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist E:\Perl64512\bin\perl.exe echo SET PERL64512BIN=E:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist D:\Perl64512\bin\perl.exe echo SET PERL64512BIN=D:\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist C:\Perl64512\bin\perl.exe echo SET PERL64512BIN=C:\Perl64512\bin\perl.exe>PERL64512BIN.$$$

  if exist Z:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=Z:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist Y:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=Y:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist X:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=X:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist W:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=W:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist V:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=V:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist U:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=U:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist T:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=T:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist S:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=S:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist R:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=R:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist Q:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=Q:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist P:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=P:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist O:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=O:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist N:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=N:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist M:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=M:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist L:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=L:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist K:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=K:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist J:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=J:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist I:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=I:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist H:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=H:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist G:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=G:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist F:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=F:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist E:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=E:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist D:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=D:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$
  if exist C:\strawberry\Perl64512\bin\perl.exe echo SET PERL64512BIN=C:\strawberry\Perl64512\bin\perl.exe>PERL64512BIN.$$$

  if exist PERL64512BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl64512\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable PERL64512BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type PERL64512BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  type PERL64512BIN.$$$ >> C:\AUTOEXEC.BAT
  del PERL64512BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL64512BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%PERL64512BIN%" == "" goto SetWinNT
  %PERL64512BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl64512\bin\perl.exe echo "PERL64512BIN"="Z:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist Y:\Perl64512\bin\perl.exe echo "PERL64512BIN"="Y:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist X:\Perl64512\bin\perl.exe echo "PERL64512BIN"="X:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist W:\Perl64512\bin\perl.exe echo "PERL64512BIN"="W:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist V:\Perl64512\bin\perl.exe echo "PERL64512BIN"="V:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist U:\Perl64512\bin\perl.exe echo "PERL64512BIN"="U:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist T:\Perl64512\bin\perl.exe echo "PERL64512BIN"="T:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist S:\Perl64512\bin\perl.exe echo "PERL64512BIN"="S:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist R:\Perl64512\bin\perl.exe echo "PERL64512BIN"="R:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist Q:\Perl64512\bin\perl.exe echo "PERL64512BIN"="Q:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist P:\Perl64512\bin\perl.exe echo "PERL64512BIN"="P:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist O:\Perl64512\bin\perl.exe echo "PERL64512BIN"="O:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist N:\Perl64512\bin\perl.exe echo "PERL64512BIN"="N:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist M:\Perl64512\bin\perl.exe echo "PERL64512BIN"="M:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist L:\Perl64512\bin\perl.exe echo "PERL64512BIN"="L:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist K:\Perl64512\bin\perl.exe echo "PERL64512BIN"="K:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist J:\Perl64512\bin\perl.exe echo "PERL64512BIN"="J:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist I:\Perl64512\bin\perl.exe echo "PERL64512BIN"="I:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist H:\Perl64512\bin\perl.exe echo "PERL64512BIN"="H:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist G:\Perl64512\bin\perl.exe echo "PERL64512BIN"="G:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist F:\Perl64512\bin\perl.exe echo "PERL64512BIN"="F:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist E:\Perl64512\bin\perl.exe echo "PERL64512BIN"="E:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist D:\Perl64512\bin\perl.exe echo "PERL64512BIN"="D:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist C:\Perl64512\bin\perl.exe echo "PERL64512BIN"="C:\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$

  if exist Z:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="Z:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist Y:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="Y:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist X:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="X:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist W:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="W:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist V:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="V:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist U:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="U:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist T:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="T:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist S:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="S:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist R:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="R:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist Q:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="Q:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist P:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="P:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist O:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="O:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist N:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="N:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist M:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="M:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist L:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="L:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist K:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="K:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist J:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="J:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist I:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="I:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist H:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="H:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist G:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="G:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist F:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="F:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist E:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="E:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist D:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="D:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$
  if exist C:\strawberry\Perl64512\bin\perl.exe echo "PERL64512BIN"="C:\\strawberry\\Perl64512\\bin\\perl.exe">PERL64512BIN.$$$

  if exist PERL64512BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl64512\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable PERL64512BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type PERL64512BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  rem homemade setx command for portability
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>PERL64512BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>PERL64512BIN.REG
  echo.>>PERL64512BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>PERL64512BIN.REG
  type PERL64512BIN.$$$ >> PERL64512BIN.REG
  PERL64512BIN.REG
  del PERL64512BIN.REG
  del PERL64512BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL64512BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

perl64512 - execute perlscript on ActivePerl x64 5.12 or Strawbery Perl x64 5.12 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<perl64512> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl x64 5.12 and other version of perl are on the one
computer. Do not set perl x64 5.12's bin directory to %PATH%.

It is necessary to install perl x64 5.12 in "\Perl64512\bin" directory of the drive of
either. This software is executed by perl x64 5.12, and find the perl x64 5.12 and execute it.

 Find perl x64 5.12 order by,
     Z:\Perl64512\bin\perl.exe
     Y:\Perl64512\bin\perl.exe
     X:\Perl64512\bin\perl.exe
                 :
                 :
     C:\Perl64512\bin\perl.exe

     Z:\strawberry\Perl64512\bin\perl.exe
     Y:\strawberry\Perl64512\bin\perl.exe
     X:\strawberry\Perl64512\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl64512\bin\perl.exe

When found it at last, set its path to environment variable PERL64512BIN.

=head1 EXAMPLES

    C:\> perl64512 foo.pl
    [..execute foo.pl by perl x64 5.12..]

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
