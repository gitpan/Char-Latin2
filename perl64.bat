@echo off
rem version 1.0.6
rem ======================================================================
rem 
rem  perl64 - execute perlscript on the perl64 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%PERL64BIN%" == "" goto SetWin95
  %PERL64BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET PERL64BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET PERL64BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable PERL64BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl64\bin\perl.exe echo SET PERL64BIN=Z:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist Y:\Perl64\bin\perl.exe echo SET PERL64BIN=Y:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist X:\Perl64\bin\perl.exe echo SET PERL64BIN=X:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist W:\Perl64\bin\perl.exe echo SET PERL64BIN=W:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist V:\Perl64\bin\perl.exe echo SET PERL64BIN=V:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist U:\Perl64\bin\perl.exe echo SET PERL64BIN=U:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist T:\Perl64\bin\perl.exe echo SET PERL64BIN=T:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist S:\Perl64\bin\perl.exe echo SET PERL64BIN=S:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist R:\Perl64\bin\perl.exe echo SET PERL64BIN=R:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist Q:\Perl64\bin\perl.exe echo SET PERL64BIN=Q:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist P:\Perl64\bin\perl.exe echo SET PERL64BIN=P:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist O:\Perl64\bin\perl.exe echo SET PERL64BIN=O:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist N:\Perl64\bin\perl.exe echo SET PERL64BIN=N:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist M:\Perl64\bin\perl.exe echo SET PERL64BIN=M:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist L:\Perl64\bin\perl.exe echo SET PERL64BIN=L:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist K:\Perl64\bin\perl.exe echo SET PERL64BIN=K:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist J:\Perl64\bin\perl.exe echo SET PERL64BIN=J:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist I:\Perl64\bin\perl.exe echo SET PERL64BIN=I:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist H:\Perl64\bin\perl.exe echo SET PERL64BIN=H:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist G:\Perl64\bin\perl.exe echo SET PERL64BIN=G:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist F:\Perl64\bin\perl.exe echo SET PERL64BIN=F:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist E:\Perl64\bin\perl.exe echo SET PERL64BIN=E:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist D:\Perl64\bin\perl.exe echo SET PERL64BIN=D:\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist C:\Perl64\bin\perl.exe echo SET PERL64BIN=C:\Perl64\bin\perl.exe>PERL64BIN.$$$

  if exist Z:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=Z:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist Y:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=Y:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist X:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=X:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist W:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=W:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist V:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=V:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist U:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=U:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist T:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=T:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist S:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=S:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist R:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=R:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist Q:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=Q:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist P:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=P:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist O:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=O:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist N:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=N:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist M:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=M:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist L:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=L:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist K:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=K:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist J:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=J:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist I:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=I:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist H:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=H:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist G:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=G:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist F:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=F:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist E:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=E:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist D:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=D:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$
  if exist C:\strawberry\Perl64\bin\perl.exe echo SET PERL64BIN=C:\strawberry\Perl64\bin\perl.exe>PERL64BIN.$$$

  if exist PERL64BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl64\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable PERL64BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type PERL64BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type PERL64BIN.$$$ >> C:\AUTOEXEC.BAT
  del PERL64BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL64BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%PERL64BIN%" == "" goto SetWinNT
  %PERL64BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl64\bin\perl.exe echo "PERL64BIN"="Z:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist Y:\Perl64\bin\perl.exe echo "PERL64BIN"="Y:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist X:\Perl64\bin\perl.exe echo "PERL64BIN"="X:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist W:\Perl64\bin\perl.exe echo "PERL64BIN"="W:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist V:\Perl64\bin\perl.exe echo "PERL64BIN"="V:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist U:\Perl64\bin\perl.exe echo "PERL64BIN"="U:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist T:\Perl64\bin\perl.exe echo "PERL64BIN"="T:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist S:\Perl64\bin\perl.exe echo "PERL64BIN"="S:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist R:\Perl64\bin\perl.exe echo "PERL64BIN"="R:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist Q:\Perl64\bin\perl.exe echo "PERL64BIN"="Q:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist P:\Perl64\bin\perl.exe echo "PERL64BIN"="P:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist O:\Perl64\bin\perl.exe echo "PERL64BIN"="O:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist N:\Perl64\bin\perl.exe echo "PERL64BIN"="N:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist M:\Perl64\bin\perl.exe echo "PERL64BIN"="M:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist L:\Perl64\bin\perl.exe echo "PERL64BIN"="L:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist K:\Perl64\bin\perl.exe echo "PERL64BIN"="K:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist J:\Perl64\bin\perl.exe echo "PERL64BIN"="J:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist I:\Perl64\bin\perl.exe echo "PERL64BIN"="I:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist H:\Perl64\bin\perl.exe echo "PERL64BIN"="H:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist G:\Perl64\bin\perl.exe echo "PERL64BIN"="G:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist F:\Perl64\bin\perl.exe echo "PERL64BIN"="F:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist E:\Perl64\bin\perl.exe echo "PERL64BIN"="E:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist D:\Perl64\bin\perl.exe echo "PERL64BIN"="D:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist C:\Perl64\bin\perl.exe echo "PERL64BIN"="C:\\Perl64\\bin\\perl.exe">PERL64BIN.$$$

  if exist Z:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="Z:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist Y:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="Y:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist X:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="X:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist W:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="W:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist V:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="V:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist U:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="U:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist T:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="T:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist S:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="S:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist R:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="R:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist Q:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="Q:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist P:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="P:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist O:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="O:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist N:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="N:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist M:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="M:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist L:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="L:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist K:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="K:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist J:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="J:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist I:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="I:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist H:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="H:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist G:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="G:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist F:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="F:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist E:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="E:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist D:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="D:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$
  if exist C:\strawberry\Perl64\bin\perl.exe echo "PERL64BIN"="C:\\strawberry\\Perl64\\bin\\perl.exe">PERL64BIN.$$$

  if exist PERL64BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl64\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable PERL64BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type PERL64BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>PERL64BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>PERL64BIN.REG
  echo.>>PERL64BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>PERL64BIN.REG
  type PERL64BIN.$$$ >> PERL64BIN.REG
  PERL64BIN.REG
  del PERL64BIN.REG
  del PERL64BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL64BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

perl64 - execute perlscript on the perl64 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<perl64> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl64 and other version of perl are on the one
computer. Do not set perl64's bin directory to %PATH%.

It is necessary to install perl64 in "\Perl64\bin" directory of the drive of
either. This software is executed by perl64, and find the perl64 and execute it.

 Find perl64 order by,
     Z:\Perl64\bin\perl.exe
     Y:\Perl64\bin\perl.exe
     X:\Perl64\bin\perl.exe
                 :
                 :
     C:\Perl64\bin\perl.exe

     Z:\strawberry\Perl64\bin\perl.exe
     Y:\strawberry\Perl64\bin\perl.exe
     X:\strawberry\Perl64\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl64\bin\perl.exe

When found it at last, set its path to environment variable PERL64BIN.

=head1 EXAMPLES

    C:\> perl64 foo.pl
    [..execute foo.pl by perl64..]

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

perl

=cut

:END
